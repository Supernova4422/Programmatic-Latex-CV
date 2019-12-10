# Editing
The main file to edit is in ```main/body```, this is considered the starting point of
generating a document.

To set the name compiled PDFS are named to, a user edits the file
```Compile_ALL.sh``` and edits the ```NAME``` variable.

## Fonts
The default font for this project is opensans. To use a different font, edit
the file ```main/formatting.tex```
## Adding a new audience
If new audiences are added, the file ```Compile_All.sh``` is edited, and
editing the array  ```audiences``` will add a new audience.

If you are not using Compile all, the audience needs to be added to the file
```main/audiences.tex```
# Compiling
## Requirements
If you are using docker, you will need docker.

If you are not using docker, you will need to have installed xelatex. If you
would like to export to plaintext/markup formats, you will need to install
pandoc.

## Linux / MAC
The compilation is prepared for a unix machine, and can optionally be run using
a docker container. To compile without docker, run ```Compile_All.sh``` and
to compile with docker, use ```Compile_With_Docker.sh```

## Windows
### With docker
I strongly encourage using a docker container in order to get the most usage
from this repository.

### WIthout docker
compilation can be executed by using  ```xelatex one.tex``` in the directory
`main` however this will only create the PDFS.