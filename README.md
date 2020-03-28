<div align="center">
  <h1>
    dotfiles
  </h1>
</div>

This is a rather simple dotfiles system consisting of a small Perl script which uses GNU stow to recursively symlink the contents of selected directories into the target directory (normally the user's `$HOME` directory). The main components of this system are "root" directories, the `config.df` file, and the `dfstow.pl` script.

This system also includes a bootstrapping script which aids in setting up a bare machine.

### Prerequisites
- UNIX-like system
- Perl v5.6.0+
  - Stow: https://metacpan.org/pod/Stow

### Stow options
**-t**, **--target** : Define target directory. Absolute path. Defaults to `$HOME`.<br/>
**-d**, **--delete** : Remove symlinks from target directory.<br/>
**-r**, **--restow** : Remove and re-link symlinks in target directory. Helpful for pruning stale stow artifacts.<br/>

### Usage
#### Bootstrap:
```console
$ ./dfbootstrap.sh

$ ./_bootstrap.pl -p PLATFORM
```

#### Stow:
```console
$ ./dfstow.pl -p PLATFORM

$ ./dfstow.pl -p PLATFORM -t /absolute/path/to/target/dir

$ ./dfstow.pl -p PLATFORM -d

$ ./dfstow.pl -p PLATFORM -r
```

### "Root" directories
My dotfiles system utilizes the Stow module in Perl, which exposes GNU stow's backend for programmatic use. If you're familiar with GNU stow, you'll understand how this system works.

Dotfiles should be stored in "root" directories which contain the entire file structure that should be symlinked into the target directory. These "root" directories will not themselves be symlinked, only the files and directories inside them. List the "root" directories which should be built from in `config.df`.

### config.df
Fill `config.df` with a newline-delimited list of directories containing the files/directories which should be symlinked into the target directory. These entries should simply be the names of the directories and should not begin with an initial `/`. List should be prepended and appended with `[PATHS BEGIN]` and `[PATHS END]`, respectively. Beginning a line with a hash symbol (`#`) will comment that line and exclude it from processing by `dfstow.pl`.

Example `config.df` paths declaration for `MY_CUSTOM_PLATFORM_NAME`:
```
[MY_CUSTOM_PLATFORM_NAME: PATHS BEGIN]
dir1
dir2
dir3
# this line is commented and will be ignored
  # this line is also commented
[MY_CUSTOM_PLATFORM_NAME: PATHS END]
```

All files and directories in `dir1`, `dir2`, and `dir3` will be symlinked into the target directory. If `dir1` contains a file `file1.txt`, it will be linked as `$HOME/file1.txt`. Likewise, if `dir1` contains a directory `nested1`, it will be linked as `$HOME/nested1/`. This works identically to GNU stow.

_Note:_
```
dir4    # this is not a valid comment and will cause an error
```

`config.df` is also used for the bootstrap process. A bootstrap workflow with processes for MacOS and Linux might look something like this:
```
[MACOS: BOOTSTRAP BEGIN]
  BOOTSTRAP_PREFIX: brew install
    package1
    package2
    package3

  BOOTSTRAP_PREFIX: brew upgrade
    package4
    package5
[MACOS: BOOTSTRAP END]

[LINUX: BOOTSTRAP BEGIN]
  BOOTSTRAP_PREFIX: sudo apt install
    package1
    package2

  BOOTSTRAP_PREFIX: sudo apt-get install
    package 3
[LINUX: BOOTSTRAP END]
```
