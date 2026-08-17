#!/bin/bash

# --- CONFIGURATION ---
TARGET_DIR="lab"
KEY_FILE="vockey.pem"
USER="ec2-user"

# Replace this with your actual Windows username!
WINDOWS_USER="YourWindowsUsername" 
WINDOWS_DOWNLOADS="/mnt/c/Users/$WINDOWS_USER/Downloads/labsuser.pem"

# 1. Grab the file from Windows if it's there
if [ -f "$WINDOWS_DOWNLOADS" ]; then
    echo "Found new labsuser.pem in Windows Downloads! Moving it to WSL..."
    mv "$WINDOWS_DOWNLOADS" "$TARGET_DIR/$KEY_FILE"
fi

# 2. Change to the lab directory
cd "$TARGET_DIR" || { echo "Error: Could not find the '$TARGET_DIR' directory."; exit 1; }

# 3. Safety check: Ensure vockey.pem exists before continuing
if [ ! -f "$KEY_FILE" ]; then
    echo "Error: Could not find $KEY_FILE. Did you download labsuser.pem?"
    exit 1
fi

# 4. Secure the key file 
chmod 400 "$KEY_FILE"

# 5. Prompt you for the IP address
read -p "Enter your EC2 instance IP address: " IP

if [ -z "$IP" ]; then
    echo "Error: No IP address provided."
    exit 1
fi

echo "Connecting to $USER@$IP..."

# 6. Connect via SSH
ssh -i "$KEY_FILE" -o StrictHostKeyChecking=no "$USER@$IP"