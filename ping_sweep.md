## Ping Sweeps
#### With nmap
```
Sudo nmap -iL scope -sn -n | tee ping_sweep
```
#### Windows
```
for /l %i in (1,1,254) do @ping -n 1 -w 100 192.168.0.%i | find "Reply"
```
#### Linux
```
for i in {1..254} ;do (ping -c 1 192.168.1.$i | grep "bytes from" &) ;done
```

#### Write that output to file, then…
```
cat scope | awk -F " " '{print $4}' | awk -F ":" '{print $1}' | sort -V > internal_targets
Cat internal_targets | xargs mkdir
for i in 192.*;do echo $i > ./$i/scope; done
```

#### Then you cd into each directory/target and run the exact same commands for that target depending on your needs
```
Sudo nmap -iL scope -F -oN fast_scan
Sudo nmap -iL scope -p- -oN full_portscan
Sudo nmap -iL scope -sV -oN service_scan
Sudo nmap -iL scope -A -oN full_scan
Sudo nmap -iL scope -A -p- -Pn -oN all_scan
```
#### If you're proxying this scan, be sure to wrap with proxychains or whatever tool you're using!

#### Of course, there is likely a better way to accomplish this with a single automation for loop to run against each target for each type of scan...
### _WIP!_
```
for dir in */; do if [ -e "${dir}scope" ]; then nmap -iL scope -F -oN fast_scan "${dir}scope"; fi; done
```
