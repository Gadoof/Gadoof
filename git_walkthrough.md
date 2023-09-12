## Git

#### For initial configuration, be sure that you add your public RSA key to your github account

You can find this info by clicking your profile at the top right and going to Settings, and then choosing SSH and GPG keys on the left.

#### If you haven't already, create an RSA key pair. The easiest way to do this is on the linux terminal.

```
ssh-keygen
```

#### You'll want to make sure you know where your private and public key are on your linux filesystem. They're by default saved to ~/.ssh/id_rsa(.pub). 

#### Add your _PUBLIC_ key to this repo, remember not to add your private key. You'll set your private key later on your client to use to authenticate to github.

#### Make sure you create a new access token to authenticate. [Find this here.](https://github.com/settings/tokens)

When you first create the token the string will be shown but it won't be shown again. *Be sure to save this.*

#### Run this command to set username and email, otherwise you'll get output that's unnecessary.

```
git config --global --edit
```
Uncomment the username and email lines.
We also need to add in our key to this config file otherwise we'll have to setup authentication every time we boot/for each session.
******WIP

#### Create .git-credentials file in your home directory and add your token to this file.

```
cd ~
nano .git-credentials

username:TOKEN@git@github.com:Gadoof/Gadoof.git
```

#### Then, you need to clone a remote repository to your device.

```
git clone git@github.com/Gadoof/Gadoof.git
```

#### Once you have a local copy, we need to verify first that nothing is configured.

```
git status

git remote -v

ssh -T git@github.com
```

#### We should recieve responses here indicating nothing has been configured yet. Remember to always "check" yourself while on the terminal so you always know the current scenario.

#### We then need to add our SSH RSA private key to the ssh client.

```
eval "$(ssh-agent -s)"
ssh-add -l
ssh-add ~/.ssh/privkey
ssh-add -l
ssh -T git@github.com
```
#### This should ask you for your passphrase and log you in.

#### We then need to add our remote repository.

```
git remote -v
git status
```
### Note that you may have to run 'git remote set-url origin git@github.com:Gadoof/Gadoof.git' if the remote repo is set to HTTPS.

#### This should indicate that you have properly added the remote repository and are correctly configured to push changes.

#### Now we make changes to our directory and files, then push changes to our github.

```
nano whatever.md
git add -A
git commit -am "whateveryouwant"
git push
```
note: you only have to run '--set-upstream origin main' once, and after that it isn't necessary but it will still work.

also note: don't run the git push command with sudo as it will break

#### This should succeed and you should be good to go!
