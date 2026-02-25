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
; 代码 - 支持多版本 IDE 检测与选择（修复版）
; =========================================
[Code]

var
  IdePage: TWizardPage;

  IdeaPathEdit: TEdit;
  IdeaBrowseBtn: TButton;
  IdeaVersionBtn: TButton;

  WebStormPathEdit: TEdit;
  WebStormBrowseBtn: TButton;
  WebStormVersionBtn: TButton;

  GoLandPathEdit: TEdit;
  GoLandBrowseBtn: TButton;
  GoLandVersionBtn: TButton;
  
  IdeaLabel: TLabel;
  WebStormLabel: TLabel;
  GoLandLabel: TLabel;
  
  // 存储检测到的所有版本
  IdeaVersions: TStringList;
  IdeaPaths: TStringList;
  WebStormVersions: TStringList;
  WebStormPaths: TStringList;
  GoLandVersions: TStringList;
  GoLandPaths: TStringList;

{ ===== 前向声明（必须有 forward） ===== }
procedure BrowseIdea(Sender: TObject); forward;
procedure BrowseWebStorm(Sender: TObject); forward;
procedure BrowseGoLand(Sender: TObject); forward;
procedure SelectIdeaVersion(Sender: TObject); forward;
procedure SelectWebStormVersion(Sender: TObject); forward;
procedure SelectGoLandVersion(Sender: TObject); forward;

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

function ExtractVersionFromPath(const Path: string): string;
var
  DirName: string;
  I, StartPos: Integer;
begin
  Result := '';
  DirName := ExtractFileName(ExtractFileDir(ExtractFileDir(Path)));
  
  // 从目录名提取版本号（如 "IntelliJ IDEA 2024.1" -> "2024.1"）
  StartPos := 0;
  for I := 1 to Length(DirName) do
  begin
    if (DirName[I] >= '0') and (DirName[I] <= '9') then
    begin
      StartPos := I;
      Break;
    end;
  end;
  
  if StartPos > 0 then
    Result := Copy(DirName, StartPos, Length(DirName) - StartPos + 1)
  else
    Result := DirName;
end;

procedure SearchAllIDEVersions(
  const IDEName, ExeName: string; 
  VersionsList, PathsList: TStringList);
var
  BaseDir: string;
  FindRec: TFindRec;
  SubDir: string;
  ExePath: string;
  Version: string;
  DisplayName: string;
begin
  VersionsList.Clear;
  PathsList.Clear;
  
  BaseDir := 'C:\Program Files\JetBrains';
  
  if not DirExists(BaseDir) then
    Exit;
  
  // 查找所有匹配的文件夹
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
              ExePath := FindFileInDirectory(SubDir, ExeName);
              
              if (ExePath <> '') and FileExists(ExePath) then
              begin
                Version := ExtractVersionFromPath(ExePath);
                DisplayName := FindRec.Name;
                if Version <> '' then
                  DisplayName := DisplayName + ' (v' + Version + ')';
                
                VersionsList.Add(DisplayName);
                PathsList.Add(ExePath);
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

function DetectIDEFromRegistry(const RegKeyPattern, ExeName: string): string;
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
          ExePath := AddBackslash(InstallLocation) + 'bin\' + ExeName;
          
          if FileExists(ExePath) then
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
            ExePath := AddBackslash(InstallLocation) + 'bin\' + ExeName;
            
            if FileExists(ExePath) then
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

function AutoDetectIDEPath(
  const IDEName, RegKeyPattern, ExeName: string;
  VersionsList, PathsList: TStringList): string;
var
  RegPath: string;
begin
  Result := '';
  
  // 1. 从注册表检测
  RegPath := DetectIDEFromRegistry(RegKeyPattern, ExeName);
  if RegPath <> '' then
  begin
    Result := RegPath;
    Exit;
  end;
  
  // 2. 扫描 JetBrains 文件夹，收集所有版本
  SearchAllIDEVersions(IDEName, ExeName, VersionsList, PathsList);
  
  // 3. 如果找到版本，返回最后一个（通常是最新的）
  if PathsList.Count > 0 then
    Result := PathsList[PathsList.Count - 1];
end;

{ ===== 版本选择对话框 ===== }

procedure SelectIdeaVersion(Sender: TObject);
var
  VersionIndex: Integer;
  Msg: string;
  I: Integer;
begin
  if IdeaPaths.Count <= 1 then
  begin
    MsgBox('未检测到多个 IntelliJ IDEA 版本', mbInformation, MB_OK);
    Exit;
  end;
  
  // 构建消息
  Msg := '检测到以下 IntelliJ IDEA 版本：' + #13#10#13#10;
  for I := 0 to IdeaVersions.Count - 1 do
  begin
    Msg := Msg + IntToStr(I + 1) + '. ' + IdeaVersions[I] + #13#10;
  end;
  Msg := Msg + #13#10 + '当前使用：最新版本（' + IntToStr(IdeaVersions.Count) + '）' + #13#10#13#10;
  Msg := Msg + '如需切换版本，请使用"浏览"按钮手动选择。';
  
  MsgBox(Msg, mbInformation, MB_OK);
end;

procedure SelectWebStormVersion(Sender: TObject);
var
  Msg: string;
  I: Integer;
begin
  if WebStormPaths.Count <= 1 then
  begin
    MsgBox('未检测到多个 WebStorm 版本', mbInformation, MB_OK);
    Exit;
  end;
  
  // 构建消息
  Msg := '检测到以下 WebStorm 版本：' + #13#10#13#10;
  for I := 0 to WebStormVersions.Count - 1 do
  begin
    Msg := Msg + IntToStr(I + 1) + '. ' + WebStormVersions[I] + #13#10;
  end;
  Msg := Msg + #13#10 + '当前使用：最新版本（' + IntToStr(WebStormVersions.Count) + '）' + #13#10#13#10;
  Msg := Msg + '如需切换版本，请使用"浏览"按钮手动选择。';
  
  MsgBox(Msg, mbInformation, MB_OK);
end;

procedure SelectGoLandVersion(Sender: TObject);
var
  Msg: string;
  I: Integer;
begin
  if GoLandPaths.Count <= 1 then
  begin
    MsgBox('未检测到多个 GoLand 版本', mbInformation, MB_OK);
    Exit;
  end;
  
  // 构建消息
  Msg := '检测到以下 GoLand 版本：' + #13#10#13#10;
  for I := 0 to GoLandVersions.Count - 1 do
  begin
    Msg := Msg + IntToStr(I + 1) + '. ' + GoLandVersions[I] + #13#10;
  end;
  Msg := Msg + #13#10 + '当前使用：最新版本（' + IntToStr(GoLandVersions.Count) + '）' + #13#10#13#10;
  Msg := Msg + '如需切换版本，请使用"浏览"按钮手动选择。';
  
  MsgBox(Msg, mbInformation, MB_OK);
end;

{ ===== 初始化向导 ===== }

procedure InitializeWizard;
var
  AutoDetectedPath: string;
begin
  // 初始化版本列表
  IdeaVersions := TStringList.Create;
  IdeaPaths := TStringList.Create;
  WebStormVersions := TStringList.Create;
  WebStormPaths := TStringList.Create;
  GoLandVersions := TStringList.Create;
  GoLandPaths := TStringList.Create;
  
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
  IdeaPathEdit.SetBounds(110, 20, 290, 28);
  
  // 自动检测并填充路径
  AutoDetectedPath := AutoDetectIDEPath(
    'IntelliJ IDEA',
    'SOFTWARE\JetBrains\IntelliJ IDEA',
    'idea64.exe',
    IdeaVersions,
    IdeaPaths
  );
  if AutoDetectedPath <> '' then
    IdeaPathEdit.Text := AutoDetectedPath;

  IdeaBrowseBtn := TButton.Create(IdePage);
  IdeaBrowseBtn.Parent := IdePage.Surface;
  IdeaBrowseBtn.Caption := '浏览...';
  IdeaBrowseBtn.SetBounds(410, 20, 70, 25);
  IdeaBrowseBtn.OnClick := @BrowseIdea;
  
  IdeaVersionBtn := TButton.Create(IdePage);
  IdeaVersionBtn.Parent := IdePage.Surface;
  IdeaVersionBtn.Caption := '版本信息';
  IdeaVersionBtn.SetBounds(490, 20, 70, 25);
  IdeaVersionBtn.OnClick := @SelectIdeaVersion;
  IdeaVersionBtn.Enabled := IdeaPaths.Count > 1;
  
  { WebStorm }
  WebStormLabel := TLabel.Create(IdePage);
  WebStormLabel.Parent := IdePage.Surface;
  WebStormLabel.Caption := 'WebStorm';
  WebStormLabel.SetBounds(0, 62, 100, 21);

  WebStormPathEdit := TEdit.Create(IdePage);
  WebStormPathEdit.Parent := IdePage.Surface;
  WebStormPathEdit.SetBounds(110, 60, 290, 28);
  
  // 自动检测并填充路径
  AutoDetectedPath := AutoDetectIDEPath(
    'WebStorm',
    'SOFTWARE\JetBrains\WebStorm',
    'webstorm64.exe',
    WebStormVersions,
    WebStormPaths
  );
  if AutoDetectedPath <> '' then
    WebStormPathEdit.Text := AutoDetectedPath;

  WebStormBrowseBtn := TButton.Create(IdePage);
  WebStormBrowseBtn.Parent := IdePage.Surface;
  WebStormBrowseBtn.Caption := '浏览...';
  WebStormBrowseBtn.SetBounds(410, 60, 70, 25);
  WebStormBrowseBtn.OnClick := @BrowseWebStorm;
  
  WebStormVersionBtn := TButton.Create(IdePage);
  WebStormVersionBtn.Parent := IdePage.Surface;
  WebStormVersionBtn.Caption := '版本信息';
  WebStormVersionBtn.SetBounds(490, 60, 70, 25);
  WebStormVersionBtn.OnClick := @SelectWebStormVersion;
  WebStormVersionBtn.Enabled := WebStormPaths.Count > 1;
  
  { GoLand }
  GoLandLabel := TLabel.Create(IdePage);
  GoLandLabel.Parent := IdePage.Surface;
  GoLandLabel.Caption := 'GoLand';
  GoLandLabel.SetBounds(0, 102, 100, 21);

  GoLandPathEdit := TEdit.Create(IdePage);
  GoLandPathEdit.Parent := IdePage.Surface;
  GoLandPathEdit.SetBounds(110, 100, 290, 28);
  
  // 自动检测并填充路径
  AutoDetectedPath := AutoDetectIDEPath(
    'GoLand',
    'SOFTWARE\JetBrains\GoLand',
    'goland64.exe',
    GoLandVersions,
    GoLandPaths
  );
  if AutoDetectedPath <> '' then
    GoLandPathEdit.Text := AutoDetectedPath;

  GoLandBrowseBtn := TButton.Create(IdePage);
  GoLandBrowseBtn.Parent := IdePage.Surface;
  GoLandBrowseBtn.Caption := '浏览...';
  GoLandBrowseBtn.SetBounds(410, 100, 70, 25);
  GoLandBrowseBtn.OnClick := @BrowseGoLand;
  
  GoLandVersionBtn := TButton.Create(IdePage);
  GoLandVersionBtn.Parent := IdePage.Surface;
  GoLandVersionBtn.Caption := '版本信息';
  GoLandVersionBtn.SetBounds(490, 100, 70, 25);
  GoLandVersionBtn.OnClick := @SelectGoLandVersion;
  GoLandVersionBtn.Enabled := GoLandPaths.Count > 1;
end;

procedure DeinitializeSetup();
begin
  IdeaVersions.Free;
  IdeaPaths.Free;
  WebStormVersions.Free;
  WebStormPaths.Free;
  GoLandVersions.Free;
  GoLandPaths.Free;
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
  IdeaVersionBtn.Visible := False;

  WebStormLabel.Visible := False;
  WebStormPathEdit.Visible := False;
  WebStormBrowseBtn.Visible := False;
  WebStormVersionBtn.Visible := False;

  GoLandLabel.Visible := False;
  GoLandPathEdit.Visible := False;
  GoLandBrowseBtn.Visible := False;
  GoLandVersionBtn.Visible := False;

  if IsComponentSelected('idea') then
  begin
    IdeaLabel.SetBounds(0, Y + 2, 100, 21);
    IdeaPathEdit.SetBounds(110, Y, 290, 28);
    IdeaBrowseBtn.SetBounds(410, Y, 70, 25);
    IdeaVersionBtn.SetBounds(490, Y, 70, 25);

    IdeaLabel.Visible := True;
    IdeaPathEdit.Visible := True;
    IdeaBrowseBtn.Visible := True;
    IdeaVersionBtn.Visible := True;
    IdeaVersionBtn.Enabled := IdeaPaths.Count > 1;

    Y := Y + 40;
  end;

  if IsComponentSelected('webstorm') then
  begin
    WebStormLabel.SetBounds(0, Y + 2, 100, 21);
    WebStormPathEdit.SetBounds(110, Y, 290, 28);
    WebStormBrowseBtn.SetBounds(410, Y, 70, 25);
    WebStormVersionBtn.SetBounds(490, Y, 70, 25);

    WebStormLabel.Visible := True;
    WebStormPathEdit.Visible := True;
    WebStormBrowseBtn.Visible := True;
    WebStormVersionBtn.Visible := True;
    WebStormVersionBtn.Enabled := WebStormPaths.Count > 1;

    Y := Y + 40;
  end;

  if IsComponentSelected('goland') then
  begin
    GoLandLabel.SetBounds(0, Y + 2, 100, 21);
    GoLandPathEdit.SetBounds(110, Y, 290, 28);
    GoLandBrowseBtn.SetBounds(410, Y, 70, 25);
    GoLandVersionBtn.SetBounds(490, Y, 70, 25);

    GoLandLabel.Visible := True;
    GoLandPathEdit.Visible := True;
    GoLandBrowseBtn.Visible := True;
    GoLandVersionBtn.Visible := True;
    GoLandVersionBtn.Enabled := GoLandPaths.Count > 1;
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



    