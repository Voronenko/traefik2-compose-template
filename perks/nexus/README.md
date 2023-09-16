# Enabling scripting
docker exec -it nexus bash
echo "nexus.scripts.allowCreation=true" >> /nexus-data/etc/nexus.properties
exit
docker-compose restart

## configuring mirror

As user root, make or edit the following file: /etc/docker/daemon.json

{
        "insecure-registries": ["nexus.fiks.im:5000"],
        "registry-mirrors": ["https://nexus.fiks.im:5000"]
}
