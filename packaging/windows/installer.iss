; BiliLiveTool Inno Setup 安装脚本
; 在 CI 中自动替换以下变量:
;   {#AppVersion}  - 从 VERSION 文件读取

#define MyAppName "B站直播工具"
#define MyAppPublisher "BiliLiveTool Open Source"
#define MyAppURL "https://github.com/wsyb/bilibili_live_stream_code"
#define MyAppExeName "BiliLiveTool.exe"

[Setup]
AppId={{B7E8F3A2-1D5C-4A6B-9F0E-8D3C2B7A1E5F}
AppName={#MyAppName}
AppVersion={#AppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=BiliLiveTool-{#AppVersion}-windows-amd64-Setup
SetupIconFile=bilibili.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible

[Languages]
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "快捷方式:"; Flags: checkedonce

[Files]
Source: "..\..\dist\BiliLiveTool.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\bilibili.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\卸载 {#MyAppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "运行 B站直播工具"; Flags: postinstall nowait skipifsilent
