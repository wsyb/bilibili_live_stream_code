# CI/CD 构建流水线交接文档

## 项目信息

- 仓库: https://github.com/wsyb/bilibili_live_stream_code
- 分支: master
- 触发方式: 推送 `v*` 标签（如 `git tag v2.4.0 && git push origin v2.4.0`）

---

## 架构概览

GitHub Actions Workflow: `.github/workflows/release.yml`

```
打 tag v* → push
      ↓
Update VERSION (写入 VERSION 文件并提交)
      ↓
Build (并行 5 个矩阵任务)
      ↓
Create Release (汇总产物发布到 Releases 页面)
```

## 构建矩阵

| 运行器 | 架构 | 产物 1 | 产物 2 |
|--------|------|--------|--------|
| `ubuntu-22.04` | linux-amd64 | `.AppImage` | `.deb` |
| `ubuntu-24.04-arm` | linux-arm64 | `.AppImage` | `.deb` |
| `macos-13` | macos-amd64 (Intel) | `.dmg` | — |
| `macos-latest` | macos-arm64 (Apple Silicon) | `.dmg` | — |
| `windows-latest` | windows-amd64 | `Setup.exe` (Inno Setup) | — |

## 当前状态 (2026-06-11)

### ✅ 已完成的适配

| 改动 | 涉及文件 |
|------|---------|
| Wayland 兼容（移除 X11 硬编码） | `main.py` |
| HiDPI 高分屏缩放 | `main.py` |
| 暗黑模式（跟随系统，跨平台） | `main.py`, `theme.css`, 全部 Vue 组件 |
| GNOME Dock 图标 | `main.py`, `bilibili-live.desktop` |
| Dock 右键退出修复 | `main.py` |
| 构建矩阵扩展（5 平台） | `release.yml` |
| Windows Inno Setup 安装包脚本 | `packaging/windows/installer.iss` |
| macOS .dmg 打包 | `release.yml` (hdiutil) |
| Linux AppImage + .deb 打包 | `release.yml` |
| ARM64 编译依赖 | `release.yml` |

### ❌ 已知问题（需要修）

#### 问题 1: Windows Inno Setup — SetupIconFile 路径
- **步骤**: `Build Windows Installer (Inno Setup)`
- **文件**: `packaging/windows/installer.iss`
- **现象**: `Error on line 23: The system cannot find the file specified`
- **原因**: `SetupIconFile=bilibili.ico` 是相对 ISS 文件目录的，ISCC 从 `packaging/windows/` 下找，找不到
- **已尝试修复**: 改为 `SetupIconFile=..\..\bilibili.ico`（未验证）
- **验证方法**: 打 tag 跑一遍 CI 看 Windows 是否通过

#### 问题 2: macOS .dmg — hdiutil 方案未验证
- **步骤**: `Build macOS DMG`
- **原因**: 原先用 `create-dmg`（第三方），脚本结构变化导致 `No such file or directory`
- **已尝试修复**: 改用 macOS 内置 `hdiutil` 创建 DMG（未验证）
- **如果还不行**: macOS 上可以直接用 `zip -r BiliLiveTool.dmg.zip BiliLiveTool.app` 做 zip 替代 DMG

#### 问题 3: Linux ARM64 — PyQt5 源码编译失败
- **步骤**: `Install Backend Dependencies`
- **现象**: `PyProjectOptionException('qmake', ...)` — 找不到 qmake
- **原因**: PyQt5 没有 ARM64 的预编译 wheel，需要从源码编译，但编译工具链不完整
- **已尝试修复**: 安装 `qtbase5-dev` + `找到 qmake 路径建软链` + `pip install sip sip-build-tools`（未验证）
- **后备方案**: 如果 PyQt5 编译太慢/太麻烦，考虑两种方向:
  1. 在 ARM64 上跳过 PyQt5，只用 `PyQt6`（有 ARM wheel）
  2. 在 ARM64 上仅构建后端 CLI 版本（无需 GUI）

#### 问题 4: macOS Intel (macos-13) runner 排队
- 有时 `macos-13` runner 队列很长，构建可能会卡在 `queued` 状态很久
- 这是 GitHub 的免费额度限制，无法从代码层面解决

---

## 本地测试方法

### 验证 YAML 语法

```bash
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/release.yml')); print('✅ 有效')"
```

### 触发构建（需要 GitHub CLI）

```bash
gh auth login                          # 登录 GitHub
git tag -a v2.4.0 -m "v2.4.0"         # 创建标签
git push origin v2.4.0                # 推送触发 CI
```

### 查看构建状态

```bash
gh run list --repo wsyb/bilibili_live_stream_code --limit 5
gh run view <run-id> --repo wsyb/bilibili_live_stream_code
# 查看失败步骤日志:
gh run view --job <job-id> --log --repo wsyb/bilibili_live_stream_code
```

---

## 关键文件清单

| 文件 | 说明 |
|------|------|
| `.github/workflows/release.yml` | CI 主流程 |
| `packaging/windows/installer.iss` | Inno Setup 安装包脚本 |
| `packaging/linux/BiliLiveTool.desktop` | Linux 桌面快捷方式模板 |
| `packaging/linux/bilibili-live.appdata.xml` | Linux AppStream 元数据 |
| `main.py` | 应用入口（含 Wayland/暗色模式适配） |
| `frontend/src/styles/theme.css` | 主题（亮/暗色 CSS 变量） |
| `frontend/index.html` | 前端入口（含暗色模式 JS 检测） |

---

## 如果继续修的建议优先级

1. **Windows 安装包**——只差路径问题，最简单
2. **macOS .dmg**——hdiutil 方案大概率能用
3. **Linux ARM64 PyQt5**——最麻烦，可能需要换 PyQt6 或有 ARM wheel 的替代方案
4. **Release 发布**——前三修完后打 tag 验证完整流程
