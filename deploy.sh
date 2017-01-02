SHA=`git rev-parse --verify HEAD`

git clone https://github.com/CaronaBoard/caronaboard.github.io
rm -rf caronaboard.github.io/**/*
cp -R build/* caronaboard.github.io
cd caronaboard.github.io

git config user.name "Snap CI"
git config user.email "snap-ci@caronaboard.com"

ssh-agent
ssh-add /var/snap-ci/repo/id_rsa_caronaboard

if [ -z `git diff --exit-code` ]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

git add -A
git commit -m "Deploy to GitHub Pages: ${SHA}"
git push origin master
