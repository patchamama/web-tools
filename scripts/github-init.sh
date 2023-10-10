reponame=$(basename $(pwd))
# Change your username here
repousername=patchamama

echo Initializing repo: $repo...

echo "# $repo" >> README.md
echo "" >> README.md
echo "## Description" >> README.md
echo "" >> README.md
echo "## Installation" >> README.md
echo "" >> README.md
echo "## Usage" >> README.md
echo "" >> README.md
echo "## Contributing" >> README.md
echo "" >> README.md
echo "## License" >> README.md
echo "" >> README.md
echo "## Project status" >> README.md
echo "" >> README.md
echo "## Author" >> README.md
echo "" >> README.md
echo "## Acknowledgements" >> README.md
echo "" >> README.md
echo "## Contact" >> README.md
echo "" >> README.md
echo "## Project link" >> README.md
echo "" >> README.md
echo "## Project dependencies" >> README.md
echo "" >> README.md

git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/$repousername/$reponame.git > repo.sh
git push -u origin main >> repo.sh
