#!/usr/bin/bash
echo "" && echo "==> CODE QUALITY CHECKS - yamllint " && echo ""
yamllint -c ~/code-check/.yamllint.yaml playbooks/*.yml
yamllint -c ~/code-check/.yamllint.yaml roles/*/tasks/*.yml

echo "" && echo "==> configure-aap/ CODE QUALITY CHECKS - ansible-lint " && echo ""
#ansible-lint playbooks/*
#ansible-lint roles/*/tasks/*.yml
