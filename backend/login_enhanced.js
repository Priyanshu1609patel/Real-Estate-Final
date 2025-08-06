// Login endpoint with enhanced error handling and logging
app.post('/api/login', async (req, res) => {
  console.log('Login attempt received:', { 
    username: req.body.username ? 'provided' : 'missing',
    ip: req.ip,
    userAgent: req.get('User-Agent'),
    timestamp: new Date().toISOString()
  });

  try {
    const { username, password } = req.body;
    
    // Input validation
    if (!username || !password) {
      console.log('Login failed: Missing credentials');
      return res.status(400).json({ 
        success: false,
        error: 'Username and password are required' 
      });
    }

    // Find user by username or email
    let user;
    try {
      const result = await pool.query(
        'SELECT * FROM users WHERE username = $1 OR email = $1',
        [username]
      );
      user = result.rows[0];
    } catch (dbError) {
      console.error('Database error during login:', dbError);
      return res.status(500).json({ 
        success: false,
        error: 'Error accessing user database' 
      });
    }
    
    // Check if user exists
    if (!user) {
      console.log(`Login failed: User not found - ${username}`);
      return res.status(401).json({ 
        success: false,
        error: 'Invalid username or password' 
      });
    }

    // Verify password
    let isPasswordValid = false;
    try {
      isPasswordValid = await bcrypt.compare(password, user.password_hash);
    } catch (bcryptError) {
      console.error('Error comparing passwords:', bcryptError);
      return res.status(500).json({ 
        success: false,
        error: 'Error during authentication' 
      });
    }

    if (!isPasswordValid) {
      console.log(`Login failed: Invalid password for user - ${username}`);
      return res.status(401).json({ 
        success: false,
        error: 'Invalid username or password' 
      });
    }

    // Create and sign JWT token
    const token = jwt.sign(
      { 
        id: user.id, 
        username: user.username, 
        email: user.email 
      }, 
      process.env.JWT_SECRET || 'fallback-secret-key',
      { expiresIn: '24h' }
    );

    // Return user data (excluding password) and token
    const { password_hash, ...userWithoutPassword } = user;
    
    console.log(`Login successful for user: ${user.username} (ID: ${user.id})`);
    
    res.json({
      success: true,
      user: userWithoutPassword,
      token,
      expiresIn: '24h'
    });

  } catch (error) {
    console.error('Unexpected error during login:', {
      error: error.message,
      stack: error.stack,
      body: req.body,
      timestamp: new Date().toISOString()
    });
    
    res.status(500).json({ 
      success: false,
      error: 'An unexpected error occurred during login',
      // Only include error details in development
      ...(process.env.NODE_ENV === 'development' && { 
        details: error.message 
      })
    });
  }
});
