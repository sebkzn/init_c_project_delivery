# init_c_project_delivery
Simple bash script that creates usual folders and files for an Epitech C project.

<br />

Features:
----
- make __include__, __lib__, __src__, __tests__ and __bonus__ directories
- copy your __lib/my__ folder and paste it to the repository, then copy and paste my.h file in the __include__ directory
- make a minimal __main.c__ file with a correct header
- make a __Makefile__ with a correct header
- make a minimal __.gitignore__ file
- push to origin/master the initialized repository


## Usage:
`bash init_repo.sh [-l|--lib] <path_to_libmy> [-b|--binary] <binary_name> <repository_url>`


### Example:
`bash init_repo.sh --lib ~/epitech/lib/my -b my_project git@github.com:ORGANIZATION/B-EPITECH-PROJECT-1-1-firstname.lastname.git`
