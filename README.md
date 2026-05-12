# dotfiles

Mac 环境一键迁移。通过 GitHub 同步配置，通过 mackup + iCloud 同步 app 设置。

## 一键安装（新 Mac）

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhuofeng-Li/dotfiles/main/bootstrap.sh)"
```

## 同步内容

### CLI 工具
| 工具 | 说明 |
|------|------|
| fish | Shell |
| node | Node.js |
| gh | GitHub CLI |
| uv | Python 包管理 |
| gemini-cli | Gemini CLI |
| openjdk@17 | Java 17 |

### GUI 应用
| 应用 | 说明 |
|------|------|
| Alfred | 启动器 |
| Anki | 记忆卡片 |
| ChatGPT | OpenAI 客户端 |
| Claude | Anthropic 客户端 |
| Cursor | AI 编辑器 |
| Dropbox | 云存储 |
| f.lux | 护眼色温 |
| Google Chrome | 浏览器 |
| Hidden Bar | 菜单栏整理 |
| IINA | 视频播放器 |
| Karabiner-Elements | 键盘改键 |
| MacTeX | LaTeX |
| Miniconda | Python 环境 |
| Notion | 笔记 |
| Rectangle | 窗口管理 |
| Scroll Reverser | 滚动方向 |
| SimpleTex | 公式识别 |
| Snipaste | 截图贴图 |
| 腾讯会议 | 会议 |
| TickTick | 待办 |
| WeChat | 微信 |
| XMind | 思维导图 |
| Zoom | 会议 |

### Cursor 设置与插件
`cursor/settings.json` 和 `cursor/keybindings.json`，软链接到 `~/Library/Application Support/Cursor/User/`。在 Cursor 里修改设置后直接 `git push` 即可同步。

插件列表保存在 `cursor/extensions.txt`（共 24 个），`bootstrap.sh` 会自动批量安装。也可单独运行：

```bash
bash ~/dotfiles/cursor/install-extensions.sh
```

更新插件列表：

```bash
cursor --list-extensions > ~/dotfiles/cursor/extensions.txt
```

### Karabiner 键位配置
`karabiner/karabiner.json` 及自定义规则，软链接到 `~/.config/karabiner`。

### Fish Shell 配置
`fish/config.fish`，包含 conda 初始化等。

### App 偏好设置（mackup + iCloud）
Cursor 设置、Git 配置、fish 配置、Claude Code 设置、f.lux 偏好等。mackup 将这些设置备份到 iCloud Drive，新机器运行 `mackup restore` 恢复。

### 需要手动安装
以下应用暂无 Homebrew Cask，需手动下载：
- 幕布：[mubu.com](https://mubu.com)
- Mathpix Snipping Tool
- Input Source Pro
- WPS Office：[wpsoffice.cn](https://www.wpsoffice.cn)
- 百度网盘
- Typeless

## 更新配置

```bash
cd ~/dotfiles
git add .
git commit -m "..."
git push

# 另一台 Mac 拉取：
git -C ~/dotfiles pull
```

## 文件结构

```
dotfiles/
├── Brewfile              # 所有 brew/cask/vscode 包
├── bootstrap.sh          # 一键安装脚本
├── mackup.cfg            # mackup 配置（iCloud 存储）
├── fish/
│   └── config.fish       # Fish shell 配置
├── cursor/
│   ├── settings.json         # Cursor 设置
│   ├── keybindings.json      # Cursor 快捷键
│   ├── extensions.txt        # 插件列表
│   └── install-extensions.sh # 单独安装插件
└── karabiner/
    ├── karabiner.json    # Karabiner 主配置
    └── assets/           # 自定义改键规则
```
