# Contributing

## Code Style

* Tab indent code.
* Keep code within 80 columns.
* Global variables must be UPPERCASE. Temporary variables should be lowercase.
* Use the `function` keyword for functions.
* Quote all String variables.
* Use `(( ))` for arithmetic expressions and `[[ ]]` otherwise.
* Use `$(...)` instead of back-ticks.
* Use `${path##*/}` instead of `$(basename $path)`.
* Use `${path%/*}` instead of `$(dirname $path)`.
* Prefer single-line expressions where appropriate:

        [[ -n "$foo" ]] && other command

        if   [[ "$foo" == "bar" ]]; then command
        elif [[ "$foo" == "baz" ]]; then other_command
        fi

        case "$foo" in
        	bar) command ;;
        	baz) other_command ;;
        esac

## Pull Request Guidelines

* Additional features should go in separate files within `share/chrust/`.
* All new code must have [shunit2] unit-tests.
* If a feature is out of scope or does more than switches Rusts,
  it should become its own project. Simply copy the generic [Makefile]
  for shell script projects.

[Makefile]: https://gist.github.com/3224049
[shunit2]: http://code.google.com/p/shunit2/
