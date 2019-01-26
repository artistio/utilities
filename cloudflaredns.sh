#!/bin/bash

# Name: cloudflaredns.#!/bin/sh
# Version: 1.0.0
# Script to update Cloudflare DNS Record
# Can be run for each boot

CFZONEID=<Zone ID>
CFAPIID=<API Key>
CFEMAIL=<Email Address>
CFDNSRECID=<DNS Record to update>
HOSTNAME=<DNS Hostname to update>

# For EC2 Environment
MYPUBLICIP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`

echo "Updating IP for $HOSTNAME to $MYPUBLICIP"

curl -X PUT "https://api.cloudflare.com/client/v4/zones/$CFZONEID/dns_records/$CFDNSRECID" \
     -H "X-Auth-Email: $CFEMAIL" \
     -H "X-Auth-Key: $CFAPIID" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"A\",\"name\":\"$HOSTNAME\",\"content\":\"$MYPUBLICIP\",\"ttl\":1,\"proxied\":false}"
