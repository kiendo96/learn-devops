. ./env-dev-team1.sh

docker-compose -f docker-compose.yml -f docker-compose.dev.team1.yml -p $APP_NAME down
# Clean code mount and create new empty mount point
docker volume rm internship_team1_team1-admin-api-code
sudo rm -rf "$APP_VOLUME_CODE_MOUNT_PATH"
sudo mkdir -p "$APP_VOLUME_CODE_MOUNT_PATH"
sudo mkdir -p "$APP_VOLUME_DATABASE_MOUNT_PATH"
sudo mkdir -p "$APP_VOLUME_STORAGE_MOUNT_PATH"
sudo mkdir -p "$APP_VOLUME_LOGS_MOUNT_PATH"
sudo mkdir -p "$APP_VOLUME_UPLOADS_PATH"
sudo mkdir -p "$APP_VOLUME_PUBLIC_STORAGE_PATH"

docker-compose -f docker-compose.yml -f docker-compose.dev.team1.yml -p $APP_NAME up --build -d
docker-compose -p $APP_NAME exec -T team1-admin-api sh -c "php artisan migrate"
docker-compose -p $APP_NAME exec -T team1-admin-api sh -c "php artisan passport:install --force"
docker-compose -p $APP_NAME exec -T team1-admin-api sh -c "nohup php artisan queue:work --daemon &"
docker-compose -p $APP_NAME exec -T team1-admin-api sh -c "exit"
