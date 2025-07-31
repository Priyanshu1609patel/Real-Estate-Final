const express = require('express');
const cors = require('cors');
const path = require('path');
const { pool, query, checkConnection } = require('./db');

// Import route handlers
const userRoutes = require('./routes/userRoutes');

const app = express();

// Configure CORS
const allowedOrigins = process.env.CORS_ORIGIN 
  ? process.env.CORS_ORIGIN.split(',').map(origin => origin.trim())
  : [];

const corsOptions = {
  origin: (origin, callback) => {
    // Allow requests with no origin (like mobile apps or curl requests)
    if (!origin) return callback(null, true);
    
    if (allowedOrigins.indexOf(origin) === -1) {
      const msg = 'The CORS policy for this site does not allow access from the specified Origin.';
      return callback(new Error(msg), false);
    }
    return callback(null, true);
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
};

app.use(cors(corsOptions));
app.use(express.json());

// Serve static files from the frontend/public directory
app.use(express.static(path.join(__dirname, '../frontend/public')));

// Serve files from /public path as well
app.use('/public', express.static(path.join(__dirname, '../frontend/public')));

// Serve admin files from the frontend/admin directory
app.use('/admin', express.static(path.join(__dirname, '../frontend/admin')));

// Serve the home page as the default route
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/public/index.html'));
});

// Use the port provided by the environment or default to 10000 for local development
const PORT = process.env.PORT || 10000;
const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key_here';

// Authentication Middleware
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) return res.sendStatus(401);

  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
};

// Mount user routes
app.use('/api', userRoutes);

// Properties endpoints
app.get('/api/properties', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM properties ORDER BY id');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching properties:', error);
    res.status(500).json({ error: 'Error fetching properties' });
  }
});

// Locations endpoints
app.get('/api/locations', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM locations ORDER BY id');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching locations:', error);
    res.status(500).json({ error: 'Error fetching locations' });
  }
});

// Developers endpoints
app.get('/api/developers', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM developers ORDER BY id');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching developers:', error);
    res.status(500).json({ error: 'Error fetching developers' });
  }
});

// Start the server with error handling
const server = app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server is running on port ${PORT}`);
  console.log(`CORS allowed origins: ${allowedOrigins.join(', ') || 'None'}`);
  
  // Test database connection
  checkConnection()
    .then(() => console.log('Database connection successful'))
    .catch(err => console.error('Database connection error:', err));
});

// Handle unhandled promise rejections
process.on('unhandledRejection', (err) => {
  console.error('Unhandled Rejection:', err);
  // Close server & exit process
  server.close(() => process.exit(1));
});

// Handle uncaught exceptions
process.on('uncaughtException', (err) => {
  console.error('Uncaught Exception:', err);
  // Close server & exit process
  server.close(() => process.exit(1));
});
