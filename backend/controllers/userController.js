const User = require('../models/user');

exports.register = (req, res) => {
  const { username, email, password } = req.body;
  if (!username || !email || !password) {
    return res.status(400).json({ error: 'All fields are required' });
  }
  User.create({ username, email, password }, (err, result) => {
    if (err) {
      if (err.code === 'ER_DUP_ENTRY') {
        return res.status(409).json({ error: 'Username or email already exists' });
      }
      return res.status(500).json({ error: 'Registration failed' });
    }
    res.status(201).json({ message: 'User registered successfully' });
  });
};

exports.login = (req, res) => {
  const { username, password } = req.body;
  if (!username || !password) {
    return res.status(400).json({ error: 'All fields are required' });
  }
  User.findByUsernameOrEmail(username, (err, user) => {
    if (err || !user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    // Compare plain text password
    if (password !== user.password_hash) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    res.json({ message: 'Login successful', user: { id: user.id, username: user.username, email: user.email } });
  });
};
// FOR DEMO PURPOSES ONLY: Return password in plain text (insecure)
exports.forgotPassword = (req, res) => {
  const { email } = req.body;
  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }
  // Find user by email
  const db = require('../db');
  db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
    if (err) return res.status(500).json({ error: 'Database error' });
    if (!results.length) return res.status(404).json({ error: 'No user found with this email' });
    // For demo: return password_hash (not the real password, but for demo)
    // In real apps, you would send a reset link instead!
    return res.json({ password: results[0].password_hash });
  });
};


exports.logout = (req, res) => {
  // For now, just return success (client-side will handle session cleanup)
  res.json({ message: 'Logout successful' });
}; 