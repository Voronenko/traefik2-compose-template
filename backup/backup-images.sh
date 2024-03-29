#!/bin/bash

echo "Backing up container images"
echo "---------------------------"

export backup_path=${BACKUP_PATH:-"$PWD/data/"}
ignore_list=("*devops-gitlab-runner-compose*" "volume2")


for i in $(docker ps -q | xargs docker inspect --format='{{.Name}}' | cut -f2 -d/)
        do container_name=$i
        echo -n "$container_name - "
        container_image=$(docker inspect --format='{{.Config.Image}}' "$container_name")
        mkdir -p "$backup_path"/"$container_name"
        save_file="$backup_path"/"$container_name"/"$container_name-image.tar"
        docker save -o "$save_file" "$container_image"
        echo "OK"
done

echo "DONE"
