#!/bin/bash

CHOICES=( "datalust-seq" )

select choice in "${CHOICES[@]}"; do
	if [[ -z "$choice" ]]; then
		printf '"%s" is not a valid choice\n' "$REPLY" >&2
	else
		selected_choice="$(( REPLY - 1 ))"
		break;
	fi
done

for (( i = 0; i < ${#CHOICES[@]}; ++i )); do
	if [[ i -eq selected_choice ]]; then
		printf 'You picked "%s"\n' "${CHOICES[$i]}"
		mkdir -p ./storage/dev/"${CHOICES[$i]}"
		docker compose -f ./compose/dev/"${CHOICES[$i]}".docker-compose.yml up
	fi
done
