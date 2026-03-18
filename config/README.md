<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society
Copyright © 2026 Ernst Strüngmann Institute (ESI) of the Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Configuration Examples For Common Services 

This directory contains (stubs of) config files and settings for common services 
that have been proven to be not straight-forward to set up from scratch. 

## SSH Client Configuration 

The file [ssh_config](./ssh_config) includes exemplary host-blocks that illustrate 
how to set up a personal ssh configuration file. The syntax is identical on all 
operating systems supported by `ssh` (Windows, macOS, Linux). By default the `ssh` 
command looks for user settings in a file named `config` inside a hidden `.ssh` 
folder of your "home" directory, i.e., 

- **Windows**: `C:\Users\<username>\.ssh\config`
- **macOS**: `/Users/<username>/.ssh/config`
- **Linux**: `/home/<username>/.ssh/config`

The enclosed exemplary configuration consists of several blocks that show how to 
point `ssh` to use a specific key for a given remote host. For instance, the initial 
example instructs `ssh` to use the (existing!) key `id_workstation` to connect to 
the host with the IP address 192.168.123.99. For this to work, you have to first 
set up and deploy the specified ssh key. 

### Create A New SSH Key

Sticking with the initial example in [ssh_config](./ssh_config) we start with 
creating a key-pair `id_workstation` using `ssh-keygen`:

- **Windows (PowerShell)**
  ```powershell
  md -Force .ssh
  ssh-keygen -t ed25519 -f C:\Users\<username>\.ssh\id_workstation
  ```

- **macOS**/**Linux**
  ```shell
  mkdir -p ~/.ssh
  ssh-keygen -t ed25519 -f ~/.ssh/id_workstation
  ```

You may or may not provide a passphrase for your key. After successful completion 
of the above `ssh-keygen` command you should see two new files in your `.ssh` 
directory: 

- **`id_workstation`**: the *private key* 
- **`id_workstation.pub`**: the *public key* 

The private key should **never** leave your local computer, while the public key 
can be seen by everyone everywhere (you can even send it around via email if you 
like).

### Deploy The Public Key

Next, you need to tell the remote host (192.168.123.99 in this example) about your 
new key. This can be done using the `ssh-copy-id` command:

- **Windows (PowerShell)**
  ```powershell
  ssh-copy-id -i C:\Users\<username>\.ssh\id_workstation remoteuser@192.168.123.99
  ```

- **macOS**/**Linux**
  ```shell
  ssh-copy-id -i ~/.ssh/id_workstation remoteuser@192.168.123.99
  ```


The `remoteuser` in the above command refers to your username on the remote host 
192.168.123.99 (which is not necessarily the same as your username on your local 
laptop!). You will be prompted for the password of `remoteuser`. 

### Test The Connection 

Everything's in place now, you should be able to connect to the remote host 
192.168.123.99 by typing 

``` shell
ssh myworkstation
```

without having to specify a password. 

## Git Filters

Filters are one of the most powerful yet least known features in git. They permit
to modify files "in-flight" at checkout and/or commit. A filter can be applied to 
content before it is committed to the repository (a so-called **clean** filter) 
and/or after it has been checked out (a **smudge** filter). Among other things, 
a clean filter is particularly useful for clipping sensitive information from, 
e.g., config files before committing to a repository.  

Assume, you interact with a web service that requires authentication via an API 
key in a specially structured json file, called [settings.json](./git_filters/settings.json). 
The file does not only contain the key but also various other important configuration 
settings, so you want to include it in your git repository - without leaking your 
private API key to a your public GitHub remote, of course. 

To set up git for this only requires setting up two git configuration files:

- [.gitconfig](./git_filters/.gitconfig): Definition of the actual filter 
  (a [sed](https://www.gnu.org/software/sed/manual/sed.html) regular expression) 
- [.gitattributes](./git_filters/.gitattributes) Specifcation which files to apply 
  what filter(s) to

Copy/Create both files in the root of your git repo (where the `.git` directory is). 
Next, git needs to know about the filter defined in [.gitconfig](./git_filters/.gitconfig): 
in the root of you git repository, run the following command (verbatim)

```shell
git config --local include.path ../.gitconfig
```

Check if the filter has been set up correctly:

```shell
git config --list --show-origin 
# the last line should show 
# file:.git/../.gitconfig filter.apikey.clean=sed -E ... 
```

The spec file [.gitattributes](./git_filters/.gitattributes) is picked up by git 
automatically. That's it, your new git filter is ready for action! 

To test out the given exemplary [settings.json](./git_filters/settings.json), 
create a new git repo and copy all files in the [git_filters](./git_filters)
directory to it:

``` shell
cd ~/
mkdir test-repo
cd test-repo
git init 
git config user.name "Luke Skywalker"
git config user.email luke.skywalker@rebels.org
cp -r /path/to/esi-ntials/config/git_filters/. .
git add .gitattributes .gitconfig 
git commit -m "initial commit"
git config --local include.path ../.gitconfig
git add settings.json
git commit -m "test commit"
git cat-file -p HEAD:settings.json # should show "api-key" instead of the "real" key
cat settings.json # should still contain the "real" key
```

More (much more!) information about git filters can be found in the 
[Git Book](https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes). 
