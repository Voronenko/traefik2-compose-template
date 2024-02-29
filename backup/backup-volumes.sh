#!/bin/bash
echo "Backing up volumes"
echo "------------------"

export backup_path=${BACKUP_PATH:-"$PWD/data/"}

ignore_list=("*devops-gitlab-runner-compose*" "volume2")

echo $backuo_path

# Create the backup directory
mkdir -p "$backup_path"/volumes


for volume in $(docker volume ls -q | xargs docker volume inspect -f '"{{.Name}}""{{.Mountpoint}}"')
do
	# Get the volume name and path
	volume_name=$(echo "$volume" | cut -f2 -d\")
	volume_path=$(echo "$volume" | cut -f4 -d\")

        skip_volume=false
        for pattern in "${ignore_list[@]}"
        do
            if [[ $volume_name == $pattern ]]; then
                skip_volume=true
                break
            fi
        done

        if $skip_volume; then
           echo "Skipping backup for volume: $volume_name (matched pattern: $pattern)"
           continue
        fi


	# Backup the volume
	echo -n "$volume_name - "
	docker run --rm -v "$volume_path":/volume -v "$backup_path"/volumes:/backup busybox tar -cvzf /backup/"$volume_name".tar.gz /volume >/dev/null 2>&1
	echo "OK"
done

echo ""
