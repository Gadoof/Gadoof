# EDR Bypass against MDE on Ubuntu 20.04
#### this was written by a human

### Looking into some potential EDR bypass techniques against Microsoft Defender for Endpoint specifically on Ubuntu 20.04. 

I've been really interested in looking into bypass techniques ever since I got into cybersecurity, and I remember when I was a junior pentester, the general notion was that EDR was an advanced form of Antivirus (AV) and it was changing the game in terms of adding complexity to attack. 

Eventually, I found out that really, all it takes is a dedicated attacker to perform recon against a target, determine the EDR that the target is using, and then to spend some dev time researching a bypass. I was under the impression that this took quite a bit of resources, especially when talking about some of the better EDR solutions out there. From what I could tell, these included Crowdstrike, Microsoft, Cylance, CarbonBlack, and a few others depending on who you talk to. 

This reminds me of the _Big Short_...everyone assumes EDR is good, but nobody really looks at it. So, let's actually take a look at one of the bigger EDR's on the market and how well they're doing defending Linux operating systems, starting specifically with Ubuntu 20.04, _not for any particular reason other than maybe my latest hatred for [RedHat's recent design decisions](https://www.phoronix.com/news/Red-Hat-Open-Source-Commitment)._

### Let's get it

# Target

- Debian Ubuntu 20.04
- Fully updated
- Default Image in Azure and On-Prem
- Valid as of 8/11/23

## The Goal?

## _Find a Bypass_

Normally what I'd prepare to do here is attempt encoding/obfuscation techniques, memory techniques, you know, some extracarricular **wizardry**, but in this writeup I want to show what I found after some extremely basic testing.

## The Technique

TLDR: It's extremely basic; all I'm doing here is utilizing an extremely common persistence technique utilizing cronjob (crontab -e) to force the system to run a very basic, unencoded python reverse shell. This works with standard user permissions. Nothing else is required to get this to work.

## The Rub

TLDR: I don't understand. This process is extremely well known to attackers, and is an extremely common process; forcing the system to run malicious code. It's so common, that I'd say it's one of the first things that are tried, as in it's already built into the process. I'm not 100% on how the EDR is failing this check on the malicious code being ran by cron, but if it's due to it being called by system via cron, there are likely many other bypass techniques that are just waiting to be found.
It's completely possi0ble that I don't understand the complexity of what the EDR is capable of on Linux, but what I do know is that the code itself, is without a doubt, malicious. It gets caught when it runs on terminal, so why doesn't it get caught when ran in cron?



