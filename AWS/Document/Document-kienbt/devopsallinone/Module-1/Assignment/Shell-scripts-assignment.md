## SHELL SCRIPT ASSIGNMENT 01
<br/><br/>
----------------------- Let's have some fund -----------------------
<br/><br/>
### AS 01

Write a shellscript require input arguments from user [This case argument was directory]
    

-   First check if argument that user input is Directory or not. If correct create a sub-directory with name `loop`
-   Inside `loop` create 3 sub-directory with name following these [img ; txt ; pdf]
-   Inside each directory that you created above you should create separate files with extension's name following these

    - img [ create 20 files from 1 - 20]
    - txt [ create 10 files from 1 - 10]
    - pdf [ create 20 files from 20 - 40]
    
    - with filename `e.g: file[number].(img,txt,pdf)`
- Each type of file should be store in corresponding name of directory

- After files were created you should create a function to check every file if there is any problem.
- If everything is going well. Next you must check permission of all files.
   
    - With files [img] should be readable permission.
    - With files [txt] should be remove write permission
    - With files [pdf] should be full permisson.

- After finish permission part. Inside `img` directory excute command `ls -a` and redirect the output to first 5 `txt` files.
- Inside `txt` directory execute commnad `ls -lhr` and redirect output to all of `pdf` files.
- With `img` directory must contain ouput of command `ls -la` that was execute from 2 directory [txt] and [pdf]

- Next you should backup every directories to path `/root/backup` [Notice: Backup files should store inside directory has name with date that file were backup]
- If backup part success. Files in directory [img] should be deleted. [txt] [pdf] should be keep.
- Finally, inside `backup` directory create a function to count total files in every directory. And output the number to screen following type of files.

`Advance` Let write this solutin with  `7` functions

-   Function create folder
-   Function check total file
-   Function add permission read
-   Function add permission write
-   Function redirect output
-   Function backup
-   Function countfile

<br/><br/>
----------------------------------------- What do you think after finish AS01 ? Wanna more ? ----------------------------------------
<br/><br/>

### AS 02

In your company has rule that every user file doesn't allow to have any Tab and Space in front and end of every lines in file.
So your boss require you write a program to provide a solution to check file if it have any issuse with Tab and Space.
After find out if file have any issue. You program should have feature to fix these issue.

`Hint`: You should write an shell script : using these methods 

-   Begin you should print a message how to use that script to use.
    ```
    function usage() {
    echo "USAGE: $0 [file-path] [-f | --fix] [-h | --help]"
    exit 1
    }
    ```
- Next you should combine `While` and `case loop` to do this task.
- Regular expression should be use to find out the Tab and Space
- Sed command should be use to search and replace.

<br/><br/>
----------------------------------------- Wanna give up huh ? ---------------- No No No ----------- Let's finish it-----------------
<br/><br/>

### AS 03

In your system has alot of big file that you need to know and clarify. You have an idea that you should have a program to check these file.
You choose shell script to achive this purpose. In you script you think you should combine some command and knowledge that you have learned from previous lession.

`Hint`

-   You should do the same with `As02` output how to use this script to screen.

    ```
    function usage()
        {
	echo "USAGE: $0 [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help]"
	echo "Example:"
	echo "$0 -l /etc/ -e txt -s"
	echo "$0 -e img --stats"
	exit 1
    }
    ```
    This should be write in function.

    Next a combination `While loop` and `case loop` should be considered for this case.
    ```
    while [ $# -gt 0 ]
    do
    case $1 in
    -l|--location )
        LOCATION="$2"
        if ! [ -d "$LOCATION" ]; then
        usage
        fi
        LOC_SET=1
        shift
        shift
        ;;
    -e|--extension )
        EXT="$2"
        shift
        shift
        ;;
    -s|--stats )
        STATS=1
        shift
        ;;
    -h|--help )
        shift
        usage
        ;;
        * )
        usage
        ;;
    esac
    done

    ```
--------------------------------------------- You are the champion -----------------------------------------------------