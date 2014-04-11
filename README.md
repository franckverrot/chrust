# chrust

Changes the current Rust.

## Features

* Updates `$PATH`.
* Additionally sets `$RUST_ROOT` and `$RUST_VERSION`.
* Calls `hash -r` to clear the command-lookup hash-table.
* Defaults to the system Rust.
* Optionally supports auto-switching and the `.rust-version` file.
* Supports [bash] and [zsh].

## Anti-Features

* Does not hook `cd`.
* Does not install executable shims.
* Does not require Rusts be installed into your home directory.
* Does not automatically switch Rusts by default.

## Install

    git clone https://github.com/franckverrot/chrust.git
    cd chrust
    sudo make install

### Rusts

#### Manually

By downloading the official source code and following the instructions.

#### rust-install

You can also use [ruust-install] to install additional Rusts:

Installing to `/opt/rusts` or `~/.rusts`:

    rust-install 0.8
    rust-install 0.9

## Configuration

Add the following to the `~/.bashrc` or `~/.zshrc` file:

``` bash
source /usr/local/share/chrust/chrust.sh
```

### System Wide

If you wish to enable chrust system-wide, add the following to
`/etc/profile.d/chrust.sh`:

``` bash
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/local/share/chrust/chrust.sh
  ...
fi
```

This will prevent chrust from accidentally being loaded by `/bin/sh`, which
is not always the same as `/bin/bash`.

### Rusts

When chrust is first loaded by the shell, it will auto-detect Rusts installed
in `/opt/rusts/` and `~/.rusts/`. After installing new Rusts, you _must_
restart the shell before chrust can recognize them.

For Rusts installed in non-standard locations, simply append their paths to
the `RUSTS` variable:

``` bash
source /usr/local/share/chrust/chrust.sh

RUSTS+=(
  /opt/my_rust
  "$HOME/src/my_other_rust"
)
```

### Auto-Switching

If you want chrust to auto-switch the current version of Rust when you `cd`
between your different projects, simply load `auto.sh` in `~/.bashrc` or
`~/.zshrc`:

``` bash
source /usr/local/share/chrust/chrust.sh
source /usr/local/share/chrust/auto.sh
```

chrust will check the current and parent directories for a [.rust-version] file.

### Default Rust

If you wish to set a default Rust, simply call `chrust` in `~/.bash_profile` or
`~/.zprofile`:

    chrust 0.8

If you have enabled auto-switching, simply create a `.rust-version` file:

    echo "0.8" > ~/.rust-version


## Examples

List available Rusts:

    $ chrust
       0.8
       0.9

Rust doesn't change your system Rust:

    $ which rust
    /usr/local/bin/rustc

    $ rust --version
    rustc 0.9
    host: x86_64-apple-darwin

Select a Rust:

    $ chrust 0.9
    $ chrust
       0.8
     * 0.9
    $ which rust
    /Users/cesario/.rusts/0.9/bin/rustc
    $ rust --version
    rustc 0.9
    host: x86_64-apple-darwin

Remove chrust from your $PATH (and use system Rust if present)

    # If no Rust was present
    $ chrust none
    $ rustc --version
    zsh: command not found: rustc

    # If a version of Rust was present
    $ chrust none
    $ rustc --version
    rustc 0.9
    host: x86_64-apple-darwin

Run a command under a Rust version with `chrust-exec`:

    $ chrust-exec 0.8 -- rusti

Switch to an arbitrary Rust on the fly:

    $ chrust_use /path/to/rust

## Uninstall

After removing the chrust configuration:

    $ sudo make uninstall

## Alternatives

There's none.

## Endorsements

> Finally an easy tool to manage my Rusts !

-- Mom

## Credits

* [@postmodern] and his incredible work on [chruby]. chrust is just a bad copy of it :-)

[@postmodern]: https://github.com/postmodern
[chruby]: https://github.com/postmodern/chruby

## Copyright

Copyright (c) 2014 Franck Verrot. MIT LICENSE. See LICENSE.txt for details.
