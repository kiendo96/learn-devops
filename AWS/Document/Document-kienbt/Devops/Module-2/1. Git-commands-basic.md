## Create a Local Reposiory

```
git init /path/to/directory
```
> Initializes a git repository, either by creating a new directory or adding the git repository files to an existing directory 

```
git init --bare /path/to/directory
```
> Initializes a bare git repository, for lager projects , contain no working area

## Using git config

```
git config 
```
> command used to configure various elements of your git environment

```
git config –list 
```
> view your configuration information for your git environment

```
man git-config 
```
> local documentation for what you can configure for your git environment

## Adding Files to A Project

```
git add 
```
> command used to add files to a git project, adds them to the index file so that they can be tracked in the staging area

```
git status 
```
> can be used to see what are in the staging area (not committed yet)

```
git rm 
```
> removes a file from a project

## Using git status

```
git status 
```
> view the state of your staged and upstaged files 

```
git status -s 
```
> view the output in shortened format

```
git status -v 
```
> get more verbose output , including what was changed in a file

```
man git-status 
```
> local documentation for the git status command

## Committing to Git

```
git commit 
```
> open text editor to prepare for a commit of files in the staging area

```
git commit –m “Commit Message” 
```
> bypasses the editor and perform a commit with the specified message

```
git commit –a –m “message”
```
> commit a modified file in the staging area

```
man git-commit 
```
> local documentation for the git commit command

## Ignore Certain File Type

```
.git/info/exclude 
```
> original file that contains the patterns that git will not track

```
.gitignore 
```
> ignore file local to a git repository commonly used to exclude files based on patterns

```
git check-ingore <pattern>
```
> used to debug git ignore to see what is and is not being excluded from git 

```
man gitignore 
```
> local documentation for the gitignore command

