# WSL to AWS EC2 Labs Guide

Short description: A simple WSL script workflow that automatically moves `labsuser.pem` from Windows Downloads to WSL `lab/` as `vockey.pem`, asks for EC2 IP, and connects via SSH.

This guide explains how to use `connect.sh` from WSL to connect to your AWS EC2 lab instance.

## Prerequisites

- Windows + WSL installed
- SSH available in WSL
- `labsuser.pem` downloaded from AWS Labs to your Windows Downloads folder
- `connect.sh` file prepared

## Step-by-Step Procedure

1. Open WSL first.
2. Go to your home directory:

```bash
cd ~
```

3. Create a `lab` directory (this is where your `.pem` file will be stored):

```bash
mkdir -p lab
```

4. Create or edit `connect.sh`:

```bash
vi connect.sh
```

Paste your script content, then update the value of `WINDOWS_USER`:

```bash
WINDOWS_USER="YourWindowsUsername"
```

Replace `YourWindowsUsername` with your actual Windows username.

Save and exit, then give execute permission:

```bash
chmod +x connect.sh
```

5. Run the script:

```bash
./connect.sh
```

## What the Script Does (Workflow)

When you run `./connect.sh`, it will:

1. Check if `labsuser.pem` exists in your Windows Downloads folder:
   - `/mnt/c/Users/<WindowsUser>/Downloads/labsuser.pem`
2. Move it into your WSL `lab` directory and rename it to `vockey.pem`.
3. Go into the `lab` directory.
4. Set secure permission on the key:
   - `chmod 400 vockey.pem`
5. Ask for your EC2 public IP in the terminal.
6. Connect automatically via SSH using:
   - user: `ec2-user`
   - key: `vockey.pem`

## Important Notes

- If `WINDOWS_USER` is wrong, the script will not find your key in Downloads.
- If `lab` directory does not exist, script will fail at `cd lab`.
- If no key is found, you will see:
  - `Error: Could not find vockey.pem. Did you download labsuser.pem?`

## Quick Check Commands

Check if key was moved:

```bash
ls -l ~/lab
```

Check script permission:

```bash
ls -l ~/connect.sh
```

## Example Run

```text
$ ./connect.sh
Found new labsuser.pem in Windows Downloads! Moving it to WSL...
Enter your EC2 instance IP address: 3.25.100.10
Connecting to ec2-user@3.25.100.10...
```
