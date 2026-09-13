# agent-config

个人 Agent 配置仓库，用于版本化、同步和迁移长期有效的全局协作规则、跨项目工程基线与可复用 Agent Skills。

`AGENTS.md` 继续作为 Codex 全局工程原则的唯一事实源；跨项目可复用的代码/测试基线放在 `standards/`；可重复的软件交付流程放入独立 Skill。避免把全局规则膨胀成任务操作手册，也避免在 Notion、Chat 和仓库中维护多套流程事实源。

## Repository structure

```text
agent-config/
├── AGENTS.md                         # Codex 全局工程原则
├── standards/                        # 项目缺少明确规范时的 fallback baseline
│   ├── code-quality.md
│   └── testing.md
├── skills/
│   └── development-flow/             # 跨 Chat / Agent 的 Agentic SDLC
│       ├── SKILL.md
│       ├── references/
│       │   └── workflow.md
│       ├── prompts/                  # 各阶段可直接复用的执行 Prompt
│       │   ├── requirement.md
│       │   ├── requirement-audit.md
│       │   ├── plan.md
│       │   ├── plan-audit.md
│       │   ├── test-design.md
│       │   ├── test-review.md
│       │   ├── slice-implement.md
│       │   ├── goal-implement.md
│       │   ├── independent-review.md
│       │   ├── fix.md
│       │   ├── re-review.md
│       │   └── acceptance.md
│       └── assets/                   # 业务仓库 Task Packet 模板
├── README.md
└── scripts/
    └── install-codex.sh
```

## Scope

### `AGENTS.md`

只放跨项目长期有效的工程原则，例如：

- 事实与证据优先；
- 最小、渐进、可回滚的改动；
- Action Gate 与设计决策控制；
- Change Safety；
- 风险驱动验证；
- Code Review 标准；
- 文档沉淀与 Delegation 原则。

以下内容不应进入全局规则：

- 某个项目的目录约束、依赖方向或技术栈规则；
- 某个项目的 API、数据模型、部署方式；
- 临时排查经验；
- 尚未确认的偏好或实验性规则；
- API Key、Token、Credential、机器私有路径等敏感或设备相关配置。

项目特定规则应继续保留在对应项目自己的 `AGENTS.md` 中。

### `standards/`

提供目标项目没有明确等价规范时的跨项目 fallback。

继承优先级固定为：

```text
项目显式规则
→ 项目已经稳定形成的语言/框架惯例
→ agent-config fallback baseline
```

当前只维护真正跨技术栈稳定的两份基线：

- `code-quality.md`：KISS、模块边界、单一事实源、错误语义、依赖/重构约束、Agent 生成代码可维护性等；
- `testing.md`：行为证据、Failure Challenge、测试层级、mock/fixture 边界、false-green 风险、回归验证等。

不要为了“完整”提前创建大量语言级规范。只有在多个真实项目中重复出现稳定规则时，再增加 TypeScript、Python、GDScript 等技术栈规范。

### `skills/development-flow`

用于需要跨多个 Chat、Agent 或角色持续执行的软件任务。Skill 定义流程和 Gate，但不保存某个业务任务的运行状态。

v0.2 主流程：

```text
Requirement
→ Requirement Audit
→ Plan
→ Plan Audit
→ PLAN FREEZE
→ Test Design / Test Cases
→ Test Review
→ DELIVERY FREEZE
→ Slice Execution | Goal Execution
→ Self Verification
→ Independent Review
→ Fix
→ Re-review
→ Acceptance
→ DONE
```

两个 Freeze 的含义不同：

- `PLAN FREEZE`：Requirement + Plan 成为设计基线；测试阶段可以挑战，但不能静默改写。
- `DELIVERY FREEZE`：Requirement + Plan + Test Contract 共同成为实现授权边界；Implementer 可以决定 HOW，但不能重新定义 WHAT。

Independent Review 与 Re-review 也必须区分：第一次进行完整独立审计；后续 Re-review 主要检查上一轮 finding closure、fixing diff 和直接回归，避免每轮重新打开整个问题空间。

Review finding 记录来源类型：

- `I` — `IMPLEMENTATION_DEFECT`
- `P` — `PLAN_OR_SPEC_DEFECT`
- `R` — `REVIEW_MISS`
- `D` — `DISCOVERY`

不要只用 CR 轮数衡量 Implementer 质量。

具体任务状态应保存在业务仓库：

```text
.agent/tasks/<task-id>/
├── state.yaml
├── requirement.md
├── implementation-plan.md
├── test-contract.md
└── review.md
```

新的 Chat / Agent 应从 Git 中恢复 Phase、Freeze、合同、验证证据、finding 与下一步，而不是依赖聊天记忆。

当前版本仍刻意不提供 CLI、自动状态机或 GitHub Actions Gate。先在真实项目中验证协议和 Prompt，再根据重复出现的问题增加自动化。

## Install on a new machine

```bash
git clone git@github.com:TaurusWood/agent-config.git ~/agent-config
cd ~/agent-config
bash scripts/install-codex.sh
```

安装脚本会：

1. 使用 `${CODEX_HOME:-$HOME/.codex}` 作为 Codex home；
2. 如果已有真实的 `AGENTS.md`、`standards` 或同名 Skill，先备份而不是覆盖；
3. 创建指向本仓库 `AGENTS.md` 的符号链接；
4. 将 `standards/` 链接到 `${CODEX_HOME}/standards`；
5. 将 `skills/development-flow` 链接到 `${CODEX_HOME}/skills/development-flow`。

之后更新规则和 Skill 只需要：

```bash
cd ~/agent-config
git pull
```

## Maintenance principles

### Keep global rules stable

只有满足以下条件的规则才应进入 `AGENTS.md`：

1. 跨多个项目成立；
2. 在未来较长时间内仍然有效；
3. 能实际改变 Agent 的决策或执行质量；
4. 不依赖某个项目的局部上下文。

### Keep fallback standards conservative

fallback 只解决“项目没有规范时 Agent 应该如何写出可维护代码/测试”，不与成熟项目争夺规则权。

标准应优先描述稳定工程属性，而不是个人风格偏好。

### Keep skills procedural

Skill 应解决可重复的“怎么做”，而不是吞入某个项目或某个任务的事实。

如果一条规则只对特定项目成立，放回项目；如果只对某个 Task 成立，写入 Task Packet。

### Prefer deletion over accumulation

不要把每次失败都变成一条新规则。优先判断问题属于：

- 模型偶发失误；
- 项目局部约束；
- Task Contract 不完整；
- Skill 流程缺陷；
- fallback 标准缺失；
- 真正缺失的长期工程原则。

只有最后几类在多次实践中稳定复现时才值得进入本仓库长期维护。

### Evolve with evidence

修改全局规则、标准或 Skill 时尽量让 commit 说明“为什么改变行为”，而不只是描述文字变化。

继续通过真实项目验证：

- Plan Freeze 是否减少测试阶段的静默设计漂移；
- Test Review 是否降低 false-green；
- Slice / Goal routing 是否降低实现成本；
- `I / P / R / D` 分布是否能解释多轮 CR 的真正来源；
- bounded Re-review 是否改善 review convergence。

再根据证据决定是否引入 CLI、schema validator、自动指标或 GitHub Actions。
