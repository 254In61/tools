#!/usr/bin/bash
# Small script to synch stuff for me in client side
# Client uses gitlab, I am using github for my dev.
# example use.*** While inside the root file with gitlab and github subdirs
# $ ~/tools/synch.sh

## Assumptions:
## a. Your environment has access to gitlab and github
## b. Your environment already has the 2 credentials set.

if [ -z "$1" ]; then
   echo "Usage: $0 <repo-name>"
   exit 1
fi

repo_name=$1

echo "" && echo "==> REPO NAME : $repo_name" && echo ""

echo "" && echo "==> Create gitlab and github directories" && echo ""
mkdir $HOME/gitlab
mkdir $HOME/github

echo "" && echo "==> clone from github to the local" && echo ""
cd $HOME/github && git clone https://github.com/254In61/$repo_name.git

echo "" && echo "==> clone from gitlab to the local" && echo ""
cd $HOME/gitlab && git clone https://gitlab.vodafone.com.au/redhat/$repo_name.git

echo "" && echo "==> Refresh files on the gitlab side" && echo ""
rm -rf $HOME/gitlab/$repo_name/*
cp -r $HOME/github/$repo_name/* $HOME/gitlab/$repo_name
cp $HOME/github/$repo_name/.gitignore $HOME/gitlab/$repo_name

echo "" && echo "==> git update on gitlab side" && echo ""
cd $HOME/gitlab/$repo_name && $HOME/tools/git-run.sh

echo "" && echo "==> clean up files " && echo ""
rm -rf $HOME/gitlab/$repo_name
rm -rf $HOME/github/$repo_name

# end of file


