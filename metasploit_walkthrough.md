## Metasploit Framework

####What is Metasploit?

Metasploit is an exploitation framework similar to BlackHills Security's OSINT tool Recon-NG in that it uses modules inside of a platform that is designed to be easy to use for all potential options/attacks, making it easier to use for beginners and amateurs in the industry. Unfortnatly I think that these tools can actually make it more complicated as we're designing something new from the ground up that we now have to learn in case we want to use some built in tools quickly. Either way, metasploit is important and I get questions on this all the time.

####Start Up Metasploit (potentially in proxychains if using over a proxy to pivot through your first victim
```
msfconsole
sudo proxychains msfconsole
```
####Search for modules relating to potential service that you've already scanned down on Target
```
search module_name
search postgresql
```
Outside of metasploit you can run searchsploit, which is similar but will show you more modules most of the time as well as show you where they're at on the file system, so you can interact with the code directly. This can be necessary when you have to manipulate the exploit to match the target. 

####Choosing the right module

This part can be a bit confusing so take your time here. What you're looking for is a module that has a high rank rating (if possible), as well as a module that relates to the proper version of the target. One the main pieces of information you're looking for as an attacker in this situation is the service version numbers of any services being hosted by the target. 

Something to consider is how you search for services here. If the service version of a potential target is 'apache 2.9.53' then you'll start by searching with the following.

```
search apache 2.9.53
```

If that gives you no output, then you 'walk' the search back to be more generic, opening up more possibilities for modules to appear. The reason we do this is because some modules/vulnerabilities will not be known by the very specific version you're seeing, but instead be known by a major or minor version that is nearby. For instance you may not get any returns on 2.9.53, but may get returns on 2.9.

```
search apache 2.9.53
search apache 2.9.5
search apache 2.9.
search apache 2.9
search apache 2.
search apache 2
```

The above is how the search process would happen.

You may have to navigate into the module to first learn more about it, or the module will be something you're looking for, either way, we drop into the module by pointing at the '#' value of the module.

```
use #_value
```

This will drop you into the module. You will have to follow the next steps to then understand the module to see if works for your particular topic.

####Using a module

First thing to do when you drop into a module is to learn about the module itself.

```
show info
```

This will display all relevant information for the module, including historical information, services that are affected by the exploit, and other additional resources.

Next step once you've validated you want to test this module against your target, you then check the potential variables that need to be changed to configure the module for exploitation.

```
show options
```

Now, what you'll want to do is manipulate any variable that isn't currently set to anything, that also has a 'yes' value in the Required column. 

You then make a change command to that variable.

```
show options
set variable_name true|false|other_variable
set rhosts 192.168.1.10
show options
```

I recommend validating the changes before and after so you can make sure the variable gets set properly as there is no error handling it seems in metasploit.

Once all your required variables are set, it's time to execute.

```
run
exploit
```

You can run either 'run' or 'exploit' to make the module fire.
