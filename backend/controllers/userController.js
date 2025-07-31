const User = require('../models/user');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '24h';

exports.register = async (req, res) => {
  try {
    console.log('Registration attempt:', { 
      username: req.body.username ? 'provided' : 'missing',
      email: req.body.email ? 'provided' : 'missing',
      timestamp: new Date().toISOString()
    });

    const { username, email, password } = req.body;
    
    // Validate input
    if (!username || !email || !password) {
      console.log('Validation failed: Missing required fields');
      return res.status(400).json({ 
        error: 'All fields are required',
        details: !username && !email && !password ? 'Username, email and password are missing' :
                !username ? 'Username is required' :
                !email ? 'Email is required' : 'Password is required'
      });
    }

    // Create user
    User.create({ username, email, password }, (err, result) => {
      if (err) {
        console.error('Registration error:', {
          error: err.message,
          code: err.code,
          timestamp: new Date().toISOString()
        });
        
        if (err.code === 'ER_DUP_ENTRY') {
          return res.status(409).json({ 
            error: 'Username or email already exists',
            details: 'Please choose a different username or email'
          });
        }
        
        return res.status(500).json({ 
          error: 'Registration failed',
          details: process.env.NODE_ENV === 'development' ? err.message : undefined
        });
      }
      
      console.log('Registration successful for user:', username);
      res.status(201).json({ 
        message: 'User registered successfully',
        user: { id: result.insertId, username, email }
      });
    });
  } catch (error) {
    console.error('Unexpected registration error:', {
      message: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({ 
      error: 'An unexpected error occurred during registration',
      details: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

exports.login = (req, res) => {
  try {
    console.log('Login attempt:', { 
      username: req.body.username ? 'provided' : 'missing',
      timestamp: new Date().toISOString()
    });
    
    const { username, password } = req.body;
    
    // Validate input
    if (!username || !password) {
      console.log('Validation failed: Missing credentials');
      return res.status(400).json({ 
        error: 'Username and password are required',
        details: !username && !password ? 'Both username and password are missing' :
                !username ? 'Username is required' : 'Password is required'
      });
    }

    // Find user by username or email
    User.findByUsernameOrEmail(username, async (err, user) => {
      if (err) {
        console.error('Database query error:', {
          error: err.message,
          query: 'SELECT * FROM users WHERE username = ? OR email = ?',
          params: [username, username],
          timestamp: new Date().toISOString()
        });
        return res.status(500).json({ 
          error: 'Database error during login',
          details: process.env.NODE_ENV === 'development' ? err.message : undefined
        });
      }
      
      // Check if user exists
      if (!user) {
        console.log('Login failed: User not found -', username);
        return res.status(401).json({ error: 'Invalid username or password' });
      }

      // Verify password
      let validPassword = false;
      try {
        validPassword = await bcrypt.compare(password, user.password_hash);
      } catch (bcryptError) {
        console.error('Password comparison error:', {
          error: bcryptError.message,
          timestamp: new Date().toISOString()
        });
        return res.status(500).json({ 
          error: 'Error during authentication',
          details: 'Could not verify password'
        });
      }

      if (!validPassword) {
        console.log('Login failed: Invalid password for user -', username);
        return res.status(401).json({ error: 'Invalid username or password' });
      }

      // Create and sign JWT token
      const token = jwt.sign(
        { 
          id: user.id, 
          username: user.username, 
          email: user.email 
        }, 
        JWT_SECRET,
        { expiresIn: JWT_EXPIRES_IN }
      );

      // Return user data (excluding password) and token
      const { password_hash, ...userWithoutPassword } = user;
      console.log('Login successful for user:', user.username);
      
      res.json({
        message: 'Login successful',
        user: userWithoutPassword,
        token
      });
    });
  } catch (error) {
    console.error('Unexpected login error:', {
      message: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({ 
      error: 'An unexpected error occurred during login',
      details: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

exports.logout = (req, res) => {
  // Client-side should remove the token from storage
  // For server-side token invalidation, we would need a token blacklist
  console.log('User logged out');
  res.json({ message: 'Logout successful' });
};