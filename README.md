# agent-config

个人 Agent 配置仓库，用于版本化、同步和迁移长期有效的全局协作规则。

当前只维护 Codex 的全局指令，保持单一事实源。只有在出现真实的多 Agent 复用需求后，才拆分公共规则和各 Agent adapter。

## Repository structure

```text
agent-config/
├── AGENTS.md          # Codex 全局指令的唯一事实源
├── README.md
└── scripts/
    └── install-codex.sh
```

## Scope

`AGENTS.md` 只放跨项目长期有效的工程原则，例如：

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

## Install on a new machine

```bash
git clone git@github.com:TaurusWood/agent-config.git ~/agent-config
cd ~/agent-config
./scripts/install-codex.sh
```

安装脚本会：

1. 使用 `${CODEX_HOME:-$HOME/.codex}` 作为 Codex home；
2. 如果已有真实的 `AGENTS.md`，先备份而不是覆盖；
3. 创建指向本仓库 `AGENTS.md` 的符号链接。

之后更新规则只需要：

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

### Prefer deletion over accumulation

不要把每次失败都变成一条新规则。优先判断问题属于：

- 模型偶发失误；
- 项目局部约束；
- Prompt/任务描述不足；
- 真正缺失的长期工程原则。

只有最后一类通常值得进入全局规则。

### Evolve with evidence

修改全局规则时尽量让 commit 说明“为什么改变行为”，而不只是描述文字变化。

推荐使用类似：

```text
refine: narrow review findings to current change set
refine: require evidence before architecture decisions
remove: drop redundant implementation guidance
```

这样 Git 历史本身可以用于追踪 Agent 行为变化。

## Future evolution

在真正需要第二种 Agent 时，再考虑演化为：

```text
agent-config/
├── rules/             # 跨 Agent 的稳定原则
├── adapters/
│   ├── codex/
│   └── <other-agent>/
└── scripts/
```

不要为了潜在的未来迁移提前引入生成器、模板系统或同步框架。
