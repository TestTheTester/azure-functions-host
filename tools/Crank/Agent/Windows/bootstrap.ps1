param($ParametersJson)

$ErrorActionPreference = 'Stop'

# Install git
$gitVersion = '2.28.0'
$gitInstallerFileName = "git-$gitVersion-64-bit.exe"
[Net.ServicePointManager]::SecurityProtocol =[Net.SecurityProtocolType]::Tls12
Invoke-RestMethod -Uri "https://github.com/git-for-windows/git/releases/download/v$gitVersion.windows.1/$gitInstallerFileName" -OutFile $gitInstallerFileName
& ".\$gitInstallerFileName" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /ALLUSERS /NORESTART /FORCECLOSEAPPLICATIONS | echo Waiting
$env:PATH += ";$($env:ProgramFiles)\Git\cmd;"

# Clone azure-functions-host repo
New-Item -Path C:\github -ItemType Directory
Set-Location -Path C:\github
& git clone https://github.com/Azure/azure-functions-host.git
Set-Location -Path azure-functions-host
& git checkout anatolib/crank-windows-vm-deployment

# Install PowerShell
Set-Location -Path tools\Crank\Agent
$powerShellCmd = .\Windows\install-powershell.ps1

# Setup Crank agent
& $powerShellCmd -NoProfile -NonInteractive -File .\setup-crank-agent-json.ps1 -ParametersJson "`"$($ParametersJson -replace '"', '\"')`"" -Verbose
