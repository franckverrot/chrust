#
# chrust script to collect environment information for bug reports.
#

[[ -z "$PS1" ]] && exec "$SHELL" -i -l "$0"

function print_section()
{
	echo
	echo "## $1"
	echo
}

function indent()
{
	echo "$1" | sed 's/^/    /'
}

function print_variable()
{
	if [[ -n "$2" ]]; then echo "    $1=$2"
	else                   echo "    $1=$(eval "echo \$$1")"
	fi
}

function print_version()
{
	local full_path="$(command -v "$1")"

	if [[ -n "$full_path" ]]; then
		local version="$(("$1" --version || "$1" -V) 2>/dev/null)"

		indent "$(echo "$version" | head -n 1) [$full_path]"
	fi
}


print_section "System"

indent "$(uname -a)"
print_version "bash"
print_version "tmux"
print_version "zsh"
print_version "rustc"
print_version "bundle"

print_section "Environment"

print_variable "CHRUST_VERSION"
print_variable "SHELL"
print_variable "PATH"
print_variable "HOME"

print_variable "RUSTS" "(${RUSTS[@]})"
print_variable "RUST_ROOT"
print_variable "RUST_VERSION"
print_variable "RUST_AUTO_VERSION"
print_variable "RUSTPATH"
print_variable "RUSTSHELL"

if [[ -n "$ZSH_VERSION" ]]; then
	print_section "Hooks"
	print_variable "preexec_functions" "(${preexec_functions[@]})"
	print_variable "precmd_functions" "(${precmd_functions[@]})"
elif [[ -n "$BASH_VERSION" ]]; then
	print_section "Hooks"
	indent "$(trap -p)"
fi

if [[ -f .rust-version ]]; then
	print_section ".rust-version"
	echo "    $(< .rust-version)"
fi

print_section "Aliases"

indent "$(alias)"
