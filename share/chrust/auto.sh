unset RUST_AUTO_VERSION

function chrust_auto() {
	local dir="$PWD/" version

	until [[ -z "$dir" ]]; do
		dir="${dir%/*}"

		if { read -r version <"$dir/.rust-version"; } 2>/dev/null || [[ -n "$version" ]]; then
			if [[ "$version" == "$RUST_AUTO_VERSION" ]]; then return
			else
				RUST_AUTO_VERSION="$version"
				chrust "$version"
				return $?
			fi
		fi
	done

	if [[ -n "$RUST_AUTO_VERSION" ]]; then
		chrust_reset
		unset RUST_AUTO_VERSION
	fi
}

if [[ -n "$ZSH_VERSION" ]]; then
	if [[ ! "$preexec_functions" == *chrust_auto* ]]; then
		preexec_functions+=("chrust_auto")
	fi
elif [[ -n "$BASH_VERSION" ]]; then
	trap '[[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]] && chrust_auto' DEBUG
fi
