#!/bin/bash

ansible-playbook $@ -s -u deployer -i inventory ../ansible/site.yml  -k -K
