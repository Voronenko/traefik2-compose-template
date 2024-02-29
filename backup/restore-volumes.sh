#!/bin/bash

# Path: restore-volumes.sh
# Restore all volumes from the backup
# Inside the backup directory, there is a volumes directory, which contains all the volumes.

# destructive operation, requires sourcing the files

echo "Volumes restorations"
echo "------------------"

# Check if backup path exists
if [ ! -d "$backup_path" ]
then
  echo "Error: backup path does not exist"
  exit 1
fi

volumes=$(ls "$backup_path/volumes")

for volume in $volumes
do
	# Get volume name from the file name
	volume=$(echo "$volume" | cut -f1 -d.)

	echo -n "$volume - "
	docker run --rm -v "$volume":/volume -v "$backup_path"/volumes:/backup busybox sh -c "cd /volume && tar -xvf /backup/$volume.tar.gz --strip 1" >/dev/null 2>&1
	echo "OK"
done
