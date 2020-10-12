#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [string]$ParametersJson,
    [string]$WindowsLocalAdminUserName,
    [string]$WindowsLocalAdminPassword # not a SecureString because we'll need to pass it via pwsh command line args
)

$ErrorActionPreference = 'Stop'

Write-Verbose "setup-crank-agent-json.ps1: `$ParametersJson: '$ParametersJson'" -Verbose

$parameters = @{}
($ParametersJson | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $parameters[$_.Name] = $_.Value }

$plaintextPassword = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($WindowsLocalAdminPassword))
$securePassword = ConvertTo-SecureString -String $plaintextPassword -AsPlainText -Force
$windowsLocalAdmin = [pscredential]::new($WindowsLocalAdminUserName, $securePassword)

& "$PSScriptRoot/setup-crank-agent.ps1" @parameters -WindowsLocalAdmin $windowsLocalAdmin -Verbose
