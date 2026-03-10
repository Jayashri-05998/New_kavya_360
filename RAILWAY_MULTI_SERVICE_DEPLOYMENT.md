# 🚀 Railway Multi-Service Deployment Guide

## Problem Identified

Railway couldn't detect your app because:
1. Root directory contains both backend (Java) and frontend (Node.js)
2. No clear entry point (missing `start.sh` and root `package.json`)
3. Railpack couldn't determine which language/framework to build

## ✅ Solution Applied

I've created the necessary files for Railway to properly detect and build both services:

### Files Created/Updated:

1. **`start.sh`** - Main entry point for Railway
   - Detects SERVICE_TYPE environment variable
   - Builds and runs either backend or frontend
   - Handles production configuration

2. **`package.json`** (root level) - Node.js indicator
   - Tells Railway this is a Node.js project
   - Provides build scripts for both services
   - Installs `serve` for frontend hosting

3. **`Procfile`** - Heroku/Railway process definition
   - Specifies `web: bash start.sh` as entry point

## 🔧 Railway Configuration Steps

### Step 1: Set Up Backend Service

```
Service Name: backend
Source: GitHub (Jayashri-05998/New_kavya_360)
Root Directory: backend
Build Command: mvn clean package -DskipTests -Dspring.profiles.active=prod
Start Command: java -jar target/backend-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
Port: 8080
Environment Variables:
  - SPRING_PROFILES_ACTIVE: prod
  - SPRING_DATASOURCE_URL: jdbc:mysql://{MYSQL_HOST}:{MYSQL_PORT}/kavyaprodb
  - SPRING_DATASOURCE_USERNAME: {MYSQL_USER}
  - SPRING_DATASOURCE_PASSWORD: {MYSQL_PASSWORD}
  - SENDGRID_API_KEY: {your-sendgrid-key}
  - EMAIL_USER: {your-email}
  - EMAIL_PASS: {your-password}
```

### Step 2: Set Up Frontend Service

```
Service Name: frontend
Source: GitHub (Jayashri-05998/New_kavya_360)
Root Directory: frontend
Build Command: npm install && npm run build
Start Command: npx serve -s dist -l 3000
Port: 3000
Environment Variables:
  - VITE_API_BASE_URL: https://{backend-domain}/api
  - NODE_ENV: production
```

### Step 3: Set Up MySQL Database

```
Service Name: mysql
Type: Database
Database: MySQL 8.0+
Username: root
Password: {auto-generated}
Port: 3306
```

## 🔗 Environment Variables to Configure

### Backend (Java Spring Boot)
```
SPRING_PROFILES_ACTIVE=prod
SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/kavyaprodb
SPRING_DATASOURCE_USERNAME=root
SPRING_DATASOURCE_PASSWORD={MYSQL_PASSWORD}
SPRING_JPA_HIBERNATE_DDL_AUTO=update
SPRING_JPA_SHOW_SQL=false
SENDGRID_API_KEY={your-sendgrid-api-key}
SENDGRID_FROM_EMAIL=kavyalearn.info@gmail.com
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER={your-email}
EMAIL_PASS={your-app-password}
```

### Frontend (React/Vite)
```
VITE_API_BASE_URL=https://{your-backend-domain}/api
VITE_API_URL=https://{your-backend-domain}
NODE_ENV=production
```

## 📋 Deployment Checklist

- [ ] Create `start.sh` file ✅ (Created)
- [ ] Create root `package.json` ✅ (Created)
- [ ] Create `Procfile` ✅ (Created)
- [ ] Push all changes to GitHub
  ```bash
  git add start.sh package.json Procfile
  git commit -m "Add Railway configuration files"
  git push origin main
  ```

- [ ] In Railway Dashboard:
  - [ ] Delete existing deployment
  - [ ] Create new project from GitHub
  - [ ] Select repository: Jayashri-05998/New_kavya_360
  - [ ] Select branch: main
  - [ ] Wait for Railway to detect project type

- [ ] Configure MySQL Database
  - [ ] Create MySQL plugin in Railway
  - [ ] Note down connection details
  - [ ] Add to backend environment variables

- [ ] Configure Backend Service
  - [ ] Set root directory to `backend`
  - [ ] Add all backend environment variables
  - [ ] Ensure SPRING_PROFILES_ACTIVE=prod

- [ ] Configure Frontend Service
  - [ ] Set root directory to `frontend`
  - [ ] Add VITE_API_BASE_URL pointing to backend
  - [ ] Set NODE_ENV=production

## 🔍 Troubleshooting

### Build Failed: "Railpack could not determine how to build the app"
**Solution**: Ensure all three files exist:
- ✅ `start.sh`
- ✅ `package.json` (root)
- ✅ `Procfile`

### Database Connection Error
**Solution**: 
1. Verify MySQL service is running
2. Check connection string in backend environment variables
3. Ensure SPRING_PROFILES_ACTIVE=prod

### Frontend can't reach backend
**Solution**:
1. Verify VITE_API_BASE_URL points to correct backend domain
2. Check backend CORS configuration
3. Ensure both services are running

### Build taking too long
**Solution**:
- Add `build-cache` configuration
- Skip tests: `-DskipTests` for Maven
- Use smaller Docker image base

## 📊 Project Structure for Railway

```
KavyaProMan360/
├── start.sh                 ← Railway entry point
├── Procfile                 ← Process definition
├── package.json             ← Root node.js config
├── railway.json             ← Service definitions
├── backend/
│   ├── Dockerfile
│   ├── pom.xml
│   ├── mvnw
│   └── src/
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   └── src/
└── .github/
    └── workflows/           ← CI/CD (optional)
```

## 🚀 Next Steps

1. **Push Configuration Files**
   ```bash
   cd c:\Users\Administrator\OneDrive\OneDrive\ -\ Kavya\ Infoweb\ Private\ Limited\Desktop\KavyaProMan300
   git add start.sh package.json Procfile
   git commit -m "Add Railway deployment configuration"
   git push origin connection2
   ```

2. **Go to Railway Dashboard**
   - Create new project
   - Connect GitHub repository
   - Wait for auto-detection

3. **Configure Services**
   - Backend: Set SPRING_PROFILES_ACTIVE=prod
   - Frontend: Set VITE_API_BASE_URL
   - MySQL: Create and link database

4. **Deploy**
   - Push to main branch
   - Railway auto-deploys
   - Monitor logs in dashboard

## 📝 Important Notes

- **Database Connection**: Backend needs read/write access to MySQL
- **CORS**: Backend CORS config must allow frontend domain
- **Environment Variables**: All sensitive data should be in Railway secrets
- **Build Time**: First build may take 5-10 minutes
- **Logs**: Check Railway logs for any errors during build/deployment

## 🎯 Expected Result

Once deployed:
- Backend API running at: `https://your-backend-domain.railway.app`
- Frontend running at: `https://your-frontend-domain.railway.app`
- MySQL database connected and operational
- Full application stack live and connected

---

**Status**: ✅ Configuration Complete  
**Next**: Push to GitHub and deploy via Railway Dashboard
