#!/bin/bash
SECRET=$(kubectl get secret eck-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo)
jq -n --arg secret "$SECRET" '{"secret":$secret}'