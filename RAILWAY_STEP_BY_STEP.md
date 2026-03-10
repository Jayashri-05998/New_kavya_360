# 🎯 Step-by-Step Railway Configuration Guide

## 🚨 Problem You Had

```
⚠ Script start.sh not found
✖ Railpack could not determine how to build the app
when database connect to backend in production the build is failed
```

## ✅ Solution Applied

Created 4 new files to fix the issue:

1. **`start.sh`** - Entry point script
2. **`package.json`** - Project definition
3. **`Procfile`** - Process configuration
4. **`RAILWAY_MULTI_SERVICE_DEPLOYMENT.md`** - Detailed guide

All files are now pushed to your GitHub repository in the `connection2` branch.

---

## 📋 Step-by-Step Configuration

### STEP 1: Delete Old Broken Deployment

1. Go to https://railway.app
2. Select your KavyaProMan project
3. Click on the failed deployment
4. Scroll down and click "Delete Project"
5. Confirm deletion

### STEP 2: Create New Project

1. Go to https://railway.app
2. Click "Create New Project"
3. Select "GitHub"
4. Search for: `New_kavya_360`
5. Select repository owned by `Jayashri-05998`
6. Click "Deploy Now"

**Railway will now:**
- ✅ Detect `start.sh`
- ✅ Detect `package.json`
- ✅ Detect `Procfile`
- ✅ Start building automatically

### STEP 3: Wait for Build

Railway will build using:
```bash
npm start  # Runs start.sh as configured in package.json
```

This should complete in 5-10 minutes.

---

## 🔧 Configure Environment Variables

### BACKEND SERVICE - Environment Variables

Once the project is created, go to Variables tab and add:

```
SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/kavyaprodb
SPRING_DATASOURCE_USERNAME=root
SPRING_DATASOURCE_PASSWORD={MYSQL_PASSWORD_FROM_SERVICE}
SPRING_JPA_HIBERNATE_DDL_AUTO=update
SPRING_JPA_SHOW_SQL=false
SPRING_PROFILES_ACTIVE=prod
SENDGRID_API_KEY={your-sendgrid-key}
SENDGRID_FROM_EMAIL=kavyalearn.info@gmail.com
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER={your-email}
EMAIL_PASS={your-email-password}
SERVICE_TYPE=backend
PORT=8080
```

### FRONTEND SERVICE - Environment Variables

```
VITE_API_BASE_URL=https://{BACKEND_URL}/api
VITE_API_URL=https://{BACKEND_URL}
NODE_ENV=production
SERVICE_TYPE=frontend
PORT=3000
```

---

## 🗄️ Add MySQL Database

### Step 1: Add MySQL Service

1. In Railway dashboard
2. Click "Add Service"
3. Select "MySQL"
4. Click "Deploy"

### Step 2: Link MySQL to Backend

1. Go to MySQL service
2. Click "Connect"
3. Copy connection details
4. Go to Backend service → Variables
5. Add:
   ```
   SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/kavyaprodb
   SPRING_DATASOURCE_USERNAME=root
   SPRING_DATASOURCE_PASSWORD={copy_from_mysql_service}
   ```

---

## 📊 Expected Service Structure

After configuration, you should have:

```
Project: KavyaProMan
├── backend (Java/Spring Boot)
│   └── Port: 8080
│   └── URL: https://{random-name}.railway.app
│   └── Status: Running
│
├── frontend (React/Node)
│   └── Port: 3000
│   └── URL: https://{random-name}.railway.app
│   └── Status: Running
│
└── mysql (Database)
    └── Port: 3306
    └── Status: Running
```

---

## 🔍 Verify Everything Works

### Check Backend API

```bash
curl https://{backend-url}/api/auth/health
# Should return: 200 OK
```

### Check Frontend

1. Open frontend URL in browser
2. Should see login page
3. Try to login
4. Should call backend successfully

### Check Database Connection

In backend logs, you should see:
```
Database connection successful
Hibernate initialized
Tables created/updated
```

---

## 🚨 Common Issues & Fixes

### Issue 1: Build Still Fails
**Fix:**
1. Verify GitHub has the latest code
2. Run locally: `git push origin connection2`
3. Delete project and recreate
4. Check that `start.sh`, `package.json`, `Procfile` exist

### Issue 2: Backend Can't Connect to Database
**Fix:**
1. Verify MySQL service is running
2. Check connection URL format
3. Ensure MYSQL_PASSWORD is set
4. Check backend logs for error details

### Issue 3: Frontend Can't Call Backend
**Fix:**
1. Verify VITE_API_BASE_URL is correct
2. Check backend CORS configuration
3. Verify both services are running
4. Check browser console for errors

### Issue 4: Build Fails with "terser not found"
**Fix:** Already resolved in our configuration
- This was because of explicit terser config in old vite.config.js
- Now using Vite's built-in minification

### Issue 5: "NODE_ENV not supported in .env"
**Fix:** Already resolved
- NODE_ENV now set in build config, not .env file
- Remove `NODE_ENV=production` from .env if it exists

---

## 📝 Key Configuration Values

### Database Connection String
```
jdbc:mysql://mysql:3306/kavyaprodb
```
- `mysql` = MySQL service name on Railway
- `3306` = Default MySQL port
- `kavyaprodb` = Database name

### URLs After Deployment
```
Backend API:  https://{random-name}.railway.app
Frontend UI:  https://{random-name}.railway.app
Database:     mysql:3306 (internal only)
```

### Build Commands (Automatic)
```
Backend: cd backend && ./mvnw clean package -DskipTests -Dspring.profiles.active=prod
Frontend: cd frontend && npm install && npm run build && npx serve -s dist -l 3000
```

---

## ✅ Final Verification Checklist

### Before Deployment
- [ ] `start.sh` file created ✅
- [ ] `package.json` file created ✅
- [ ] `Procfile` file created ✅
- [ ] All files pushed to GitHub ✅
- [ ] Branch: `connection2` has latest code ✅

### During Deployment
- [ ] New project created in Railway
- [ ] Build started automatically
- [ ] Build completed successfully
- [ ] Services showing as "Running"
- [ ] No error logs in dashboard

### After Deployment
- [ ] Backend responds to API calls
- [ ] Frontend displays login page
- [ ] Frontend can call backend
- [ ] Database connection working
- [ ] Logs show no errors

---

## 🎉 Success Indicators

When everything is working:

1. **Backend Service**
   - Status: "Running"
   - Logs show: "Tomcat started on port 8080"
   - Health check passes

2. **Frontend Service**
   - Status: "Running"
   - Logs show: "Server is running"
   - Page loads in browser

3. **MySQL Service**
   - Status: "Running"
   - Backend successfully connects
   - Tables are created/updated

---

## 🚀 Quick Reference - What to Do NOW

1. **Delete old deployment** → Railway Dashboard
2. **Create new project** → Select GitHub repo → connection2 branch
3. **Wait for build** → Should succeed with our new config files
4. **Add MySQL** → Create new MySQL service
5. **Configure variables** → Add env vars for backend and frontend
6. **Monitor logs** → Watch the deployment succeed
7. **Test** → Access frontend URL and verify login works

---

## 📞 Support Reference

If you need help:
1. Check Railway logs in dashboard
2. Look for specific error messages
3. Verify all environment variables are set
4. Ensure MySQL service is running
5. Check GitHub has latest code with new config files

---

**Status**: ✅ Ready to Deploy  
**Files Created**: 4 (start.sh, package.json, Procfile, guide)  
**Next Action**: Delete old deployment and create new one in Railway  
**Expected Result**: Successful multi-service deployment 🎊
