# agent-config

个人 Agent 配置仓库，用于版本化、同步和迁移长期有效的全局协作规则与可复用 Agent Skills。

`AGENTS.md` 继续作为 Codex 全局工程原则的唯一事实源；可重复的工作流程放入独立 Skill，避免把全局规则膨胀成任务操作手册。

## Repository structure

```text
agent-config/
├── AGENTS.md                    # Codex 全局工程原则
├── skills/
│   └── development-flow/        # 跨 Chat / Agent 的软件开发流程 Skill
│       ├── SKILL.md
│       ├── references/
│       │   └── workflow.md
│       └── assets/              # 业务仓库 Task Packet 模板
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

### `skills/development-flow`

用于需要跨多个 Chat、Agent 或角色持续执行的软件任务。Skill 定义流程和 Gate，但不保存某个业务任务的运行状态。

具体任务状态应保存在业务仓库：

```text
.agent/tasks/<task-id>/
├── state.yaml
├── requirement.md
├── implementation-plan.md
├── test-contract.md
└── review.md
```

这样新的 Chat / Agent 可以从 Git 中恢复当前 Phase、合同、验证证据和下一步，而不是依赖聊天记忆。

当前版本刻意不提供 CLI、自动状态机或 GitHub Actions Gate。先在真实项目中验证协议，再根据重复出现的问题增加自动化。

## Install on a new machine

```bash
git clone git@github.com:TaurusWood/agent-config.git ~/agent-config
cd ~/agent-config
bash scripts/install-codex.sh
```

安装脚本会：

1. 使用 `${CODEX_HOME:-$HOME/.codex}` 作为 Codex home；
2. 如果已有真实的 `AGENTS.md` 或同名 Skill，先备份而不是覆盖；
3. 创建指向本仓库 `AGENTS.md` 的符号链接；
4. 将 `skills/development-flow` 链接到 `${CODEX_HOME}/skills/development-flow`。

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

### Keep skills procedural

Skill 应解决可重复的“怎么做”，而不是吞入某个项目或某个任务的事实。

如果一条规则只对特定项目成立，放回项目；如果只对某个 Task 成立，写入 Task Packet。

### Prefer deletion over accumulation

不要把每次失败都变成一条新规则。优先判断问题属于：

- 模型偶发失误；
- 项目局部约束；
- Task Contract 不完整；
- Skill 流程缺陷；
- 真正缺失的长期工程原则。

只有最后一类通常值得进入全局 `AGENTS.md`。

### Evolve with evidence

修改全局规则或 Skill 时尽量让 commit 说明“为什么改变行为”，而不只是描述文字变化。

先通过 `daily-signals`、`pocket-railway` 等真实项目积累完整 Task，再决定是否引入 CLI、schema validator、GitHub Actions 或拆分独立仓库。
