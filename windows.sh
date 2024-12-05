#!/bin/bash

VERSIONS=( "10" )

select version in "${VERSIONS[@]}"; do
	if [[ -z "$version" ]]; then
		printf '"%s" is not a valid choice\n' "$REPLY" >&2
	else
		selected_version="$(( REPLY - 1 ))"
		break;
	fi
done

for (( i = 0; i < ${#VERSIONS[@]}; ++i )); do
	if [[ i -eq selected_version ]]; then
		printf 'You picked windows "%s"\n' "${VERSIONS[$i]}"
		mkdir -p ./storage/windows/"${VERSIONS[$i]}"
		docker compose -f ./compose/windows/"${VERSIONS[$i]}".docker-compose.yml up
	fi
done
