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

if [[ -z `git diff --exit-code` ]]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

git add -A
git commit -m "Deploy to GitHub Pages: ${SHA}"
git push origin master
