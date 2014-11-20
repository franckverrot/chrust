CHRUST_VERSION="0.0.1"
RUSTS=()

for dir in "$PREFIX/opt/rusts" "$HOME/.rusts"; do
	[[ -d "$dir" && -n "$(ls -A "$dir")" ]] && RUSTS+=("$dir"/*)
done
unset dir

function chrust_reset()
{
	[[ -z "$RUST_ROOT" ]] && return

	PATH=":$PATH:"; PATH="${PATH//:$RUST_ROOT\/bin:/:}"
	PATH="${PATH#:}"; PATH="${PATH%:}"

	unset RUST_ROOT RUST_VERSION
	hash -r
}

function chrust_use()
{
	if [[ ! -x "$1/bin/rustc" ]]; then
		echo "chrust: $1/bin/rustc not executable" >&2
		return 1
	fi

	[[ -n "$RUST_ROOT" ]] && chrust_reset

	export RUST_ROOT="$1"
	export PATH="$RUST_ROOT/bin:$PATH"
	export DYLD_LIBRARY_PATH="$RUST_ROOT/lib:$DYLD_LIBRARY_PATH"
}

function chrust()
{
	case "$1" in
		-h|--help)
			echo "usage: chrust [VERSION|none]"
			;;
		-V|--version)
			echo "chrust: $CHRUST_VERSION"
			;;
		"")
			local dir star
			for dir in "${RUSTS[@]}"; do
				dir="${dir%%/}"
				if [[ "$dir" == "$RUST_ROOT" ]]; then star="*"
				else                                  star=" "
				fi

				echo " $star ${dir##*/}"
			done
			;;
		none) chrust_reset ;;
		*)
			local dir match
			for dir in "${RUSTS[@]}"; do
				dir="${dir%%/}"
				case "${dir##*/}" in
					"$1")	match="$dir" && break ;;
					*"$1"*)	match="$dir" ;;
				esac
			done

			if [[ -z "$match" ]]; then
				echo "chrust: unknown Rust: $1" >&2
				return 1
			fi

			shift
			chrust_use "$match" "$*"
			;;
	esac
}
