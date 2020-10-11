$ErrorActionPreference = 'Stop'

$gitVersion = '2.28.0'
$gitInstallerFileName = "git-$gitVersion-64-bit.exe"
[Net.ServicePointManager]::SecurityProtocol =[Net.SecurityProtocolType]::Tls12
Invoke-RestMethod -Uri "https://github.com/git-for-windows/git/releases/download/v$gitVersion.windows.1/$gitInstallerFileName" -OutFile $gitInstallerFileName
& ".\$gitInstallerFileName" /SP- /VERYSILENT /NORESTART /SUPPRESSMSGBOXES /ALLUSERS /NORESTART /FORCECLOSEAPPLICATIONS | echo Waiting

"$env:ProgramFiles\Git\cmd\git.exe"
