#!/bin/bash

VERSIONS=( "latest" "11" )

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
		printf 'You picked mariadb "%s"\n' "${VERSIONS[$i]}"
		mkdir -p ./storage/mariadb/"${VERSIONS[$i]}"
		docker compose -f ./compose/mariadb/"${VERSIONS[$i]}".docker-compose.yml up
	fi
done
