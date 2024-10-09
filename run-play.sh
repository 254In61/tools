#!/usr/bin/bash
git_repo=juniper-software-upgrade
playbook=site.yml

echo "" && echo "==> Delete existing roles" && echo ""
rm -rf $HOME/.ansible/roles

echo "" && echo "==> Set env variables" && echo ""
source env-vars

git clone https://github.com/254In61/$git_repo.git
cd $git_repo

echo "" && echo "==> Pull down roles from git" && echo ""
ansible-galaxy install -r roles/requirements.yml

echo "" && echo "==> Run playbook" && echo ""
ansible-playbook $playbook -i inventory/staging.ini -e "@$HOME/secrets.yml"

echo "" && echo "==> Clean up" && echo ""
cd ..
rm -rf $git_repo