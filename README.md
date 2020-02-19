<div align="center">
  <h1>
    dotfiles
  </h1>
</div>

This is a rather simple dotfiles system consisting of a small Perl script which recursively symlinks the contents of selected directories into the user's `$HOME` directory. The main components of this system are "root" directories, the `PATHS.txt` file, and the main script.

### Prerequisites
- UNIX-like system
- Perl v5.6.0+
- `$HOME` must be defined in the shell environment and should point to the directory where dotfiles should be stored

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

All files and directories in `dir1`, `dir2`, and `dir3` will be symlinked into `$HOME`. If `dir1` contains a file `file1.txt`, it will be linked as `$HOME/file1.txt`. Likewise, if `dir1` contains a directory `nested1`, it will be linked as `$HOME/nested1/`. This works identically to GNU stow.

### PATHS_CP.txt
It may be preferable to copy some dotfiles rather than symlinking them. Directories which are added to `PATHS_CP.txt` will be copied into `$HOME` rather than symlinked.

### The main script
To make symlinks as configured in the dotfiles directories and `PATHS.txt` file, run:

```shell
make dotfiles
```

This will recursively link all files and directories in each directory listed in `PATHS.txt`, starting at the first level of nesting. If a file-to-be-linked already exists in `$HOME`, that file will be moved to the archive directory before the dotfile is linked in its place. The archive directory will contain a directory named by a relevant timestamp and will contain any and all files which were moved there during that runtime.

The behavior for `PATHS_CP.txt` is the same, except that files are copied rather than symlinked.

### The archive directory
To avoid losing files, every file which exists before symlinking an identically-named file will be moved to the archive directory, found at `$HOME/.dotfiles_archive`. The archive directory contains a directory for each time the dotfiles were made, named by the timestamp of each respective runtime. To view files archived at a given runtime, check inside the relevant directory. This is useful in case running the dotfiles script would overwrite a file that needs to be preserved for some reason.

To remove the archive folder, run:
```shell
make clean_archive
```

_NOTE: the archive directory will be re-created next time the dotfiles are made._

