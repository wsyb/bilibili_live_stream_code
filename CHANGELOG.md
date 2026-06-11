# 更新日志

## v2.4.4 (2026-06-11)

- 跳过 macOS Intel 构建（runner 排队严重）

## v2.4.3 (2026-06-11)

- 使用 bash 安装跨平台 Python 依赖，提高 CI 稳定性

## v2.4.2 (2026-06-11)

- 修复 Windows 语言文件路径问题
- 修复 ARM64 Qt 依赖

## v2.4.1 (2026-06-11)

- 修复 ARM 依赖顺序
- 修复 Inno Setup 绝对路径问题

## v2.4.0 (2026-06-11)

### 重大更新

- **Wayland 原生支持** — 移除 X11 硬编码，适配 Ubuntu 26 (GNOME + Wayland)
- **HiDPI 高分屏缩放** — 自动检测系统缩放因子，窗口自适应
- **深色模式** — 跟随系统主题（Windows / macOS / Linux）
- **GNOME Dock 集成** — 正确显示 Dock 图标和右键菜单

### 构建系统

- 新增 ARM64 架构构建
- 支持 5 个平台架构（Windows amd64、macOS Intel/ARM、Linux amd64/ARM）
- Inno Setup 安装包（Windows）
- DMG 打包（macOS）
- AppImage + DEB 打包（Linux）

## v2.3.17 (2026-05-21)

- 修复 Linux 输入法支持问题

## v2.3.16 (2026-05-20)

- 修复字体覆盖问题

## v2.3.15 (2026-05-19)

- 修复 OBS 源检测

## v2.3.14 (2026-05-18)

- 修复 SRT 推流码支持

## v2.3.13 (2026-05-17)

- 初始版本，基础推流码获取和弹幕监控功能
