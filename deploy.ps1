# One Pharm Backend Yerləşdirmə Skripti (Windows üçün)
# Bu skript One Pharm backend-ini yerləşdirməyə kömək edir

Write-Host "===== One Pharm Backend Yerləşdirmə Skripti =====" -ForegroundColor Green
Write-Host "Bu skript backend-i Railway-də yerləşdirməyə kömək edəcək" -ForegroundColor Green
Write-Host ""

# .env faylı yoxla, yoxdursa yarat
if (-not (Test-Path .env)) {
    Write-Host ".env faylı yaradılır..." -ForegroundColor Yellow
    
    $secretKey = python -c "import secrets; print(secrets.token_hex(32))"
    
    $envContent = @"
SECRET_KEY=$secretKey
DEBUG=False
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/onepharm
ALLOWED_HOSTS=.up.railway.app,localhost,127.0.0.1
"@
    
    Set-Content -Path .env -Value $envContent -Encoding UTF8
    
    Write-Host ".env faylı yaradıldı. Zəhmət olmasa MONGODB_URI-ni öz MongoDB Atlas məlumatlarınızla yeniləyin." -ForegroundColor Yellow
    Write-Host ""
}

# Lazımi paketləri quraşdır
Write-Host "Asılılıqlar quraşdırılır..." -ForegroundColor Yellow
pip install -r requirements.txt
Write-Host "Asılılıqlar quraşdırıldı." -ForegroundColor Green
Write-Host ""

# Statik faylları topla
Write-Host "Statik fayllar toplanır..." -ForegroundColor Yellow
python manage.py collectstatic --noinput
Write-Host "Statik fayllar toplandı." -ForegroundColor Green
Write-Host ""

# Migrasiyaları işlət
Write-Host "Migrasiyalar işlədilir..." -ForegroundColor Yellow
python manage.py makemigrations
python manage.py migrate
Write-Host "Migrasiyalar tamamlandı." -ForegroundColor Green
Write-Host ""

# Railway konfiqurasiya faylları yaradılır
if (-not (Test-Path railway.json)) {
    Write-Host "Railway konfiqurasiyası yaradılır..." -ForegroundColor Yellow
    
    $railwayConfig = @"
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
"@
    
    Set-Content -Path railway.json -Value $railwayConfig -Encoding UTF8
    
    Write-Host "Railway konfiqurasiyası yaradıldı." -ForegroundColor Green
    Write-Host ""
}

# Procfile yaradın
if (-not (Test-Path Procfile)) {
    Write-Host "Procfile yaradılır..." -ForegroundColor Yellow
    Set-Content -Path Procfile -Value "web: gunicorn onepharm_project.wsgi:application --log-file -" -Encoding UTF8
    Write-Host "Procfile yaradıldı." -ForegroundColor Green
    Write-Host ""
}

Write-Host "===== Yerləşdirmə Hazırlığı Tamamlandı =====" -ForegroundColor Green
Write-Host ""
Write-Host "Növbəti addımlar:" -ForegroundColor Cyan
Write-Host "1. MongoDB Atlas hesabı yaradın və .env faylında MONGODB_URI-ni yeniləyin"
Write-Host "2. Railway hesabı yaradın və GitHub ilə əlaqələndirin"
Write-Host "3. 'railway login' əmri ilə giriş edin və 'railway up' ilə yerləşdirin"
Write-Host "4. Yerləşdirmədən sonra: railway domain"
Write-Host ""
Write-Host "Əlavə məlumat üçün deploy.md-ə baxın" 