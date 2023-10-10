reponame=$(basename $(pwd))
# Change your username here
repousername=patchamama

echo "Do you want to merge with the main branch the pull request? (y/n)"
read answer
if [ "$answer" == "y" ]
then
    open -a "Google Chrome" https://github.com/$repousername/$reponame
fi

exit


# Clone the repository
#git clone <repository_url>

# Change to the repository directory
#cd <repository_name>

# Create a new branch
git checkout -b new-proposed-feature

# Make changes to the files
# ...

# Add the changes to the branch
git add .

# Commit the changes
git commit -m "new proposed feature"

# Push the branch to GitHub
git push origin new-proposed-feature

# Create a pull request on GitHub
echo Go to the repository page on GitHub
echo Click on the "Pull Requests" tab
echo Click on the "New Pull Request" button
echo Select the branch you just pushed
echo  Click on the "Create Pull Request" button
open -a "Google Chrome" https://github.com/$repousername/$reponame

echo "Do you want to merge with the main branch the pull request? (y/n)"
read answer
if [ "$answer" == "y" ]
then
    git checkout main
    git merge new-proposed-feature
    git push --set-upstream origin new-proposed-feature
fi

echo "Do you want to delete the branch? (y/n)"
read answer
if [ "$answer" == "y" ]
then
    git branch -d new-proposed-feature
    # git push origin --delete new-proposed-feature
fi

git branch
