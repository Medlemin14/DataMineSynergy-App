#!/bin/sh

# Attendre que la base de données soit prête
echo "Waiting for database..."
max_retries=30
counter=0

while ! nc -z db 3306; do
    counter=$((counter + 1))
    if [ $counter -gt $max_retries ]; then
        echo "Error: Failed to connect to database after $max_retries attempts"
        exit 1
    fi
    echo "Database is unavailable - sleeping (attempt $counter/$max_retries)"
    sleep 2
done

# Attendre que MySQL soit vraiment prêt à accepter les connexions
echo "Waiting for database to be ready..."
while ! mysql -h db -u datamine_user -pdatamine_password -e "SELECT 1" >/dev/null 2>&1; do
    counter=$((counter + 1))
    if [ $counter -gt $max_retries ]; then
        echo "Error: Database is not ready after $max_retries attempts"
        exit 1
    fi
    echo "Database is not ready - sleeping (attempt $counter/$max_retries)"
    sleep 2
done

echo "Database is ready!"

# Appliquer les migrations
echo "Applying database migrations..."
python manage.py makemigrations
python manage.py migrate

# Démarrer le serveur
echo "Starting server..."
python manage.py runserver 0.0.0.0:8000 