set -e

SHA=`git rev-parse --verify HEAD`

git clone git@github.com:CaronaBoard/caronaboard.github.io.git caronaboard.github.io
# rm -rf caronaboard.github.io/*
# rm -rf caronaboard.github.io/**/*
# cp -R build/* caronaboard.github.io
# cd caronaboard.github.io
#
# echo "caronaboard.com" >> CNAME
# echo "www.caronaboard.com" >> CNAME

git config user.name "Circle CI"
git config user.email "circle-ci@caronaboard.com"

# git add -A
# git commit -m "Deploy to GitHub Pages: ${SHA}" || echo "nothing to commit"
git commit --amend --no-edit
git push origin master
