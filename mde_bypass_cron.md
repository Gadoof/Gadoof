# EDR Bypass against MDE on Ubuntu 20.04
#### this was written by a human

### Looking into some potential EDR bypass techniques against Microsoft Defender for Endpoint specifically on Ubuntu 20.04. 

I've been really interested in looking into bypass techniques ever since I got into cybersecurity, and I remember when I was a junior pentester, the general notion was that EDR was an advanced form of Antivirus (AV) and it was changing the game in terms of adding complexity to attack. 

Eventually, I found out that really, all it takes is a dedicated attacker to perform recon against a target, determine the EDR that the target is using, and then to spend some dev time researching a bypass. I was under the impression that this took quite a bit of resources, especially when talking about some of the better EDR solutions out there. From what I could tell, these included Crowdstrike, Microsoft, Cylance, CarbonBlack, and a few others depending on who you talk to. 

This reminds me of the _Big Short_...everyone assumes EDR is good, but nobody really looks at it. So, let's actually take a look at one of the bigger EDR's on the market and how well they're doing defending Linux operating systems, starting specifically with Ubuntu 20.04, _not for any particular reason other than maybe my latest hatred for [RedHat's recent design decisions](https://www.phoronix.com/news/Red-Hat-Open-Source-Commitment)._

##### **_Let's get it!!!_**

# Target

- Debian Ubuntu 20.04
- Fully updated
- Default Image in Azure and On-Prem
- Valid as of 8/11/23

### Kernal Information:
```
techsupport@LinuxVM003:~$ uname -a
Linux LinuxVM003 5.15.0-1042-azure #49~20.04.1-Ubuntu SMP Wed Jul 12 12:44:56 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
```
### MDE Config on Endpoint:

This is as secure as I can get the MDE EDR to be configured, and as this is just a test environment w/o any real automation tools like GPO, Intune, etc. I had to enable behavior_monitoring as that isn't enabled by default, and thus MDE by default w/o any tools doesn't block by default but instead acts in a passive config, noting malicious code in Defender portal, but not blocking.

Enabling behavior_monitoring changed the config to a more *active* configuration, blocking anything that it deems malicious.

```
techsupport@LinuxVM003:~$ mdatp health
healthy                                     : true
health_issues                               : []
licensed                                    : true
engine_version                              : "1.1.23070.1002"
app_version                                 : "101.23062.0010"
org_id                                      : "b6cafe3e-bf50-4d8d-829a-d68b3fd21827"
log_level                                   : "info"
machine_guid                                : "ae672b31-45db-467e-a9be-401284530c07"
release_ring                                : "Production"
product_expiration                          : Apr 10, 2024 at 01:34:28 PM
cloud_enabled                               : true
cloud_automatic_sample_submission_consent   : "safe"
cloud_diagnostic_enabled                    : false
passive_mode_enabled                        : false
behavior_monitoring                         : "enabled"
real_time_protection_enabled                : true
real_time_protection_available              : true
real_time_protection_subsystem              : "fanotify"
supplementary_events_subsystem              : "auditd"
tamper_protection                           : "disabled"
automatic_definition_update_enabled         : true
definitions_updated                         : Aug 12, 2023 at 03:26:24 AM
definitions_updated_minutes_ago             : 159
definitions_version                         : "1.395.227.0"
definitions_status                          : "up_to_date"
edr_early_preview_enabled                   : "disabled"
edr_device_tags                             : []
edr_group_ids                               : ""
edr_configuration_version                   : "30.199999.icm411710458.2023.08.10.04-54CD2DC991A7EBDEECB7784DAEEF452E6527FEC2BDC3983DD35212875E773F
34"
edr_machine_id                              : "94cb840531fd5d9f8031cd26317eed0c72b08d7e"
conflicting_applications                    : []
network_protection_status                   : "stopped"
network_protection_enforcement_level        : "disabled"
troubleshooting_mode                        : false
```

## The Goal?

## _Find a Bypass_

Normally what I'd prepare to do here is attempt encoding/obfuscation techniques, memory techniques, you know, some extracarricular **wizardry**, but in this writeup I want to show what I found after some extremely basic testing.

## The Technique

TLDR: It's extremely basic; all I'm doing here is utilizing an extremely common persistence technique utilizing cronjob (crontab -e) to force the system to run a very basic, unencoded python reverse shell. This works with standard user permissions. Nothing else is required to get this to work.

## The Rub

TLDR: I don't understand. This process is extremely well known to attackers, and is an extremely common process; forcing the system to run malicious code. It's so common, that I'd say it's one of the first things that are tried, as in it's already built into the process. I'm not 100% on how the EDR is failing this check on the malicious code being ran by cron, but if it's due to it being called by system via cron, there are likely many other bypass techniques that are just waiting to be found.
It's completely possi0ble that I don't understand the complexity of what the EDR is capable of on Linux, but what I do know is that the code itself, is without a doubt, malicious. It gets caught when it runs on terminal, so why doesn't it get caught when ran in cron?



