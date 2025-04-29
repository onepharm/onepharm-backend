#!/bin/bash

# One Pharm Backend Deployment Script
# This script helps automate the deployment process for One Pharm backend

echo "===== One Pharm Backend Deployment Script ====="
echo "This script will help you deploy the backend to Railway"
echo ""

# Check if .env file exists, create if not
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << EOL
SECRET_KEY=$(python -c 'import secrets; print(secrets.token_hex(32))')
DEBUG=False
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/onepharm
ALLOWED_HOSTS=.up.railway.app,localhost,127.0.0.1
EOL
    echo "Created .env file. Please update the MONGODB_URI with your actual MongoDB Atlas connection string."
    echo ""
fi

# Install required packages
echo "Installing dependencies..."
pip install -r requirements.txt
echo "Dependencies installed."
echo ""

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput
echo "Static files collected."
echo ""

# Run migrations
echo "Running migrations..."
python manage.py makemigrations
python manage.py migrate
echo "Migrations completed."
echo ""

# Create Railway configuration files if not already present
if [ ! -f railway.json ]; then
    echo "Creating Railway configuration..."
    cat > railway.json << EOL
{
    "build": {
        "builder": "NIXPACKS"
    },
    "deploy": {
        "startCommand": "gunicorn onepharm_project.wsgi:application --log-file -",
        "restartPolicyType": "ON_FAILURE",
        "restartPolicyMaxRetries": 10
    }
}
EOL
    echo "Railway configuration created."
    echo ""
fi

# Create Procfile for Railway deployment
if [ ! -f Procfile ]; then
    echo "Creating Procfile..."
    echo "web: gunicorn onepharm_project.wsgi:application --log-file -" > Procfile
    echo "Procfile created."
    echo ""
fi

echo "===== Deployment Preparation Complete ====="
echo ""
echo "Next steps:"
echo "1. Create MongoDB Atlas account and update MONGODB_URI in .env file"
echo "2. Create Railway account and link with GitHub"
echo "3. Deploy using 'railway up' or connect GitHub repository"
echo "4. After deployment, run: railway domain"
echo ""
echo "For more information, refer to deploy.md" 