HEAD
# Real-Estate_Portal

# Real Estate Platform

A comprehensive real estate property comparison and management platform.

## Features

- Property comparison tool
- Detailed property information
- Admin panel for property management
- Real-time property data
- Investment analysis
- Market insights

## Getting Started

### Prerequisites

- Node.js (v14 or higher)
- MySQL database
- npm or yarn package manager

### Installation

1. **Install backend dependencies:**
   ```bash
   cd backend
   npm install
   ```

2. **Install frontend dependencies:**
   ```bash
   cd frontend
   npm install
   ```

3. **Set up the database:**
   - Import the `Real-Estate.sql` file into your MySQL database
   - Update the database connection in `backend/db.js`

### Running the Application

1. **Start the backend server:**
   ```bash
   cd backend
   npm start
   ```
   The server will run on `http://localhost:3001`

2. **Access the application:**
   - Open your browser and go to `http://localhost:3001`
   - The home page will automatically load as the default page
   - You can also access specific pages:
     - Home page: `http://localhost:3001/home_page.html`
     - Property details: `http://localhost:3001/property_detail.html`
     - Admin panel: `http://localhost:3001/admin/`

## Project Structure

```
Real-Estate/
├── backend/                 # Backend API server
│   ├── controllers/        # API controllers
│   ├── models/            # Database models
│   ├── routes/            # API routes
│   └── server.js          # Main server file
├── frontend/              # Frontend application
│   ├── public/            # Static files
│   │   ├── index.html     # Default entry point
│   │   ├── home_page.html # Main home page
│   │   └── property_detail.html
│   └── admin/             # Admin panel
└── Real-Estate.sql        # Database schema
```

## API Endpoints

The backend provides RESTful APIs for:
- Properties management
- Developers information
- Location data
- Amenities and features
- Financial details
- Market analysis
- User management

## Default Page

The application is configured to automatically serve the home page (`home_page.html`) as the default page when you visit `http://localhost:3001`. The `index.html` file provides a smooth loading experience with automatic redirection to the main home page. 
1bde4db (Initial commit)
