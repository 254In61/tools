#!/usr/bin/bash
echo "" && echo "==> Delete existing roles" && echo ""
rm -rf $HOME/.ansible/roles

echo "" && echo "==> Set env variables" && echo ""
source env-vars

cd aap-objects-build
git pull

echo "" && echo "==> Pull down roles from git" && echo ""
ansible-galaxy install -r roles/github-requirements.yml

echo "" && echo "==> Run playbook" && echo ""
ansible-playbook site.yml
