// Global API fetch utility for Railway backend
const BASE_URL = 'https://real-estate-final-production.up.railway.app';

window.apiFetch = async function(endpoint) {
  const res = await fetch(`${BASE_URL}${endpoint}`);
  return res.json();
};

// Example usage: Fetch and log users, properties, developers
apiFetch('/api/users').then(data => console.log('Users:', data));
apiFetch('/api/properties').then(data => console.log('Properties:', data));
apiFetch('/api/developers').then(data => console.log('Developers:', data));
