$WacSourceServer = "azs-mgmt"
$WacDestinServer = "azs-wac-demo"

#====================
$RootFolder = "C:\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\"
$RootSme = "ServerManagementExperience"
$SmeServiceName = "ServerManagementGateway"
$SessionSrc = New-PSSession -ComputerName $WacSourceServer
$SessionDst = New-PSSession -ComputerName $WacDestinServer

#Compress Zip-Files on both nodes
Invoke-Command -Session $SessionSrc -ScriptBlock {
    Stop-Service -Name $using:SmeServiceName -Force
    Compress-Archive -Path ($using:RootFolder + $using:RootSme) -DestinationPath "$env:USERPROFILE\Desktop\ServerManagementExperience.zip"
    $SessionDst = New-PSSession -ComputerName $using:WacDestinServer -Credential (Get-Credential)
    Copy-Item -ToSession $SessionDst -Path "$env:USERPROFILE\Desktop\ServerManagementExperience.zip" -Destination "$env:USERPROFILE\Desktop\ServerManagementExperience.zip"
}

Invoke-Command -Session $SessionDst -ArgumentList @{} -ScriptBlock {
    Stop-Service -Name $using:SmeServiceName -Force
    Start-Sleep -Seconds 5
    Compress-Archive -Path ($using:RootFolder + $using:RootSme) -DestinationPath "$env:USERPROFILE\Desktop\ServerManagementExperience_Backup.zip" -Force
    Remove-Item -Path ($using:RootFolder + $using:RootSme) -Confirm:$false -Recurse -Force
    Expand-Archive -Path "$env:USERPROFILE\Desktop\ServerManagementExperience.zip" -DestinationPath $using:RootFolder -Force
    Start-Service -Name $using:SmeServiceName
}
#====================