; =========================================
; Current Native Host Installer
; =========================================

[Setup]
AppName=Current Native Host
AppVersion=0.1.0
DefaultDirName=C:\current-native-host
DisableDirPage=yes
OutputBaseFilename=current-native-host-installer
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest

; -----------------------------------------
; 组件（复选框）
; -----------------------------------------
[Components]
Name: "idea"; Description: "IntelliJ IDEA"; Types: full custom
Name: "webstorm"; Description: "WebStorm"; Types: full custom
Name: "goland"; Description: "GoLand"; Types: full custom

; -----------------------------------------
; 文件
; -----------------------------------------
[Files]
Source: "dist\current-native-host.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\com.current.native.host.json"; DestDir: "{app}"; Flags: ignoreversion

; -----------------------------------------
; 注册 Chrome Native Messaging Host
; -----------------------------------------
[Registry]
Root: HKCU; \
Subkey: "Software\Google\Chrome\NativeMessagingHosts\com.current.native.host"; \
ValueType: string; \
ValueName: ""; \
ValueData: "{app}\com.current.native.host.json"; \
Flags: uninsdeletekey


; -----------------------------------------
; Custom Protocol current-opener:// (per-user)
; -----------------------------------------
Root: HKCU; Subkey: "Software\Classes\current-opener"; \
    ValueType: string; ValueName: ""; \
    ValueData: "URL:Current Opener Protocol"; \
    Flags: uninsdeletekey

Root: HKCU; Subkey: "Software\Classes\current-opener"; \
    ValueType: string; ValueName: "URL Protocol"; \
    ValueData: ""

Root: HKCU; Subkey: "Software\Classes\current-opener\shell\open\command"; \
    ValueType: string; ValueName: ""; \
    ValueData: """{app}\current-native-host.exe"" ""%1"""
    

; =====================================
; 文件右键 - GenerateLocationLink
; =====================================
; 顶级菜单
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "生成 知识 链接"
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink"; \
    ValueType: string; ValueName: "SubCommands"; ValueData: ""
; === 系统默认打开 ===
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\default"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用系统默认打开"
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\default\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate default"
; === IDEA ===
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\idea"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用 IDEA 打开"
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\idea\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate idea"
; === WebStorm ===
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\webstorm"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用 WebStorm 打开"
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\webstorm\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate webstorm"
; === Goland ===
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\goland"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用 Goland 打开"
Root: HKCU; Subkey: "Software\Classes\*\shell\GenerateLocationLink\shell\goland\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate goland" 
    
    
; ============================================
; Directory 右键菜单 - GenerateLocationLink
; ============================================
; 顶级菜单
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "生成 知识 链接"; \
    Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink"; \
    ValueType: string; ValueName: "SubCommands"; ValueData: ""
; === 系统默认打开 ===
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\default"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用系统默认打开"
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\default\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate default"
; === IDEA ===
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\idea"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用 IDEA 打开"
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\idea\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate idea"
; === WebStorm ===
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\webstorm"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用 WebStorm 打开"
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\webstorm\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate webstorm"
; === GoLand ===
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\goland"; \
    ValueType: string; ValueName: "MUIVerb"; ValueData: "用 GoLand 打开"
Root: HKCU; Subkey: "Software\Classes\Directory\shell\GenerateLocationLink\shell\goland\command"; \
    ValueType: string; ValueData: """{app}\current-native-host.exe"" ""%1"" generate goland"



; =========================================
; 代码
; =========================================
[Code]

var
  IdePage: TWizardPage;

  IdeaPathEdit: TEdit;
  IdeaBrowseBtn: TButton;

  WebStormPathEdit: TEdit;
  WebStormBrowseBtn: TButton;

  GoLandPathEdit: TEdit;
  GoLandBrowseBtn: TButton;
  
  IdeaLabel: TLabel;
  WebStormLabel: TLabel;
  GoLandLabel: TLabel;


{ ===== 前向声明（必须有 forward） ===== }
procedure BrowseIdea(Sender: TObject); forward;
procedure BrowseWebStorm(Sender: TObject); forward;
procedure BrowseGoLand(Sender: TObject); forward;

{ ===== 自动检测 IDE 路径 ===== }

function FindFileInDirectory(const Dir, Pattern: string): string;
var
  FindRec: TFindRec;
  FilePath: string;
begin
  Result := '';
  
  if FindFirst(AddBackslash(Dir) + Pattern, FindRec) then
  begin
    try
      repeat
        if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
        begin
          FilePath := AddBackslash(Dir) + FindRec.Name;
          Result := FilePath;
          Break;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
end;

function SearchInJetBrainsFolder(const IDEName: string): string;
var
  BaseDir: string;
  FindRec: TFindRec;
  SubDir: string;
  ExePath: string;
begin
  Result := '';
  BaseDir := 'C:\Program Files\JetBrains';
  
  if not DirExists(BaseDir) then
    Exit;
  
  // 查找以 IDEName 开头的文件夹（如 IntelliJ IDEA 2023.3）
  if FindFirst(AddBackslash(BaseDir) + IDEName + '*', FindRec) then
  begin
    try
      repeat
        if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
        begin
          if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
          begin
            SubDir := AddBackslash(BaseDir) + FindRec.Name + '\bin';
            if DirExists(SubDir) then
            begin
              // 查找 64 位可执行文件
              if IDEName = 'IntelliJ IDEA' then
                ExePath := FindFileInDirectory(SubDir, 'idea64.exe')
              else if IDEName = 'WebStorm' then
                ExePath := FindFileInDirectory(SubDir, 'webstorm64.exe')
              else if IDEName = 'GoLand' then
                ExePath := FindFileInDirectory(SubDir, 'goland64.exe');
              
              if ExePath <> '' then
              begin
                Result := ExePath;
                Break;
              end;
            end;
          end;
        end;
      until not FindNext(FindRec);
    finally
      FindClose(FindRec);
    end;
  end;
end;

function DetectIDEFromRegistry(const RegKeyPattern: string): string;
var
  Names: TArrayOfString;
  I: Integer;
  InstallLocation: string;
  ExePath: string;
begin
  Result := '';
  
  // 尝试从 HKLM 读取
  if RegGetSubkeyNames(HKLM, RegKeyPattern, Names) then
  begin
    for I := 0 to GetArrayLength(Names) - 1 do
    begin
      if RegQueryStringValue(HKLM, RegKeyPattern + '\' + Names[I], '', InstallLocation) then
      begin
        if DirExists(InstallLocation) then
        begin
          ExePath := AddBackslash(InstallLocation) + 'bin';
          
          if Pos('IntelliJ IDEA', RegKeyPattern) > 0 then
            ExePath := FindFileInDirectory(ExePath, 'idea64.exe')
          else if Pos('WebStorm', RegKeyPattern) > 0 then
            ExePath := FindFileInDirectory(ExePath, 'webstorm64.exe')
          else if Pos('GoLand', RegKeyPattern) > 0 then
            ExePath := FindFileInDirectory(ExePath, 'goland64.exe');
          
          if ExePath <> '' then
          begin
            Result := ExePath;
            Break;
          end;
        end;
      end;
    end;
  end;
  
  // 如果 HKLM 没找到，尝试 HKCU
  if Result = '' then
  begin
    if RegGetSubkeyNames(HKCU, RegKeyPattern, Names) then
    begin
      for I := 0 to GetArrayLength(Names) - 1 do
      begin
        if RegQueryStringValue(HKCU, RegKeyPattern + '\' + Names[I], '', InstallLocation) then
        begin
          if DirExists(InstallLocation) then
          begin
            ExePath := AddBackslash(InstallLocation) + 'bin';
            
            if Pos('IntelliJ IDEA', RegKeyPattern) > 0 then
              ExePath := FindFileInDirectory(ExePath, 'idea64.exe')
            else if Pos('WebStorm', RegKeyPattern) > 0 then
              ExePath := FindFileInDirectory(ExePath, 'webstorm64.exe')
            else if Pos('GoLand', RegKeyPattern) > 0 then
              ExePath := FindFileInDirectory(ExePath, 'goland64.exe');
            
            if ExePath <> '' then
            begin
              Result := ExePath;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function AutoDetectIDEPath(const IDEName: string): string;
var
  RegKeyPattern: string;
begin
  Result := '';
  
  // 1. 首先尝试从注册表检测
  if IDEName = 'IntelliJ IDEA' then
    RegKeyPattern := 'SOFTWARE\JetBrains\IntelliJ IDEA'
  else if IDEName = 'WebStorm' then
    RegKeyPattern := 'SOFTWARE\JetBrains\WebStorm'
  else if IDEName = 'GoLand' then
    RegKeyPattern := 'SOFTWARE\JetBrains\GoLand'
  else
    Exit;
  
  Result := DetectIDEFromRegistry(RegKeyPattern);
  
  // 2. 如果注册表没找到，扫描默认安装目录
  if Result = '' then
    Result := SearchInJetBrainsFolder(IDEName);
end;

{ ===== 初始化向导 ===== }

procedure InitializeWizard;
var
  AutoDetectedPath: string;
begin
  IdePage :=
    CreateCustomPage(
      wpSelectComponents,
      'IDE 路径配置',
      '已自动检测 IDE 路径，请确认或手动修改'
    );
    
  { IntelliJ IDEA }
  IdeaLabel := TLabel.Create(IdePage);
  IdeaLabel.Parent := IdePage.Surface;
  IdeaLabel.Caption := 'IntelliJ IDEA';
  IdeaLabel.SetBounds(0, 22, 100, 21);

  IdeaPathEdit := TEdit.Create(IdePage);
  IdeaPathEdit.Parent := IdePage.Surface;
  IdeaPathEdit.SetBounds(110, 20, 360, 28);
  
  // 自动检测并填充路径
  AutoDetectedPath := AutoDetectIDEPath('IntelliJ IDEA');
  if AutoDetectedPath <> '' then
    IdeaPathEdit.Text := AutoDetectedPath;

  IdeaBrowseBtn := TButton.Create(IdePage);
  IdeaBrowseBtn.Parent := IdePage.Surface;
  IdeaBrowseBtn.Caption := '浏览...';
  IdeaBrowseBtn.SetBounds(480, 20, 80, 25);
  IdeaBrowseBtn.OnClick := @BrowseIdea;
  
  { WebStorm }
  WebStormLabel := TLabel.Create(IdePage);
  WebStormLabel.Parent := IdePage.Surface;
  WebStormLabel.Caption := 'WebStorm';
  WebStormLabel.SetBounds(0, 62, 100, 21);

  WebStormPathEdit := TEdit.Create(IdePage);
  WebStormPathEdit.Parent := IdePage.Surface;
  WebStormPathEdit.SetBounds(110, 60, 360, 28);
  
  // 自动检测并填充路径
  AutoDetectedPath := AutoDetectIDEPath('WebStorm');
  if AutoDetectedPath <> '' then
    WebStormPathEdit.Text := AutoDetectedPath;

  WebStormBrowseBtn := TButton.Create(IdePage);
  WebStormBrowseBtn.Parent := IdePage.Surface;
  WebStormBrowseBtn.Caption := '浏览...';
  WebStormBrowseBtn.SetBounds(480, 60, 80, 25);
  WebStormBrowseBtn.OnClick := @BrowseWebStorm;
  
  { GoLand }
  GoLandLabel := TLabel.Create(IdePage);
  GoLandLabel.Parent := IdePage.Surface;
  GoLandLabel.Caption := 'GoLand';
  GoLandLabel.SetBounds(0, 102, 100, 21);

  GoLandPathEdit := TEdit.Create(IdePage);
  GoLandPathEdit.Parent := IdePage.Surface;
  GoLandPathEdit.SetBounds(110, 100, 360, 28);
  
  // 自动检测并填充路径
  AutoDetectedPath := AutoDetectIDEPath('GoLand');
  if AutoDetectedPath <> '' then
    GoLandPathEdit.Text := AutoDetectedPath;

  GoLandBrowseBtn := TButton.Create(IdePage);
  GoLandBrowseBtn.Parent := IdePage.Surface;
  GoLandBrowseBtn.Caption := '浏览...';
  GoLandBrowseBtn.SetBounds(480, 100, 80, 25);
  GoLandBrowseBtn.OnClick := @BrowseGoLand;
end;

{ ===== 验证函数 ===== }

function ValidateIDEExe(const Path, Keyword: string): Boolean;
var
  FileName: string;
begin
  Result := False;
  
  if Path = '' then
    Exit;
    
  if not FileExists(Path) then
    Exit;
  
  FileName := LowerCase(ExtractFileName(Path));
  Result := Pos(LowerCase(Keyword), FileName) > 0;
end;

{ ===== 浏览按钮事件 ===== }

procedure BrowseIdea(Sender: TObject);
var
  Path: string;
begin
  Path := IdeaPathEdit.Text;
  if GetOpenFileName(
       '选择 idea64.exe',
       Path,
       '',
       'Executable files (*.exe)|*.exe',
       ''
     ) then
  begin
    if not ValidateIDEExe(Path, 'idea') then
    begin
      MsgBox('请选择正确的 IntelliJ IDEA 可执行文件 (idea64.exe)', mbError, MB_OK);
      Exit;
    end;

    IdeaPathEdit.Text := Path;
  end;
end;

procedure BrowseWebStorm(Sender: TObject);
var
  Path: string;
begin
  Path := WebStormPathEdit.Text;
  if GetOpenFileName(
       '选择 webstorm64.exe',
       Path,
       '',
       'Executable files (*.exe)|*.exe',
       ''
     ) then
  begin
    if not ValidateIDEExe(Path, 'webstorm') then
    begin
      MsgBox('请选择正确的 WebStorm 可执行文件 (webstorm64.exe)', mbError, MB_OK);
      Exit;
    end;

    WebStormPathEdit.Text := Path;
  end;
end;

procedure BrowseGoLand(Sender: TObject);
var
  Path: string;
begin
  Path := GoLandPathEdit.Text;
  if GetOpenFileName(
       '选择 goland64.exe',
       Path,
       '',
       'Executable files (*.exe)|*.exe',
       ''
     ) then
  begin
    if not ValidateIDEExe(Path, 'goland') then
    begin
      MsgBox('请选择正确的 GoLand 可执行文件 (goland64.exe)', mbError, MB_OK);
      Exit;
    end;

    GoLandPathEdit.Text := Path;
  end;
end;

{ ===== 布局控制 ===== }

procedure LayoutIdeControls;
var
  Y: Integer;
begin
  Y := 20;

  IdeaLabel.Visible := False;
  IdeaPathEdit.Visible := False;
  IdeaBrowseBtn.Visible := False;

  WebStormLabel.Visible := False;
  WebStormPathEdit.Visible := False;
  WebStormBrowseBtn.Visible := False;

  GoLandLabel.Visible := False;
  GoLandPathEdit.Visible := False;
  GoLandBrowseBtn.Visible := False;

  if IsComponentSelected('idea') then
  begin
    IdeaLabel.SetBounds(0, Y + 2, 100, 21);
    IdeaPathEdit.SetBounds(110, Y, 360, 28);
    IdeaBrowseBtn.SetBounds(480, Y, 80, 25);

    IdeaLabel.Visible := True;
    IdeaPathEdit.Visible := True;
    IdeaBrowseBtn.Visible := True;

    Y := Y + 40;
  end;

  if IsComponentSelected('webstorm') then
  begin
    WebStormLabel.SetBounds(0, Y + 2, 100, 21);
    WebStormPathEdit.SetBounds(110, Y, 360, 28);
    WebStormBrowseBtn.SetBounds(480, Y, 80, 25);

    WebStormLabel.Visible := True;
    WebStormPathEdit.Visible := True;
    WebStormBrowseBtn.Visible := True;

    Y := Y + 40;
  end;

  if IsComponentSelected('goland') then
  begin
    GoLandLabel.SetBounds(0, Y + 2, 100, 21);
    GoLandPathEdit.SetBounds(110, Y, 360, 28);
    GoLandBrowseBtn.SetBounds(480, Y, 80, 25);

    GoLandLabel.Visible := True;
    GoLandPathEdit.Visible := True;
    GoLandBrowseBtn.Visible := True;
  end;
end;

{ ===== 安装步骤事件 ===== }

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    if IsComponentSelected('idea') and (IdeaPathEdit.Text <> '') then
      RegWriteStringValue(
        HKCU,
        'Software\CurrentNativeHost\IDE',
        'IDEA',
        IdeaPathEdit.Text
      );

    if IsComponentSelected('webstorm') and (WebStormPathEdit.Text <> '') then
      RegWriteStringValue(
        HKCU,
        'Software\CurrentNativeHost\IDE',
        'WebStorm',
        WebStormPathEdit.Text
      );

    if IsComponentSelected('goland') and (GoLandPathEdit.Text <> '') then
      RegWriteStringValue(
        HKCU,
        'Software\CurrentNativeHost\IDE',
        'GoLand',
        GoLandPathEdit.Text
      );
  end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = IdePage.ID then
    LayoutIdeControls;
end;

{ ===== 下一步按钮验证 ===== }

function NextButtonClick(CurPageID: Integer): Boolean;
var
  ErrorMsg: string;
begin
  Result := True;
  
  if CurPageID = IdePage.ID then
  begin
    // 验证 IntelliJ IDEA
    if IsComponentSelected('idea') then
    begin
      if IdeaPathEdit.Text = '' then
      begin
        MsgBox('请选择 IntelliJ IDEA 的可执行文件路径', mbError, MB_OK);
        Result := False;
        Exit;
      end;
      
      if not ValidateIDEExe(IdeaPathEdit.Text, 'idea') then
      begin
        MsgBox('IntelliJ IDEA 路径不正确或文件不存在' + #13#10 + '请选择正确的 idea64.exe 文件', mbError, MB_OK);
        Result := False;
        Exit;
      end;
    end;
    
    // 验证 WebStorm
    if IsComponentSelected('webstorm') then
    begin
      if WebStormPathEdit.Text = '' then
      begin
        MsgBox('请选择 WebStorm 的可执行文件路径', mbError, MB_OK);
        Result := False;
        Exit;
      end;
      
      if not ValidateIDEExe(WebStormPathEdit.Text, 'webstorm') then
      begin
        MsgBox('WebStorm 路径不正确或文件不存在' + #13#10 + '请选择正确的 webstorm64.exe 文件', mbError, MB_OK);
        Result := False;
        Exit;
      end;
    end;
    
    // 验证 GoLand
    if IsComponentSelected('goland') then
    begin
      if GoLandPathEdit.Text = '' then
      begin
        MsgBox('请选择 GoLand 的可执行文件路径', mbError, MB_OK);
        Result := False;
        Exit;
      end;
      
      if not ValidateIDEExe(GoLandPathEdit.Text, 'goland') then
      begin
        MsgBox('GoLand 路径不正确或文件不存在' + #13#10 + '请选择正确的 goland64.exe 文件', mbError, MB_OK);
        Result := False;
        Exit;
      end;
    end;
  end;
end;




