#!/bin/bash
sudo apt-get update && apt-get -y install apache2
echo '<!doctype-html><html><body><h1> Hi!! Apache is Running here ! </h1></body></html>' | sudo tee /var/www/html/index.html
