# One Pharm Backend Deployment

Bu sənəd, Django və MongoDB əsasında hazırlanan One Pharm backend-in pulsuz serverdə yerləşdirilməsini təsvir edir.

## 1. MongoDB Atlas - Pulsuz Verilənlər Bazası

MongoDB Atlas pulsuz (shared) klaster təklif edir:

1. [MongoDB Atlas-a](https://www.mongodb.com/cloud/atlas) qeydiyyatdan keçin
2. "Create a New Cluster" düyməsinə basın
3. Free Tier (M0) seçin
4. Region seçin (Azərbaycana ən yaxın mərkəz)
5. Klasterin adını təyin edin (məs: "onepharm-db")
6. "Create Cluster" düyməsinə basın
7. Verilənlər bazasına giriş üçün istifadəçi yaradın:
   - "Database Access" bölməsində "Add New Database User" seçin
   - İstifadəçi adı və şifrə təyin edin
   - "Add User" düyməsinə basın
8. IP ünvanını əlavə edin (bütün ünvanlardan giriş imkanı üçün):
   - "Network Access" bölməsində "Add IP Address" seçin  
   - "Allow Access From Anywhere" seçin (0.0.0.0/0)
9. Bağlantı sətri alın:
   - "Connect" düyməsinə basın
   - "Connect your application" seçin
   - Bağlantı sətrini kopyalayın: `mongodb+srv://username:password@cluster.mongodb.net/onepharm`

## 2. Railway - Pulsuz Hosting

Railway pulsuz başlanğıc planı təklif edir:

1. [Railway-ə](https://railway.app/) GitHub hesabınızla qeydiyyatdan keçin
2. "New Project" düyməsinə basın
3. "Deploy from GitHub repo" seçin
4. One Pharm backend repository-ni seçin
5. MongoDB bağlantı məlumatlarını təyin edin:
   - "Variables" bölməsində yeni dəyişən əlavə edin
   - `MONGODB_URI` adlı dəyişən yaradın və dəyərinə MongoDB Atlas bağlantı sətrini yazın
   - Digər lazımi dəyişənləri əlavə edin:
     - `SECRET_KEY` (təsadüfi bir açar)
     - `DEBUG` (False - istehsal mühiti üçün)
     - `ALLOWED_HOSTS` (railway.app domeni)
6. Railway avtomatik olaraq tətbiqi yerləşdirəcək

## 3. Domain Quraşdırılması (İstəyə bağlı)

Railway tətbiqiniz üçün default domen təklif edir, lakin öz domeninizi əlavə etmək istəsəniz:

1. Railway-də "Settings" > "Domains" bölməsinə keçin
2. "Custom Domain" əlavə edin
3. DNS qeydlərini domendə konfiqurasiya edin

## 4. CI/CD İnteqrasiyası

Railway GitHub ilə inteqrasiya olunur, yəni hər yeni commit avtomatik yerləşdirilir:

1. Backend kodunuzda GitHub üçün workflow faylları yaradın:
   - `.github/workflows/deploy.yml` faylında deployment ardıcıllığını avtomatlaşdırın
   - Testlər əlavə edin ki, yalnız uğurlu testlərdən sonra yerləşdirsin

## 5. Monitorinq və Xəta İzləmə

Railway dashboard-da tətbiqin loqlarını izləyə bilərsiniz. Əlavə monitorinq üçün:

1. [Sentry](https://sentry.io) - pulsuz xəta izləmə və monitorinq
2. [Uptime Robot](https://uptimerobot.com) - tətbiqinizin işləyib-işləmədiyini izləmək üçün

## Qeydlər

- Railway pulsuz planı ayda 500 saatlıq istifadə təklif edir
- MongoDB Atlas pulsuz planı 512MB yer təklif edir
- Tətbiqiniz uğurla yerləşdikdən sonra mövcud API-nizi yeniləyin - `api.ts` faylında `API_URL` dəyişənini yeniləyin və yeni endpoint-ə yönləndirin 