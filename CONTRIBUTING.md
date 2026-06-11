# 贡献指南

感谢你考虑为 Bilibili 直播工具贡献代码！以下是参与贡献的指引。

## 行为准则

请保持友善和建设性的沟通。任何形式的歧视、骚扰或不专业行为都是不被允许的。

## 如何贡献

### 报告 Bug

1. 在 [Issues](https://github.com/wsyb/bilibili_live_stream_code/issues) 中搜索是否已有类似报告
2. 如果不存在，请新建 Issue，并包含：
   - 问题的清晰描述
   - 复现步骤
   - 预期行为与实际行为
   - 截图（如有）
   - 运行环境（操作系统、Python 版本等）

### 提交功能建议

在 [Issues](https://github.com/wsyb/bilibili_live_stream_code/issues) 中新建标签为 `enhancement` 的 Issue，描述你的想法和使用场景。

### 提交 Pull Request

1. Fork 本仓库
2. 创建特性分支：`git checkout -b feat/my-feature`
3. 提交更改：`git commit -m "feat: add my feature"`
4. 推送到你的仓库：`git push origin feat/my-feature`
5. 提交 Pull Request

## 开发环境搭建

```bash
# 克隆你的 fork
git clone https://github.com/你的用户名/bilibili_live_stream_code.git
cd bilibili_live_stream_code

# 构建前端
cd frontend
npm install
npm run build
cd ..

# 安装后端依赖
pip install -r requirements.txt

# 运行
python main.py
```

### 前端热重载开发

```bash
cd frontend
npm run dev
```

然后在 `main.py` 中将前端 URL 指向开发服务器（默认 `http://localhost:5173`）。

## 编码规范

### 提交信息格式

遵循 [Conventional Commits](https://www.conventionalcommits.org/)：

```
<类型>: <简短描述>

<详细描述（可选）>
```

类型包括：
- `feat` — 新功能
- `fix` — Bug 修复
- `docs` — 文档
- `style` — 代码格式（不影响功能）
- `refactor` — 重构
- `perf` — 性能优化
- `test` — 测试
- `chore` — 构建/工具

### Python

- 遵循 PEP 8
- 类型提示是加分项，但不是强制要求
- 日志使用 `logging` 模块，不要用 `print`

### Vue / JavaScript

- 使用 Vue 3 Composition API (`<script setup>`)
- 组件名称使用 PascalCase
- CSS 变量优先于硬编码颜色值

## CI/CD

本项目使用 GitHub Actions 进行自动构建。推送 `v*` 标签会触发多平台打包发布。

```bash
git tag -a v2.4.0 -m "v2.4.0"
git push origin v2.4.0
```

详见 [HANDOVER.md](HANDOVER.md)（面向维护者的 CI/CD 交接文档）。
