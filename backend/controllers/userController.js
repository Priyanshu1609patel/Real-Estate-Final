const User = require('../models/user');
const bcrypt = require('bcryptjs');

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
  User.findByUsernameOrEmail(username, async (err, user) => {
    if (err || !user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    const match = await bcrypt.compare(password, user.password_hash);
    if (!match) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    // For now, just return success (no JWT/session)
    res.json({ message: 'Login successful', user: { id: user.id, username: user.username, email: user.email } });
  });
};

exports.logout = (req, res) => {
  // For now, just return success (client-side will handle session cleanup)
  res.json({ message: 'Logout successful' });
}; 