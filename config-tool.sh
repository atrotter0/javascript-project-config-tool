#!/bin/bash
# A Bash script to configure the git pairs file and construct basic JavaScript project structure.

# set base directory to copy assets from
baseDirectory=$(pwd)

# Prompt and set up git pairs file
echo Do you need to set up your git pairs file? Enter y/n
read input

if [ $input == "yes" ] || [ $input == "y" ] || [ $input == "Y" ]
then
  # Get user 1 data
  echo Enter first pair initials, first name, last name, and email with spaces between each value.
  echo example: hs Han Solo hanshotfirst@deathstar.com
  read user1Initials user1FirstName user1LastName user1Email

  # Get user 2 data
  echo Enter second pair initials, first name, last name, and email with spaces between each value.
  echo example: ls Luke Skywalker luke@thebestjediever.com
  read user2Initials user2FirstName user2LastName user2Email

  echo Creating git pairs file...

  # Build pairs file
  cd
  touch .pairs
  echo 'pairs:' >> .pairs
  echo "  $user1Initials: $user1FirstName $user1LastName" >> .pairs
  echo "  $user2Initials: $user2FirstName $user2LastName" >> .pairs
  echo 'email:' >> .pairs
  echo "  $user1Initials: $user1Email" >> .pairs
  echo "  $user2Initials: $user2Email" >> .pairs

  echo Process complete! Git pairs file created!
fi

# Prompt and build new JavaScript project
echo Do you want to create a new JavaScript project? Enter y/n
read input

if [ $input == "yes" ] || [ $input == "y" ] || [ $input == "Y" ]
then
  # Set up project directory
  echo Please enter the name of the project you want to create:
  read directoryName

  echo Please enter both pair initials, or hit enter to skip:
  echo example: gt lg
  read user1Initials user2Initials

  echo Creating directory $directoryName and building JavaScript project...

  # Build directories and copy assets
  projectName=$directoryName

  cd
  cd Desktop
  mkdir $projectName
  cd $projectName

  # Copy assets
  cp -R $baseDirectory/assets/src ~/Desktop/$projectName
  cp $baseDirectory/assets/.eslintrc ~/Desktop/$projectName
  cp $baseDirectory/assets/.gitignore ~/Desktop/$projectName
  cp $baseDirectory/assets/karma.conf.js ~/Desktop/$projectName
  cp $baseDirectory/assets/package.json ~/Desktop/$projectName
  cp $baseDirectory/assets/README.md ~/Desktop/$projectName
  cp $baseDirectory/assets/webpack.config.js ~/Desktop/$projectName

  # Initialize git
  git init
  sleep 2
  git pair $user1Initials $user2Initials

  # Run npm install
  echo Installing dependencies. This may take a few seconds...
  npm install
  sleep 20

  # Run jasmine init
  ./node_modules/.bin/jasmine init

  # Run npm run start
  echo Running build and starting dev server...
  npm run start
  sleep 5

  # Navigate to and open project in finder
  cd ../
  open $projectName
  echo Process complete! Your JavaScript project has been created!
else
  echo Goodbye!
fi