param($ParametersJson)

mkdir ~/github
Set-Location ~/github
git clone https://github.com/Azure/azure-functions-host.git
Set-Location azure-functions-host
git checkout dev

$powerShellCmd = Windows/install-powershell.ps1

