$host.UI.RawUI.WindowTitle = "Setup PC"
#Reinstalls programs I use commonly use, and set registry information with a simple script
cls
Write-Host "Setup PC, verified safe, used, and created by Zezypisa."
Write-Host "Make sure to run this with Administrator, or it will not work."
Write-Host "Use this at your own risk."
Write-Host "Note: Update computer and Microsoft Store apps first"
$confirmation = Read-Host "Are you Sure You Want To Proceed? [yes\no]"
if ($confirmation -eq "yes") {
   #windows update
   cls
   $confirmation = Read-Host "Do you want to update Windows? [yes\no]"
   if ($confirmation -eq "yes") {
      Start-Process "ms-settings:"
   }

   #microsoft store apps
   cls
   $confirmation = Read-Host "Do you want to install microsoft store? [yes\no]"
   if ($confirmation -eq "yes") {
      Write-Host "Install Nvidia Control Panel (https://www.microsoft.com/en-us/p/nvidia-control-panel/9nf8h0h7wmlt)"
      Write-Host "Install Realtek Audio Console (https://www.microsoft.com/en-us/p/realtek-audio-control/9p2b8mcsvpln)"
      Write-Host "Install Armoury Crate (https://www.microsoft.com/en-us/p/armoury-crate-beta/9pm9dfqrdh3f)"
      Write-Host "Install MyAsus (https://www.microsoft.com/en-us/p/myasus/9n7r5s6b0zzh)"
      Write-Host "Install Xbox (https://www.microsoft.com/en-us/p/xbox/9mv0b5hzvk9z)"
      Write-Host "Install Xbox Game Bar (https://www.microsoft.com/en-us/p/xbox-game-bar/9nzkpstsnw4p)"
      pause
   }

   #uninstall onedrive
   cls
   $confirmation = Read-Host "Do you want to uninstall onedrive? [yes\no\undo]"
   if ($confirmation -eq "yes") {
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
   }
   if ($confirmation -eq "undo") {
      & "C:\Windows\SysWOW64\OneDriveSetup.exe"
   }

   #run scoop installers
   cls
   $confirmation = Read-Host "Do you want to install scoop apps? [yes\no\undo]"
   if ($confirmation -eq "yes") {
      Set-ExecutionPolicy RemoteSigned -scope CurrentUser
      Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
      scoop install git 7zip
      scoop bucket add main
      scoop bucket add extras
      scoop bucket add java
      scoop bucket add nonportable
      scoop install 7zip ffmpeg gimp git nano notepadplusplus ntop obs-studio oraclejre8 rainmeter sudo virtualbox-np vlc vscode windows-terminal windirstat winfetch youtube-dl
      scoop cleanup *
      scoop cache rm *
      scoop checkup
      pause
   }
   if ($confirmation -eq "undo") {
      scoop uninstall scoop
      Remove-Item -Path "~\scoop"
   }

   #clone git repositories and run them
   cls
   $confirmation = Read-Host "Do you want to download and run powershell scripts? [yes\no\undo]"
   if ($confirmation -eq "yes") {
      New-Item -Path "~\Git"
      New-Item -Path "~\Git\List-Startup-Apps"
      New-Item -Path "~\Git\Remove-Bloatware"
      New-Item -Path "~\Git\Remove-Windowsapps"
      New-Item -Path "~\Git\Setup-PC"
      New-Item -Path "~\Git\Toggle-Programs"
      git clone "https://github.com/Zezypisa/List-Startup-Apps" "~\Git\List-Startup-Apps"
      git clone "https://github.com/Zezypisa/Remove-Bloatware" "~\Git\Remove-Bloatware"
      git clone "https://github.com/Zezypisa/Remove-WindowsApps" "~\Git\Remove-Windowsapps"
      git clone "https://github.com/Zezypisa/Setup-PC" "~\Git\Setup-PC"
      git clone "https://github.com/Zezypisa/Toggle-Programs" "~\Git\Toggle-Programs"
      & "~\Git\List-Startup-Apps\List Startup Apps.ps1"
      & "~\Git\Remove-Bloatware\Remove Bloatware.ps1"
      & "~\Git\Remove-WindowsApps\Remove WindowsApps.ps1"
      # "~\Git\Setup-PC\Setup PC.ps1"
      & "~\Git\Toggle-Programs\Toggle Programs.ps1"
   }
   if ($confirmation -eq "undo") {
      Remove-Item -Path "~\Git"
   }

   #add scoop apps to context menu
   cls
   $confirmation = Read-Host "Do you want to run context menu scripts? [yes\no\undo]"
   if ($confirmation -eq "yes") {
      #notepad++
      New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Notepad++"
      New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Notepad++\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Notepad++" -PropertyType "String" -Name "(Default)" -Value "Open with Notepad++"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Notepad++" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\notepadplusplus\current\notepad++.exe"'
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Notepad++\command" -PropertyType "String" -Name "(Current)" -Value '"C:\Users\Zezy\scoop\apps\notepadplusplus\current\notepad++.exe" "%1"'
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Notepad++"
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Notepad++\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Notepad++" -PropertyType "String" -Name "(Default)" -Value "Open with Notepad++"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Notepad++" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\notepadplusplus\current\notepad++.exe"'
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Notepad++\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\notepadplusplus\current\notepad++.exe" "%1"'
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Notepad++"
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Notepad++\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Notepad++" -PropertyType "String" -Name "(Default)" -Value "Open with Notepad++"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Notepad++" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\notepadplusplus\current\notepad++.exe"'
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Notepad++\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\notepadplusplus\current\notepad++.exe" "%V"'
      
      #visual studio code
      New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Code"
      New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Code\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Code" -PropertyType "String" -Name "(Default)" -Value "Open with Code"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Code" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\vscode\current\Code.exe"'
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Code\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\vscode\current\Code.exe" "%1"'
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Code"
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Code\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Code" -PropertyType "String" -Name "(Default)" -Value "Open with Code"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Code" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\vscode\current\Code.exe"'
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Code\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\vscode\current\Code.exe" "%1"'
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Code"
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Code\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Code" -PropertyType "String" -Name "(Default)" -Value "Open with Code"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Code" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\vscode\current\Code.exe"'
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Code\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\vscode\current\Code.exe" "%V"'
      
      #windows terminal
      New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open Windows Terminal Here"
      New-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open Windows Terminal Here\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open Windows Terminal Here" -PropertyType "String" -Name "(Default)" -Value "Open Windows Terminal Here"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open Windows Terminal Here" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\windows-terminal\current\WindowsTerminal.exe"' 
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\*\shell\Open Windows Terminal Here\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\windows-terminal\current\WindowsTerminal.exe" "-d ."'
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open Windows Terminal Here"
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open Windows Terminal Here\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open Windows Terminal Here" -PropertyType "String" -Name "(Default)" -Value "Open Windows Terminal Here"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open Windows Terminal Here" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\windows-terminal\current\WindowsTerminal.exe"' 
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open Windows Terminal Here\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\windows-terminal\current\WindowsTerminal.exe" "-d ."'
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open Windows Terminal Here"
      New-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open Windows Terminal Here\command"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open Windows Terminal Here" -PropertyType "String" -Name "(Default)" -Value "Open Windows Terminal Here"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open Windows Terminal Here" -PropertyType "String" -Name "Icon" -Value '"C:\Users\Zezy\scoop\apps\windows-terminal\current\WindowsTerminal.exe"' 
      New-ItemProperty -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open Windows Terminal Here\command" -PropertyType "String" -Name "(Default)" -Value '"C:\Users\Zezy\scoop\apps\windows-terminal\current\WindowsTerminal.exe" "-d ."'
   }
   if ($confirmation -eq "undo") {
      #notepad++
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Notepad++"
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Notepad++"
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Notepad++"

      #visual studio code
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open with Code"
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open with Code"
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open with Code"

      #windows terminal
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\*\shell\Open Windows Terminal Here"
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\Directory\shell\Open Windows Terminal Here"
      Remove-Item -Path "HKCU:\SOFTWARE\Classes\Directory\Background\shell\Open Windows Terminal Here"
   }

   #run installers
   cls
   $confirmation = Read-Host "Do you want to install apps? [yes\no\undo]"
   if ($confirmation -eq "yes") {
      #chrome
      Write-Host "Running Chrome Setup..."
      & "D:\Downloads\ChromeSetup.exe"
      pause

      #discord
      Write-Host "Running Discord Setup..."
      & "D:\Downloads\DiscordSetup.exe"
      pause

      #logitech ghub
      Write-Host "Running Logitech Gaming Hub Setup..."
      & "D:\Downloads\lghub_installer.exe"
      pause

      #nvidia gfe
      Write-Host "Running Nvidia Geforce Experience Setup..."
      & "D:\Downloads\GeForce_Experience_v3.20.5.70.exe"
      pause

      #elgato game capture
      Write-Host "Running Elgato Game Capture Setup..."
      & "D:\Downloads\GameCaptureSetup_3.70.51.3051_x64.msi"
      pause

      #steam
      Write-Host "Running Steam Setup..."
      & "D:\Downloads\SteamSetup.exe"
      pause

      #epic games launcher
      Write-Host "Running Epic Games Launcher Setup..."
      & "D:\Downloads\EpicInstaller-10.15.2.msi"
      pause

      #ubisoft connect
      Write-Host "Running Ubisoft Connect Setup..."
      & "D:\Downloads\UbisoftConnectInstaller.exe"
      pause
   }
   if ($confirmation -eq "undo") {
      #chrome
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome " -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #discord
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Discord" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #logitech ghub
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{521c89be-637f-4274-a840-baaf7460c2b2}" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #nvidia gfe
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}_Display.GFExperience" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #elgato game capture
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{012C3D17-E621-4146-85C9-099B72C2AD67}" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #steam
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #epic games launcher
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{1D4EB18B-0FEE-444E-B4D1-6F2CFBC363E6}" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause

      #ubisoft connect
      $uninstallpath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Uplay" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $uninstallpath
      pause
   }
   
   #setup settings
   cls
   $confirmation = Read-Host "Do you want to setup settings? [yes\no\undo]"
   if ($confirmation -eq "yes") {
      #sset power configuration
      powercfg -hibernate off
      Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936" -Name "Attributes" -Value "0"
      Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\99ff10e7-23b1-4c07-a9d1-5c3206d741b4" -Name "Attributes" -Value "0"

      #setup explorer
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value "1"

      #remove 3d objects from this pc
      Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"

      #setup taskbar
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewDesktop" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListViewAlphaSelect" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCompColor" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowInfoTip" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowStatusBar" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTypeOverlay" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_SearchFiles" -Value "2"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StartMenuInit" -Value "d"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StoreAppsOnTaskbar" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StorePinningExperimentResult" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSizeMove" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "WebView" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -PropertyType "dword" -Value "0"
      New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -PropertyType "dword" -Name "PeopleBand" -Value "0"

      #setup desktop
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Value "1"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaper" -Value "D:\Downloads\Halo Reach - Main Menu 1.png"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaperOriginX" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaperOriginY" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaperStyle" -Value "10"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "TileWallpaper" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value "1" 
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListViewShadow" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Value "3"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -Name "BackgroundType" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -Name "BackgroundHistoryPath0" -Value "d:\downloads\halo reach - main menu 1.png"

      #set color
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "AccentColor" -Value "ff484a4c"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "AlwaysHibernateThumbnails" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorizationAfterglow" -Value "c44c4a48"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorizationAfterglowBalance" -Value "a"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorizationBlurBalance" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorizationColor" -Value "c44c4a48"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorizationColorBalance" -Value "59"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorizationGlassAttribute" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "ColorPrevalence" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "Composition" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "EnableAeroPeek" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\DWM" -Name "EnableWindowColorization" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" -Name "ColorSetFromTheme" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentColorMenu" -Value "ff484a4c"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "AccentPalette" -Value "9B 9A 99 00 84 83 81 00 6D 6B 6A 00 4C 4A 48 00 36 35 33 00 26 25 24 00 19 19 19 00 10 7C 10 00"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" -Name "StartColorMenu" -Value "ff333536 "
      
      #set dark theme
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value "1"

      #set mouse settings
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "ActiveWindowTracking" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "Beep" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "DoubleClickHeight" -Value "4"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "DoubleClickSpeed" -Value "500"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "DoubleClickWidth" -Value "4"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "ExtendedSounds" -Value "No"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverHeight" -Value "4"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverTime" -Value "400"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseHoverWidth" -Value "4"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSensitivity" -Value "10"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseTrails" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "SnapToDefaultButton" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "SwapMouseButtons" -Value "0"

      #disable notifications
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "LockScreenToastEnabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value "0"

      #disable telemetry
      Set-Service -Name "DiagTrack" -StartupType "Disabled"
      Stop-Service -Name "DiagTrack"
      Set-Service -Name "dmwappushservice" -StartupType "Disabled"
      Stop-Service -Name "dmwappushservice"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -PropertyType "dword" -Name "Allow Telemetry" -Value "0"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\StartupAppTask"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
      
      #disable delivery optimization
      Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DoSvc" -Name "Start" -Value "3"

      #disable bandwidth limit
      New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Psched"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Psched" -PropertyType "dword" -Name "NonBestEffortLimit"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Psched" -Name "NonBestEffortLimit" -Value "0"

      #disable advertising ID
      New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -PropertyType "dword" -Name "DisabledByGroupPolicy"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value "1"

      #disable language ads
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value "0"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "HttpAcceptLanguageOptOut" -Value "1"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value "1"

      #disable app tracking starting
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value "0"

      #disable suggested content in settings
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value "0"

      #disable speech recognition
      New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -PropertyType "dword" -Name "AllowInputPersonalization"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Value "0"

      #disable inking and typing personilzation
      New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -PropertyType "dword" -Name "RestrictImplicitTextCollection"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value "1"

      #disable activity feed
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value "0"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value "0"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value "0"

      #disable tailored experiences
      New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -PropertyType "dword" -Name "DisableTailoredExperiencesWithDiagnosticData"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value "1"
      
      #disable error reporting
      New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -PropertyType "dword" -Name "Disabled"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value "1"
      Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting"

      #disable news feeds
      New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -PropertyType "dword" -Name "EnableFeeds"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value "0"
      
      #disable hibernation
      New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"
      New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -PropertyType "dword" -Name "HibernateEnabled"
      Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Value "0"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -PropertyType "dword" -Name "ShowHibernateOption"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Value "0"

      #set user app permissions
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sensors.custom" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\serialCommunication" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\usb" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect" -Name "Value" -Value "Allow" -Force

      #set computer app permissions
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sensors.custom" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\serialCommunication" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\usb" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect" -Name "Value" -Value "Allow" -Force
   }
   if ($confirmation -eq "undo") {
      #set power configuration
      powercfg -hibernate on
      Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936" -Name "Attributes" -Value "1"
      Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\99ff10e7-23b1-4c07-a9d1-5c3206d741b4" -Name "Attributes" -Value "1"

      #remove 3d objects from this pc
      New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"

      #enable notifications
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "LockScreenToastEnabled" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value "1"

      #enable telemetry
      Set-Service -Name "DiagTrack" -StartupType "Automatic"
      Start-Service -Name "DiagTrack"
      Set-Service -Name "dmwappushservice" -StartupType "Automatic"
      Start-Service -Name "dmwappushservice"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "Allow Telemetry" -Value "1"
      Enable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
      Enable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
      Enable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
      Enable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\StartupAppTask"
      Enable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
      Enable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
      
      #enable delivery optimization
      Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\DoSvc" -Name "Start" -Value "3"

      #enable bandwidth limit
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Psched" -PropertyType "dword" -Name "NonBestEffortLimit" -Value "1"

      #enable advertising ID
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -PropertyType "dword" -Value "0"

      #enable language ads
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value "1"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "HttpAcceptLanguageOptOut" -Value "0"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Value "0"

      #enable app tracking starting
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value "1"

      #enable suggested content in settings
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Value "1"

      #enable speech recognition
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Value "1"

      #enable inking and typing personilzation
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value "0"

      #enable activity feed
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value "1"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value "1"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value "1"

      #enable tailored experiences
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Value "0"
      
      #enable error reporting
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value "0"
      Enable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting"

      #enable news feeds
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" -Name "EnableFeeds" -Value "1"
      
      #disable hibernation
      Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Power" -Name "HibernateEnabled" -Value "1"
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" -Name "ShowHibernateOption" -Value "0"

      #set user app permissions
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sensors.custom" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\serialCommunication" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\usb" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect" -Name "Value" -Value "Allow" -Force

      #set computer app permissions
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sensors.custom" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\serialCommunication" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\usb" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect" -Name "Value" -Value "Allow" -Force
   }

   #finished 
   Write-Host "Finished."
   pause
   exit
}
if ($confirmation -eq "no") {
   cls
   Write-Host "Alright, Cancelled. No files have been modified"
   pause
   exit
}
exit
