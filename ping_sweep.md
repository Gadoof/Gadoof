## Ping Sweep

The point of this section is to find targets on the network that you're directly connected to. This process is only meant for internal attacks as attempting this from an external perspective is likely to fail due to blocking of ICMP and lack of access to Layer 2 protocols like ARP. When we can, nmap is a great option for this using the -sn switch, but nmap isn't a standard binary on most systems. Utilizing a for loop to sweep for devies that respond to the ping command is a pretty good methodology, though you miss out on 'fun' attempts at host discovery like ARP, LLMNR, mDNS and the like that nmap is able to perform (with sudo rights). 

#### With nmap, though moving a portable binary of nmap to a target is a good way of getting caught by AV.
```
sudo nmap -iL scope -sn -n | tee ping_sweep
```
#### Windows
```
for /l %i in (1,1,254) do @ping -n 1 -w 100 192.168.0.%i | find "Reply"
```
#### Linux
```
for i in {1..254} ;do (ping -c 1 192.168.1.$i | grep "bytes from" &) ;done
```

#### Write that output to file by copying it off the victim and moving it to your attacker machine. REMEMBER to never leave sensitive data on a victim.

```
cat scope | awk -F " " '{print $4}' | awk -F ":" '{print $1}' | sort -V >> internal_targets
cat internal_targets | xargs mkdir
for i in 192.*;do echo $i > ./$i/scope; done
```

#### Then you cd into each directory/target and run the exact same commands for that target depending on your needs
```
sudo nmap -iL scope -F -oN fast_scan
sudo nmap -iL scope -p- -oN full_portscan
sudo nmap -iL scope -sV | tee service_scan
sudo nmap -iL scope -A | tee all_scan
```
#### You can also scan all targets for a specific service like SSH, HTTP, etc.
```
sudo nmap -iL internal_targets -p 80,443,8080,7080,8443,8006,9000,9090,10000 --open | tee http_servers
```
#### If you're proxying this scan, be sure to wrap with proxychains or whatever tool you're using!
```
sudo proxychains nmap -iL scope -F -sT -Pn | tee fast_scan
```
#### Of course, there is likely a better way to accomplish this with a single automation for loop to run against each target for each type of scan...
### _WIP!_
```
for dir in */; do if [ -e "${dir}scope" ]; then nmap -iL scope -F -oN fast_scan "${dir}scope"; fi; done
```
