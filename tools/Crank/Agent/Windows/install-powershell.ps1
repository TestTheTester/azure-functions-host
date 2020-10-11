$ErrorActionPreference = 'Stop'

$powerShellVersion = '7.0.3'
$powerShellMsiName = "PowerShell-$powerShellVersion-win-x64.msi"
[Net.ServicePointManager]::SecurityProtocol =[Net.SecurityProtocolType]::Tls12
Invoke-RestMethod -Uri "https://github.com/PowerShell/PowerShell/releases/download/v$powerShellVersion/$powerShellMsiName" -OutFile $powerShellMsiName
& msiexec.exe /package $powerShellMsiName /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 | echo Waiting

"$env:ProgramFiles\PowerShell\7\pwsh.exe"
