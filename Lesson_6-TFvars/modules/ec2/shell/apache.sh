#!/bin/bash
sudo apt update && sudo apt -y upgrade
sudo apt install -y apache2
echo "<h1>Hello, World!</h1>" > /var/www/html/index.html
sudo service apache2 start