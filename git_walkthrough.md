## Git

#### For initial configuration, be sure that you add your public RSA key to your github account

You can find this info by clicking your profile at the top right and going to Settings, and then choosing SSH and GPG keys on the left.

Add your PUBLIC key to this repo, remember not to add your private key. You'll set your private key later on your client to use to authenticate to github.

#### Then, you need to clone a remote repository to your device.

```
git clone https://github.com/Gadoof/Gadoof.git
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
ssh-add _~/privkeylocation_
ssh-add -l
ssh -T git@github.com
```
#### This should ask you for your passphrase and log you in.

#### We then need to add our remote repository.

```
git remote add origin git@github.com:Gadoof/Gadoof.git
git remote set-url origin git@github.com:Gadoof/Gadoof.git
git remote -v
git status
```

#### This should indicate that you have properly added the remote repository and are correctly configured to push changes.

#### Now we make changes to our directory and files, then push changes to our github.

```
nano whatever.md
git add -A
git commit -am "whateveryouwant"
git push --set-upstream origin main
```
note: you only have to run --set-upstream once, and after that it isn't necessary but it will still work.

also note: don't run the git push command with sudo as it will break

#### This should succeed and you should be good to go!
