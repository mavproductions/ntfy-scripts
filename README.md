# ntfy-templates

## ✔Requirements✔
* [Ntfy Server](https://ntfy.sh) 
    - Ntfy.sh [(Free or Pro)](https://ntfy.sh/#features) or [Self-Hosted](https://docs.ntfy.sh/install/)
* [Powershell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#install-powershell-using-winget-recommended) (Recommended)

## 💡Use-cases💡
* Notifications to your Phone, Watch, Home Hub Tablet, Web-browser, PC/laptop, etc.
* Change detection of websites, logs/files, processes/services and other important infrastructure.
* [and many more!](https://docs.ntfy.sh/integrations/)

## ❗Important❗
If you don't [self-host](https://docs.ntfy.sh/install/), you must [pay a premium](https://ntfy.sh/#pricing) for reserved topic names and access-protection. If you do not pay for ntfy.sh topic hosting, your notifications are public-doman. Be careful what you share as this data can be easily mined.

## 📝Notes📝
Scripts like the [RDP Connection Detected](#rdpconnectiondetectedbat---task-scheduler) can be used for many use-cases. I personally use this style of script for the following:
* Server startups/shut-downs
* MySQL database backup Success/Failed report scripts
* Video/Map(Level) editing post-render alerts

Official [Ntfy Docs](https://docs.ntfy.sh/examples/) Examples.

## 🧾Scripts List🧾
Script | Description
--- | --- 
[Nvidia Update Checker (Concept not finished yet!)](#nvidiaupdatecheckerps1---task-scheduler-------httpsgithubcomlord-carlosnvidia-update) | Daily notifications for recent Nvidia GPU Drivers
[RDP Connection Detected](#rdpconnectiondetectedbat---task-scheduler) | If an RDP connection is made, receieve a notification. (Using Event Viewer IDs)
[User Logged On (Tested with Windows 10)](#userloggedonps1---task-scheduler) | If a Local user has signed on, receieve a notification. (Using Event Viewer IDs)
[Windows Update Checker](#windowsupdatecheckerps1---task-scheduler) | Daily notifications for available windows updates. (Downloads or Install)

### nvidiaupdatechecker.ps1 - Task Scheduler   ---> https://github.com/lord-carlos/nvidia-update
```
### General
Run whether user is logged on or not [Enabled] (Hides the PS window)
Run with highest privileges [Enabled]
Configure for: Windows 10

### Triggers
Whatever you like!

### Actions
Action: Start a program
Settings:
Program/Script: "C:\Program Files\PowerShell\7\pwsh.exe"
Add arguments(optional): -File "C:\path\to\nvidiaupdatechecker.ps1"

### Conditions
(All disabled)

### Settings
Allow task to be run on demand [Enabled]
Stop the task if it runs longer than: [1hr]
```

### rdpconnectiondetected.bat - Task Scheduler
```
### General
Run only when user is logged on [Enabled]
Configure for: Windows Server 2022

### Triggers
#Found in EventViewer#
Log: Microsoft-Windows-TerminalServices-LocalSessionManager/Operation
Source: TerminalServices-LocalSessionManager
Event ID: 25

### Actions
Action: Start a program
Settings:
Program/Script: C:\Windows\System32\cmd.exe
Add arguments(optional): /C "C:\path\to\rdpconnectiondetected.bat"

### Conditions
(All disabled)

### Settings
Allow task to be run on demand [Enabled]
```

### userLoggedOn.ps1 - Task Scheduler
```
### General
Run only when user is logged on [Enabled]
Configure for: Windows 10

### Triggers
## Trigger 1
(On Event)
Log: Security
Source: Microsoft-Windows-Security-Auditing
Event ID: 4801
*Click the Custom Radio button* DO I NEED TO DO ABOVE(?)

## Trigger 2
(On Event)
Log: Security
Source: Microsoft-Windows-Security-Auditing
Event ID: 4801

### Actions
Action: Start a Program
Settings:
Program/script: "C:\path\to\PowerShell\7\pwsh.exe"
Add arguments: -File "C:\path\to\winclient-login.ps1"

### Conditions
(All disabled)
```

### windowsupdatechecker.ps1 - Task Scheduler
```
### General
Run whether user is logged on or not [Enabled] (Hides the PS window)
Run with highest privileges [Enabled]
Configure for: Windows 10

### Triggers
Whatever you like!

### Actions
Action: Start a program
Settings:
Program/Script: "C:\Program Files\PowerShell\7\pwsh.exe"
Add arguments(optional): -File "C:\path\to\windowsupdatechecker.ps1"

### Conditions
(All disabled)

### Settings
Allow task to be run on demand [Enabled]
Stop the task if it runs longer than: [1hr]
```