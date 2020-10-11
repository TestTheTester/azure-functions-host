param($ParametersJson)

mkdir ~/github
Set-Location ~/github
git clone https://github.com/Azure/azure-functions-host.git
Set-Location azure-functions-host
git checkout dev

$powerShellCmd = Windows/install-powershell.ps1

Set-Location tools/Crank/Agent
& $powerShellCmd -File ./setup-crank-agent-json.ps1 -ParametersJson $ParametersJson -Verbose
