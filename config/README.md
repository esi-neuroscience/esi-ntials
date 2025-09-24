<!--
Copyright © 2025 Ernst Strüngmann Institute (ESI) for Neuroscience 
in Cooperation with Max Planck Society

SPDX-License-Identifier: CC-BY-SA-4.0
-->

# Configuration Examples For Common Services 

This directory contains (stubs of) config files and settings for common services 
that have been proven to be not straight-forward to set up from scratch. 

## SSH Client Configuration 

The file [ssh_config](./ssh_config) includes exemplary host-blocks that illustrate 
how to set up a personal ssh configuration file. The syntax is identical on all 
operating systems supported by ssh (Windows, macOS, Linux). By default the `ssh` 
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
