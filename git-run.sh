#!/usr/bin/bash
echo "" && echo "===> initial git status? " && echo ""
git status

echo "" && echo "===> add >> commit >> push " && echo ""
git add * 
git commit -m "Updates @ $(date)"
git push

echo "" && echo "===> current git status? " && echo ""
echo "" && git status
