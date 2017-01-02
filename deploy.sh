set -e

SHA=`git rev-parse --verify HEAD`

eval `ssh-agent -s`
ssh-add /var/snap-ci/repo/id_rsa_caronaboard

git clone git@github.com:CaronaBoard/caronaboard.github.io.git
rm -rf caronaboard.github.io/**/*
cp -R build/* caronaboard.github.io
cd caronaboard.github.io

git config user.name "Snap CI"
git config user.email "snap-ci@caronaboard.com"

git add -A
git commit -m "Deploy to GitHub Pages: ${SHA}"
git push origin master
