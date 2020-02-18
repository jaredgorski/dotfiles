# dotfiles

This is a rather simple dotfiles system consisting of a small Perl script which recursively symlinks the contents of selected directories into the user's `$HOME` directory. The main components of this system are "root" directories, the `PATHS_LN.txt` and `PATHS_CP.txt` files, and the main script.

### "Root" directories
Dotfiles should be stored in "root" directories which contain the entire file structure that should be symlinked into `$HOME`. These "root" directories will not themselves be symlinked, only the files and directories inside them. List the "root" directories which should be built from in `PATHS_LN.txt`/`PATHS_CP.txt`.

### PATHS_LN.txt
Fill `PATHS_LN.txt` with a newline-delimited list of directories containing the files/directories which should be symlinked into `$HOME`. These entries should simply be the names of the directories and should not begin with an initial `/`.

E.g.:
```
dir1
dir2
dir3
```

All files and directories in `dir1`, `dir2`, and `dir3` will be symlinked into `$HOME`. If `dir1` contains a file `file1.txt`, it will be linked as `$HOME/file1.txt`. Likewise, if `dir1` contains a directory `nested1`, it will be linked as `$HOME/nested1/`.

### PATHS_CP.txt
Some dotfiles should be copied rather than symlinked, such as shell profile configurations. Directories which are added to `PATHS_CP.txt` will be copied into `$HOME` rather than symlinked.

_NOTE: "root" directories which need to be copied rather than symlinked should **only** be added to `PATHS_CP.txt`._

### The main script
To make symlinks and copy files as configured in the dotfiles directories and `PATHS_LN.txt`/`PATHS_CP.txt`, run:

```shell
make dotfiles
```

This will recursively link all files and directories in each directory listed in `PATHS_LN.txt`, starting at the first level of nesting. If a file-to-be-linked already exists in `$HOME`, that file will be moved to the archive directory before the dotfile is linked in its place. The archive directory will contain a directory named by a relevant timestamp and will contain any and all files which were moved there during that runtime.

The behavior for `PATHS_CP.txt` is the same, except that files are copied rather than symlinked.

### The archive directory
To avoid losing files, every file which exists before symlinking or copying an identically-named file will be moved to the archive directory, found at `$HOME/.dotfiles_archive`. The archive directory contains a directory for each time the dotfiles were made, named by the timestamp of each respective runtime. To view files archived at a given runtime, check inside the relevant directory. This is useful in case running the dotfiles script would overwrite a file that needs to be preserved for some reason.

To remove the archive folder, run:
```shell
make clean_archive
```

_NOTE: the archive directory will be re-created next time the dotfiles are made._

