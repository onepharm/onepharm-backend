# One Pharm Backend

Bu layihə Django və MongoDB ilə işləyən One Pharm tətbiqinin backend hissəsidir.

## Quraşdırma

### Tələblər
- Python 3.8 və ya daha yüksək
- MongoDB

### Addımlar

1. Virtual mühiti aktivləşdirin:
   ```
   # Windows
   venv\Scripts\activate
   
   # Linux/Mac
   source venv/bin/activate
   ```

2. Tələbləri quraşdırın:
   ```
   pip install -r requirements.txt
   ```

3. .env faylını yaradın və məxfi məlumatları əlavə edin:
   ```
   SECRET_KEY=sizin_gizli_açarınız
   DEBUG=True
   MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/onepharm
   ALLOWED_HOSTS=localhost,127.0.0.1
   ```

4. Django layihəsini miqrasiya edin:
   ```
   python manage.py makemigrations
   python manage.py migrate
   ```

5. Admin istifadəçi yaradın:
   ```
   python manage.py createsuperuser
   ```

6. Serveri işə salın:
   ```
   python manage.py runserver
   ```

## API Endpoint-lər

- `POST /api/auth/register/` - Qeydiyyat
- `POST /api/auth/login/` - Giriş
- `POST /api/auth/logout/` - Çıxış
- `GET /api/pharmacies/` - Aptekləri əldə etmək
- `POST /api/pharmacies/` - Aptek əlavə etmək
- `GET /api/users/profile/` - İstifadəçi profili
- `PUT /api/users/profile/` - İstifadəçi profilini yeniləmək

## Deployment

Railway-də yerləşdirmək üçün avtomatik təlimatlar `deploy.md` faylında verilmişdir. 