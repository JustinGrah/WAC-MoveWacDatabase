# WAC-MoveWacDatabase
A super simple PowerShell script to move your WAC Metadata and Database folder to another WAC instance



## Documentation

### Prerequisites 
**Note** If you dont know what the Script does, you should probably not use it.

1. PowerShell
1. Two Running Windows Admin Center installtions
1. WinRM connectivity between both instances of Windows Admin Center


### When shall I use this?
This Script's intention is to aid users / sysadmins in migrating from one Windows Admin Center instance to another.
This means you are currently using Windows Admin Center on one host and now decided you need to move.
The Script will essentially copy over the User stored data (Connections etc.) to your new Windows Admin Server instance

### Do I need to plan anything?
You need to consider that the Script will turn off Windows Admin Center on both servers (Old and New instances) while copying and modifing data.
If you / your Company is relying on Windows Admin Center, ensure that you plan a downtime so no one is disturbed.

### The Script ruined something and I dont have a backup. 
Ofcourse you should have a backup. However, if you dont, there is one zip file located on the Desktop of the User which executed the script.
This is your old-pristine copy of the Metadata and Database folder. In order to inject it back, you simply unzip the file and move it to:
``` 
C:\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\ServerManagementExperience\
```
and ensure that you replace all existing files