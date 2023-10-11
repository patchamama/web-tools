reponame=$(basename $(pwd))
# Change your username here
repousername=patchamama

if [ -n "$1" ]
then
    comment=$1
else
    comment="new proposed feature"    
fi

collaboration=""
if [ -f "collaboration.txt" ]; then
    collaboration=$(head -n 1 collaboration.txt)
fi
echo Collaboration defines: $collaboration

echo "Do you want to add a collaboration name? (y/n)"
read answer
if [ "$answer" == "y" ]
then
    echo "Enter the collaboration name:"
    read name
    echo "Enter the collaboration github name:"
    read githubname
    collaboration="$collaboration Co-authored-by: $name <$githubname@users.noreply.github.com> "

    echo $collaboration > collaboration.txt
    # git commit -m "README updated Co-authored-by: Armando Urquiola Cabrera <patchamama@users.noreply.github.com> Co-authored-by: Alberto Cabrera <albecabrera@users.noreply.github.com>"
    echo Collaboration added: $collaboration

    bash $0
    exit 0
fi

# read -p "Press enter to continue"

# Clone the repository
#git clone <repository_url>

# Change to the repository directory
#cd <repository_name>
newbranchname=""
echo "Do you want to create the pull request in a new branch? (y/n)"
read answer
if [ "$answer" == "y" ]
then
    # Create a new branch
    newbranchname="new-proposed-feature"
    git checkout -b $newbranchname
fi

# Make changes to the files
# ...

# Add the changes to the branch
git add .

# Commit the changes
git commit -m "$comment $collaboration"

if ! [ "$newbranchname" == "" ]
then

    # Push the branch to GitHub
    git push origin $newbranchname

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
else
    git push
    # git push origin main
fi

git branch
