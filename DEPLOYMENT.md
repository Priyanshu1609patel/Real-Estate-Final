# Railway Deployment Guide

This guide will help you deploy the Real Estate application to Railway.

## Prerequisites

1. A Railway account (sign up at [railway.app](https://railway.app/))
2. GitHub account (connected to Railway)
3. Your application code pushed to a GitHub repository

## Deployment Steps

### 1. Create a New Project on Railway

1. Log in to your Railway account
2. Click on "New Project"
3. Select "Deploy from GitHub repo"
4. Select your repository

### 2. Set Up Environment Variables

1. In your Railway project, go to the "Variables" tab
2. Add the following environment variables:
   - `NODE_ENV`: `production`
   - `PORT`: `$PORT` (automatically provided by Railway)
   - `JWT_SECRET`: A secure random string for JWT token signing
   - `DB_HOST`: `$MYSQLHOST` (provided by Railway when you add a MySQL database)
   - `DB_PORT`: `$MYSQLPORT`
   - `DB_USER`: `$MYSQLUSER`
   - `DB_PASSWORD`: `$MYSQLPASSWORD`
   - `DB_NAME`: `$MYSQLDATABASE`

### 3. Add a MySQL Database

1. In your Railway project, click on "New"
2. Select "Database"
3. Choose "MySQL"
4. Railway will automatically set up the database and provide the connection details as environment variables

### 4. Deploy Your Application

1. Railway will automatically detect your Node.js application and start the deployment
2. The deployment process will:
   - Install dependencies using `npm install`
   - Start the application using `node backend/server.js`

### 5. Set Up a Custom Domain (Optional)

1. Go to the "Settings" tab in your Railway project
2. Under "Custom Domains", click "Add Custom Domain"
3. Follow the instructions to verify domain ownership

### 6. Import Database Schema

1. After deployment, you'll need to import your database schema
2. You can use the `real-estate-database.sql` file to set up your database tables
3. You can use a MySQL client or the Railway console to run the SQL commands

## Troubleshooting

- **Build Fails**: Check the build logs in the Railway dashboard for specific error messages
- **Database Connection Issues**: Verify that all database environment variables are correctly set
- **Application Crashes**: Check the application logs in the Railway dashboard

## Local Development

To run the application locally:

1. Copy `.env.example` to `.env` and update the values
2. Install dependencies: `npm install`
3. Start the development server: `npm run dev`

The application will be available at `http://localhost:3001`
