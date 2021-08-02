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
      start "ms-settings:"
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
      Write-Host "Install Files (https://www.microsoft.com/en-us/p/files/9nghp3dx8hdx)"
      pause
   }

   #run scoop installers
   cls
   $confirmation = Read-Host "Do you want to install scoop apps? [yes\no]"
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

   #run apps installers
   cls
   $confirmation = Read-Host "Do you want to install apps? [yes\no]"
   if ($confirmation -eq "yes") {
      Write-Host "Running Chrome Setup..."
      & "D:\Downloads\ChromeSetup.exe"
      pause
      Write-Host "Running Discord Setup..."
      & "D:\Downloads\DiscordSetup.exe"
      pause
      Write-Host "Running Logitech GHUB Setup..."
      & "D:\Downloads\lghub_installer.exe"
      pause
      Write-Host "Running Nvidia Geforce Experience Setup..."
      & "D:\Downloads\GeForce_Experience_v3.20.5.70.exe"
      pause
   }

   #run games installers
   cls
   $confirmation = Read-Host "Do you want to install game launchers? [yes\no]"
   if ($confirmation -eq "yes") {
      Write-Host "Running Steam Setup..."
      & "D:\Downloads\SteamSetup.exe"
      pause
      Write-Host "Running Epic Games Launcher Setup..."
      & "D:\Downloads\EpicInstaller-10.15.2.msi"
      pause
      Write-Host "Running Ubisoft Connect Setup..."
      & "D:\Downloads\UbisoftConnectInstaller.exe"
      pause
   }

   #clone git repositories and run them
   cls
   $confirmation = Read-Host "Do you want to download and run powershell scripts? [yes\no]"
   if ($confirmation -eq "yes") {
      mkdir "$home\Git"
      mkdir "$home\Git\List-Startup-Apps"
      mkdir "$home\Git\Remove-Bloatware"
      mkdir "$home\Git\Remove-Windowsapps"
      mkdir "$home\Git\Setup-PC"
      mkdir "$home\Git\Toggle-Programs"
      git clone "https://github.com/Zezypisa/List-Startup-Apps" "$home\Git\List-Startup-Apps"
      git clone "https://github.com/Zezypisa/Remove-Bloatware" "$home\Git\Remove-Bloatware"
      git clone "https://github.com/Zezypisa/Remove-WindowsApps" "$home\Git\Remove-Windowsapps"
      git clone "https://github.com/Zezypisa/Setup-PC" "$home\Git\Setup-PC"
      git clone "https://github.com/Zezypisa/Toggle-Programs" "$home\Git\Toggle-Programs"
      & "$home\Git\List-Startup-Apps\List Startup Apps.ps1"
      & "$home\Git\Remove-Bloatware\Remove Bloatware.ps1"
      & "$home\Git\Remove-WindowsApps\Remove WindowsApps.ps1"
      # "$home\Git\Setup-PC\Setup PC.ps1"
      & "$home\Git\Toggle-Programs\Toggle Programs.ps1"
   }

   #add scoop apps to context menu
   cls
   $confirmation = Read-Host "Do you want to run context menu scripts? [yes\no]"
   if ($confirmation -eq "yes") {
      #notepad++
      New-Item -Path "HKCU:\Software\Classes\*\shell\Open with Notepad++"
      New-Item -Path "HKCU:\Software\Classes\*\shell\Open with Notepad++\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open with Notepad++" -PropertyType "String" -Name "(Default)" -Value "Open with Notepad++"
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open with Notepad++" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\notepadplusplus\current\notepad++.exe"'
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open with Notepad++\command" -PropertyType "String" -Name "(Current)" -Value '"%USERPROFILE%\scoop\apps\notepadplusplus\current\notepad++.exe" "%1"'
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\Open with Notepad++"
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\Open with Notepad++\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open with Notepad++" -PropertyType "String" -Name "(Default)" -Value "Open with Notepad++"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open with Notepad++" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\notepadplusplus\current\notepad++.exe"'
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open with Notepad++\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\notepadplusplus\current\notepad++.exe" "%1"'
      New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Notepad++"
      New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Notepad++\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Notepad++" -PropertyType "String" -Name "(Default)" -Value "Open with Notepad++"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Notepad++" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\notepadplusplus\current\notepad++.exe"'
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Notepad++\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\notepadplusplus\current\notepad++.exe" "%V"'
      
      #visual studio code
      New-Item -Path "HKCU:\Software\Classes\*\shell\Open with Code"
      New-Item -Path "HKCU:\Software\Classes\*\shell\Open with Code\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open with Code" -PropertyType "String" -Name "(Default)" -Value "Open with Code"
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open with Code" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\vscode\current\Code.exe"'
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open with Code\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\vscode\current\Code.exe" "%1"'
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\Open with Code"
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\Open with Code\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open with Code" -PropertyType "String" -Name "(Default)" -Value "Open with Code"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open with Code" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\vscode\current\Code.exe"'
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open with Code\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\vscode\current\Code.exe" "%1"'
      New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Code"
      New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Code\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Code" -PropertyType "String" -Name "(Default)" -Value "Open with Code"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Code" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\vscode\current\Code.exe"'
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open with Code\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\vscode\current\Code.exe" "%V"'
      
      #windows terminal
      New-Item -Path "HKCU:\Software\Classes\*\shell\Open Windows Terminal Here"
      New-Item -Path "HKCU:\Software\Classes\*\shell\Open Windows Terminal Here\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open Windows Terminal Here" -PropertyType "String" -Name "(Default)" -Value "Open Windows Terminal Here"
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open Windows Terminal Here" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\windows-terminal\current\WindowsTerminal.exe"' 
      New-ItemProperty -Path "HKCU:\Software\Classes\*\shell\Open Windows Terminal Here\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\windows-terminal\current\WindowsTerminal.exe" "-d ."'
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\Open Windows Terminal Here"
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\Open Windows Terminal Here\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open Windows Terminal Here" -PropertyType "String" -Name "(Default)" -Value "Open Windows Terminal Here"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open Windows Terminal Here" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\windows-terminal\current\WindowsTerminal.exe"' 
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\Open Windows Terminal Here\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\windows-terminal\current\WindowsTerminal.exe" "-d ."'
      New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\Open Windows Terminal Here"
      New-Item -Path "HKCU:\Software\Classes\Directory\Background\shell\Open Windows Terminal Here\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open Windows Terminal Here" -PropertyType "String" -Name "(Default)" -Value "Open Windows Terminal Here"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open Windows Terminal Here" -PropertyType "String" -Name "Icon" -Value '"%USERPROFILE%\scoop\apps\windows-terminal\current\WindowsTerminal.exe"' 
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\Background\shell\Open Windows Terminal Here\command" -PropertyType "String" -Name "(Default)" -Value '"%USERPROFILE%\scoop\apps\windows-terminal\current\WindowsTerminal.exe" "-d ."'
   }
   
   #setup the taskbar, desktop, and explorer?
   cls
   $confirmation = Read-Host "Do you want to setup the taskbar, desktop, and explorer? [yes\no]"
   if ($confirmation -eq "yes") {
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "AutoCheckSelect" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "DisablePreviewDesktop" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideIcons" -Value "1" 
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "IconsOnly" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListViewAlphaSelect" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListViewShadow" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MultiTaskingAltTabFilter" -Value "3"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCompColor" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowInfoTip" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowStatusBar" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTypeOverlay" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_SearchFiles" -Value "2"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackProgs" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StartMenuInit" -Value "d"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StoreAppsOnTaskbar" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "StorePinningExperimentResult" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSizeMove" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "WebView" -Value "1"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -Name "BackgroundType" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" -Name "BackgroundHistoryPath0" -Value "d:\downloads\halo reach - main menu 1.png"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "AutoColorization" -Value "1"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaper" -Value "D:\Downloads\Halo Reach - Main Menu 1.png"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaperOriginX" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaperOriginY" -Value "0"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "WallPaperStyle" -Value "10"
      Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "TileWallpaper" -Value "0"
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
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "ColorPrevalence" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value "1"
      New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
      New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -PropertyType "dword" -Name "PeopleBand" -Value "0"
      Stop-Process -Name "explorer"
      Start-Process -FilePath "C:\Windows\Explorer.exe"
   }

   #disable notifications
   cls
   $confirmation = Read-Host "Do you want to disable notifications? [yes\no]"
   if ($confirmation -eq "yes") {
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "ToastEnabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" -Name "LockScreenToastEnabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"  -Name "SubscribedContent-310093Enabled" -Value "0"
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"  -Name "SubscribedContent-338389Enabled" -Value "0"
   }

   #disable delivery optimization
   cls
   $confirmation = Read-Host "Do you want to disable delivery optimization? [yes\no]"
   if ($confirmation -eq "yes") {
      Set-ItemProperty -Path "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" -Name "Start" -Value "3"
   }

   #disable telemetry
   cls
   $confirmation = Read-Host "Do you want to disable telemetry? [yes\no]"
   if ($confirmation -eq "yes") {
      cmd /c sc config "DiagTrack" start=disabled
      cmd /c sc stop "DiagTrack"
      cmd /c sc config "dmwappushservice" start=disabled
      cmd /c sc stop "dmwappushservice"
      New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -PropertyType "dword" -Name "Allow Telemetry" -Value "0"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\StartupAppTask"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
      Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
   }

   #disable hibernation
   cls
   $confirmation = Read-Host "Do you want to disable hibernation? [yes\no]"
   if ($confirmation -eq "yes") {
      powercfg /hibernate off
   }

   #disable app permissions
   cls
   $confirmation = Read-Host "Do you want to run privacy scripts? [yes\no]"
   if ($confirmation -eq "yes") {
      #user
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Allow" -Force
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
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect" -Name "Value" -Value "Allow" -Force

      #computer
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" -Name "Value" -Value "Allow" -Force
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
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" -Name "Value" -Value "Deny" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wifiData" -Name "Value" -Value "Allow" -Force
      Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\wiFiDirect" -Name "Value" -Value "Allow" -Force
   }

   #set files as default
   cls
   $confirmation = Read-Host "Do you want to set Files (new) as default? [yes\no]"
   if ($confirmation -eq "yes") {
      New-Item -Path "HKCU:\Software\Classes\CLSID\{52205fd8-5dfb-447d-801a-d0b52f2e83e1}"
      New-Item -Path "HKCU:\Software\Classes\CLSID\{52205fd8-5dfb-447d-801a-d0b52f2e83e1}\shell"
      New-Item -Path "HKCU:\Software\Classes\CLSID\{52205fd8-5dfb-447d-801a-d0b52f2e83e1}\shell\opennewwindow"
      New-Item -Path "HKCU:\Software\Classes\CLSID\{52205fd8-5dfb-447d-801a-d0b52f2e83e1}\shell\opennewwindow\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{52205fd8-5dfb-447d-801a-d0b52f2e83e1}\shell\opennewwindow\command" -PropertyType "String" -Name "(Default)" -Value "%LOCALAPPDATA%\Microsoft\WindowsApps\files.exe"
      New-Item -Path "HKCU:\Software\Classes\Directory\shell"
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\openinfiles"
      New-Item -Path "HKCU:\Software\Classes\Directory\shell\openinfiles\command"
      New-ItemProperty -Path "HKCU:\Software\Classes\Directory\shell\openinfiles\command" -PropertyType "String" -Name "(Default)" -Value '"%LOCALAPPDATA%\Microsoft\WindowsApps\files.exe" "%1"'
   }
   
   #uninstall onedrive
   cls
   $confirmation = Read-Host "Do you want to uninstall onedrive? [yes\no]"
   if ($confirmation -eq "yes") {
      $onedrivepath = [ScriptBlock]::Create((Get-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\OneDriveSetup.exe" -Name "UninstallString").UninstallString)
      Invoke-Expression -ScriptBlock $onedrivepath
   }

   #change power config to max
   cls
   $confirmation = Read-Host "Do you want to change power scheme? [yes\no]"
   if ($confirmation -eq "yes") {
      powercfg -IMPORT "D:\Downloads\HighPerformance.pow"
      powercfg -LIST
      $confirmation = Read-Host "Please type in the Power Scheme GUID for High Performance"
      powercfg -SETACTIVE $confirmation
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
