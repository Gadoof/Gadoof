## Ping Sweep

The point of this section is to find targets on the network that you're directly connected to. This process is only meant for internal attacks as attempting this from an external perspective is likely to fail due to blocking of ICMP and lack of access to Layer 2 protocols like ARP. When we can, nmap is a great option for this using the -sn switch, but nmap isn't a standard binary on most systems. Utilizing a for loop to sweep for devices that respond to the ping command is a pretty good methodology, though you miss out on 'fun' attempts at host discovery like ARP, LLMNR, mDNS and the like that nmap is able to perform (with sudo rights). 

#### With nmap, though moving a portable binary of nmap to a target is a good way of getting caught by AV. It's better to Live off the Land (LotL) by using the for loops below as the binaries that are called are not deemed malicious by EDR. 
```
sudo nmap -iL scope -sn -n | tee ping_sweep
```
#### Windows - Very Slow
```
for /l %i in (1,1,254) do @ping -n 1 -w 100 192.168.0.%i | find "Reply"
```
#### Linux
```
for i in {1..254}; do (ping -c 1 192.168.1.$i | grep "bytes from" &); done
```

#### Write that output to file by copying it off the victim and moving it to your attacker machine. REMEMBER to never leave sensitive data on a victim.

The best way to do this is with screen/tmux, and you can either copy the target output into the buffer (ctrl + a; esc then hit enter at beginning and end of data) or you can utilize logging (ctrl + a; H to start and stop) right before running a command to capture that data to kali. EDR will see you if you copy data to the harddrive, and IP information could be suspicious to EDR.

```
cat scope | awk -F " " '{print $4}' | awk -F ":" '{print $1}' | sort -V >> targets
cat targets | xargs mkdir
for i in 192.*;do echo $i > ./$i/scope; done
```

#### Then you cd into each directory/target and run the exact same commands for that target depending on your needs
```
sudo nmap -iL scope -F -oN fast_scan
sudo nmap -iL scope -sV | tee service_scan
sudo nmap -iL scope -A -p- -Pn | tee all_scan
```
#### You can also scan all targets for a specific service like SSH, HTTP, etc.
```
sudo nmap -iL internal_targets -p 80,443,8080,7080,8443,8006,9000,9090,10000 --open | tee http_servers
sudo nmap -iL internal_targets -p 22,2222 --open | tee ssh_servers
```
#### If you're proxying this scan, be sure to wrap with proxychains or whatever tool you're using!
```
sudo proxychains nmap -iL scope -F -sT -Pn | tee fast_scan
```
#### Here are some automation steps to run multiple scans against multiple targets
```
for i in $(cat targets);do sudo nmap -F $i | tee ./$i/fast_scan; done
for i in $(cat targets);do sudo proxychains nmap -F -sT -Pn $i | tee ./$i/fast_scan; done
```
Thanks @VVildFire1 for the help on this one!

#### Additionally, if we have many targets and we need to utilize multi-threading, we can use xargs in a similar fashion. Amount of simultaneous processes is manipulated with -P.
```
cat targets | xargs -I {} -P 4 sudo nmap -F {} | tee -a ./{}.fast_scan
```
