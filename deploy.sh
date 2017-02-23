set -e

SHA=`git rev-parse --verify HEAD`

openssl aes-256-cbc -K $encrypted_6d2f7c519862_key -iv $encrypted_6d2f7c519862_iv -in id_rsa_caronaboard.enc -out id_rsa_caronaboard -d
chmod 400 id_rsa_caronaboard

eval `ssh-agent -s`
ssh-add id_rsa_caronaboard

git clone git@github.com:CaronaBoard/caronaboard.github.io.git caronaboard.github.io
rm -rf caronaboard.github.io/*
rm -rf caronaboard.github.io/**/*
cp -R build/* caronaboard.github.io
cd caronaboard.github.io

echo "www.caronaboard.com" > CNAME

git config user.name "Travis CI"
git config user.email "travis-ci@caronaboard.com"

git add -A
git commit -m "Deploy to GitHub Pages: ${SHA}" || echo "nothing to commit"
git push origin master
