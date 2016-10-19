## Start work with The Welkin Suite

### 1. Create new solution
> Create a new The Welkin Suite solution. Name of solution not matter, but **The project should be named the same for all developers**.
> Connect the project to your own developer Salesforce organization.

### 2. Clone repository
> Close The Welkin Suite before start this step
> You should enter to **project folder**, not to solution

	cd C:\..\SolutionName\PROJECTNAME\
	git init

	git config core.autocrlf input
	git remote add origin git@git.domain.ua:project.git

	git fetch
	git checkout origin/master -ft
	git clean -fd

	powershell ./Load-ItemGroups-To-Project.ps1

### 3. Setup Your Identity

	git config user.name "Petro Petrov"
	git config user.email petro.petrov@softheme.com


##### All are ready to start your work!

----------

## Git workflow


### Start work

1. Receive task in Redmine  
2. Go to your project dir

		cd C:\...\SolutionName\PROJECTNAME\

3. Switch to master branch

		git checkout master

4. Pull from origin repository

		git pull origin

5. Add changes **to** your project file

		powershell ./Load-ItemGroups-To-Project.ps1

6. Verify your project: Open TWS and try build changes (if there are any)

7. Create new brach for your task: (ID - Task number)

		git checkout -b feature-ID

8. *Enjoy work*

### End work

1. See your changes. All are OK?

		git status
		git diff HEAD

2. Load your changes *from* project file

		powershell ./Load-ItemGroups-From-Project.ps1

3. Add changes to git

		git add .

4. Commit your changes

		git commit -m "[#ID] Task-Subject. Additional text"

5. Checkout to master

		git checkout master

6. merge your branch

		git pull origin master
		git merge feature-ID

7. Add changes *to* your project file

		powershell ./Load-ItemGroups-To-Project.ps1

8. Verify you didn't break anything: Open TWS and try build changes

9. Push to remote repository

		git push origin master
