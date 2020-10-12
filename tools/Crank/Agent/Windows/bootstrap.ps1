param($ParametersJson)

$ErrorActionPreference = 'Stop'

# Install git
$gitVersion = '2.28.0'
$gitInstallerFileName = "git-$gitVersion-64-bit.exe"
[Net.ServicePointManager]::SecurityProtocol =[Net.SecurityProtocolType]::Tls12
Invoke-RestMethod -Uri "https://github.com/git-for-windows/git/releases/download/v$gitVersion.windows.1/$gitInstallerFileName" -OutFile $gitInstallerFileName
& ".\$gitInstallerFileName" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /ALLUSERS /NORESTART /FORCECLOSEAPPLICATIONS | echo Waiting
$gitCommand = "$env:ProgramFiles\Git\cmd\git.exe"

# Clone azure-functions-host repo
New-Item -Path C:\github -ItemType Directory
Set-Location -Path C:\github
& $gitCommand clone https://github.com/Azure/azure-functions-host.git
Set-Location -Path azure-functions-host
& $gitCommand checkout anatolib/crank-windows-vm-deployment

# Install PowerShell
$powerShellCmd = .\Windows\install-powershell.ps1

# Setup Crank agent
Set-Location tools\Crank\Agent
& $powerShellCmd -File .\setup-crank-agent-json.ps1 -ParametersJson $ParametersJson -Verbose
