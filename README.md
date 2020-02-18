# dotfiles

This is a rather simple dotfiles system consisting of a small Perl script which recursively symlinks the contents of selected directories into the user's `$HOME` directory. The main components of this system are "root" directories, the `PATHS.txt` file, and the main script.

### "Root" directories
Dotfiles should be stored in "root" directories which contain the entire file structure that should be symlinked into `$HOME`. These "root" directories will not themselves be symlinked, only the files and directories inside them. List the "root" directories which should be built from in `PATHS.txt`.

### PATHS.txt
Fill `PATHS.txt` with a newline-delimited list of directories containing the files/directories which should be symlinked into `$HOME`. These entries should simply be the names of the directories and should not begin with an initial `/`.

E.g.:
```
dir1
dir2
dir3
```

All files and directories in `dir1`, `dir2`, and `dir3` will be symlinked into `$HOME`. If `dir1` contains a file `file1.txt`, it will be linked as `$HOME/file1.txt`. Likewise, if `dir1` contains a directory `nested1`, it will be linked as `$HOME/nested1/`.

### init.pl
To make the symlinks as configured in the dotfiles directories and `PATHS.txt`, run:

```shell
make dotfiles
```

This will recursively link all files and directories in each directory listed in `PATHS.txt`, starting at the first level of nesting (the root directories listed in `PATHS.txt` will not be linked). If a file-to-be-linked already exists in `$HOME`, that file will be moved to the archive directory before the dotfile is linked in its place. The archive directory will contain a directory named by a relevant timestamp and will contain any and all files which were moved there during that runtime.

### Archive
To avoid losing files, every file which exists before symlinking an identically-named file will be moved to the archive directory, found at `$HOME/.dotfiles_archive`. The archive directory contains a directory for each time the dotfiles were made, named by the timestamp of each respective runtime. To view files archived at a given runtime, check inside the relevant directory.

To remove the archive folder, run:
```shell
make clean_archive
```

_NOTE: the archive folder will be re-created next time the dotfiles are made._

