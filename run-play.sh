#!/usr/bin/bash
rm -rf $HOME/.ansible/roles
cd aap-objects-build
git pull
source ../env-vars
ansible-galaxy install -r roles/github-requirements.yml
ansible-playbook site.yml
