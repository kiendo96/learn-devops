export DOCKER_NETWORK='xxx'
export REGISTRY_ADMIN_API='xxx'
export REGISTRY_FRONTEND='xxx'

export ADMIN_API_HOST='xxx'
export FRONTEND_HOST='xxx'
export VIRTUAL_NETWORK='nginx-proxy'
export VIRTUAL_PORT='80'
export LETSENCRYPT_ADMIN_API_HOST="$ADMIN_API_HOST"
export LETSENCRYPT_FRONTEND_HOST="$FRONTEND_HOST"
export LETSENCRYPT_EMAIL='devops@gkcsoftware.com'

export APP_NAME='internship_team1'
export APP_ENV='dev'
export APP_KEY='base64:3/p6L7rrKi2eVFr3pyMAe0jO2Krv1R9Q9oOsi0463fE:'
export APP_DEBUG='true'
export APP_URL="https://${ADMIN_API_HOST}"
export REDIRECT_HTTPS='true'

export LOG_CHANNEL='stack'
export DB_CONNECTION='mysql'

export APP_VOLUME_PUBLIC_STORAGE_PATH="/home/cicduser/data/${APP_NAME}/public_storage"
export APP_VOLUME_UPLOADS_PATH="/home/cicduser/data/${APP_NAME}/uploads"
export APP_VOLUME_CODE_MOUNT_PATH="/home/cicduser/data/${APP_NAME}/code"
export APP_VOLUME_DATABASE_MOUNT_PATH="/home/cicduser/data/${APP_NAME}/database"
export APP_VOLUME_STORAGE_MOUNT_PATH="/home/cicduser/data/${APP_NAME}/storage"
export APP_VOLUME_LOGS_MOUNT_PATH="/home/cicduser/data/${APP_NAME}/logs"

export DB_HOST='xxx'
export DB_PORT='3306'
export DB_DATABASE='xxx'
export DB_USERNAME='xxx'
export DB_PASSWORD='xxx'

export BROADCAST_DRIVER='log'
export CACHE_DRIVER='file'
export QUEUE_CONNECTION='database'
export SESSION_DRIVER='file'
export SESSION_LIFETIME='120'

export MAIL_DRIVER='smtp'
export MAIL_HOST='xxx'
export MAIL_PORT='587'
export MAIL_USERNAME='xxx'
export MAIL_PASSWORD='xxx'
export MAIL_ENCRYPTION='tls'
export MAIL_FROM='xxx'
export MAIL_TO='xxx'
export MAIL_FROM_ADDRESS='xxx'
export MAIL_FROM_NAME='internship'

export FE_URL='https://team1.dev.gkcsoftware.com'
export GOOGLE_RECAPTCHA_SECRET=""
