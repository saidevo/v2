#!/bin/bash
sudo yum update
sudo yum install httpd -y
# Check if oxer.zip exists
if [ -e oxer.zip ]; then
    echo "oxer.zip already exists. Skipping download."
else
    wget https://www.free-css.com/assets/files/free-css-templates/download/page296/oxer.zip
fi

# Continue with the installation
sudo unzip -o oxer.zip   # -o flag to overwrite existing files
sudo mv -f ./oxer-html /var/www/html/   # -f flag to force move even if destination exists

sudo systemctl enable httpd
sudo systemctl start httpd