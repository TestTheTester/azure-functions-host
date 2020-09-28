#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [string]$ParametersJson
)

$ErrorActionPreference = 'Stop'

$parameters = $ParametersJson | ConvertFrom-Json

& "$PSScriptRoot/setup-crank-agent.ps1" @parameters
