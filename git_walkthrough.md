## Git

#### First you need to clone a remote repository to your device.

```git clone https://github.com/Gadoof/Gadoof.git```

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

#### This should succeed and you should be good to go!
