// Global API fetch utility with environment detection
const isLocalDevelopment = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';
const BASE_URL = isLocalDevelopment 
  ? 'http://localhost:3001' 
  : ''; // Empty string means relative URLs will work in production

window.apiFetch = async function(endpoint) {
  try {
    const response = await fetch(`${BASE_URL}${endpoint}`, {
      credentials: 'include', // Include cookies for authentication if needed
      headers: {
        'Content-Type': 'application/json',
      },
    });
    
    if (!response.ok) {
      const error = await response.text();
      throw new Error(`API request failed: ${error}`);
    }
    
    return await response.json();
  } catch (error) {
    console.error('API Fetch Error:', error);
    throw error; // Re-throw to allow error handling by the caller
  }
};

// Example usage: Fetch and log properties (for debugging)
if (isLocalDevelopment) {
  apiFetch('/api/properties/full')
    .then(data => console.log('Properties loaded:', data.length, 'items'))
    .catch(err => console.error('Failed to load properties:', err));
}
