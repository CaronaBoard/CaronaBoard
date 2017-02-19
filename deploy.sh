set -e

SHA=`git rev-parse --verify HEAD`

eval `ssh-agent -s`
ssh-add id_rsa_caronaboard

git clone git@github.com:CaronaBoard/caronaboard.github.io.git
rm -rf caronaboard.github.io/**/*
cp -R build/* caronaboard.github.io
cd caronaboard.github.io

git config user.name "Travis CI"
git config user.email "travis-ci@caronaboard.com"

git add -A
git commit -m "Deploy to GitHub Pages: ${SHA}" || echo "nothing to commit"
git push origin master
