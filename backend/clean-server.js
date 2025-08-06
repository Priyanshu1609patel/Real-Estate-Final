const express = require('express');
const cors = require('cors');
const path = require('path');
const { pool } = require('./db');

const app = express();

// Basic CORS configuration
app.use(cors({
  origin: [
    'http://localhost:10001',
    'http://127.0.0.1:10001',
    'https://real-estate-app-20a2.onrender.com'
  ],
  credentials: true
}));

// Body parsing middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Test database connection
app.get('/api/test-db', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({ status: 'Database connected', time: result.rows[0].now });
  } catch (error) {
    console.error('Database connection error:', error);
    res.status(500).json({ error: 'Database connection failed' });
  }
});

// Serve static files
app.use(express.static(path.join(__dirname, '../frontend/public')));

// Simple route for testing
app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from the server!' });
});

// Catch-all route for client-side routing
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/public/index.html'));
});

// Start the server
const PORT = process.env.PORT || 10002; // Using a different port to avoid conflicts
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
  console.log(`🌐 Test the server: http://localhost:${PORT}/api/hello`);
  console.log(`🌐 Test database: http://localhost:${PORT}/api/test-db`);
});
