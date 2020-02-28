<div align="center">
  <h1>
    dotfiles
  </h1>
</div>

This is a rather simple dotfiles system consisting of a small Perl script which uses GNU stow to recursively symlink the contents of selected directories into the target directory (normally the user's `$HOME` directory). The main components of this system are "root" directories, the `config.df` file, and the `init.pl` script.

In the future, I plan to include a bootstrapping script which will enable installing all programs necessary to my setup from scratch on a bare UNIX-like machine as a prerequisite to the `init.pl` script.

### Prerequisites
- UNIX-like system
- Perl v5.6.0+
  - Stow: https://metacpan.org/pod/Stow

### Options
**-t**, **--target** : Define target directory. Absolute path. Defaults to `$HOME`.<br/>
**-d**, **--delete** : Remove symlinks from target directory.<br/>
**-r**, **--restow** : Remove and re-link symlinks in target directory. Helpful for pruning stale stow artifacts.<br/>

### Usage
```console
$ perl init.pl

$ perl init.pl -t /absolute/path/to/target/dir

$ perl init.pl -d

$ perl init.pl -r
```

### "Root" directories
My dotfiles system utilizes the Stow module in Perl, which exposes GNU stow's backend for programmatic use. If you're familiar with GNU stow, you'll understand how this system works.

Dotfiles should be stored in "root" directories which contain the entire file structure that should be symlinked into the target directory. These "root" directories will not themselves be symlinked, only the files and directories inside them. List the "root" directories which should be built from in `config.df`.

### config.df
Fill `config.df` with a newline-delimited list of directories containing the files/directories which should be symlinked into the target directory. These entries should simply be the names of the directories and should not begin with an initial `/`. List should be prepended and appended with `[PATHS BEGIN]` and `[PATHS END]`, respectively. Beginning a line with a hash symbol (`#`) will comment that line and exclude it from processing by `init.pl`.

E.g.:
```
[PATHS BEGIN]
dir1
dir2
dir3
# this line is commented and will be ignored
  # this line is also commented
[PATHS END]
```

All files and directories in `dir1`, `dir2`, and `dir3` will be symlinked into the target directory. If `dir1` contains a file `file1.txt`, it will be linked as `$HOME/file1.txt`. Likewise, if `dir1` contains a directory `nested1`, it will be linked as `$HOME/nested1/`. This works identically to GNU stow.

_Note:_
```
dir4    # this is not a valid comment and will cause an error
```

