Import-Module -Name ".\EnvPaths.psm1"

for ( $i = 0; $i -lt $args.count; $i++ ) {
	write-host "Argument  $i is $($args[$i])"
    Add-EnvPath "$($args[$i])" "User"
}

[System.Environment]::SetEnvironmentVariable('SCRIPT_DIR',$env:SCRIPT_DIR,'User')
[System.Environment]::SetEnvironmentVariable('GH_DIR',$env:GH_DIR,'User')
[System.Environment]::SetEnvironmentVariable('WORK_DIR',$env:WRK_DIR,'User')
[System.Environment]::SetEnvironmentVariable('APPS_DIR',$env:APPS_DIR,'User')

