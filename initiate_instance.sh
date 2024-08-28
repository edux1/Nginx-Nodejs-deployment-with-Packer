#!/bin/bash

# Install AWS CLI
sudo apt-get update
sudo apt-get install -y awscli

# Configure AWS CLI
aws configure <<EOL
<access_key>
<secret_key>
eu-west-3

EOL
