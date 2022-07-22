#!/bin/bash

sudo apt-get update -y && sudo apt install apache2 -y
sudo ufw allow 'Apache'
sudo ufw enable

cd /var/www/html

echo "<html>" > index.html
echo "<h1>Welcome to Tuntun page</h1>" >> index.html
echo "<h4>Page 1</h4>" >> index.html
echo "<a href='/tab2.html'>Tab2</a>" >> index.html
echo "</html>" >> index.html

echo "<html>" > tab2.html
echo "<h1>Welcome to Tuntun page</h1>" >> tab2.html
echo "<h4>Page 2</h4>" >> tab2.html
echo "<a href='/index.html'>Tab1</a>" >> tab2.html
echo "</html>" >> tab2.html
