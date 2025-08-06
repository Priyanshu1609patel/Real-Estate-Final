// Global API fetch utility with environment detection and better error handling
const isLocalDevelopment = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';
const API_BASE_URL = isLocalDevelopment 
  ? 'http://localhost:3001' 
  : '/api'; // Base path for production - adjust if your API is at a different path

// Add debug info
console.log('API Configuration:', {
  isLocalDevelopment,
  API_BASE_URL,
  currentHost: window.location.hostname,
  currentProtocol: window.location.protocol
});

window.apiFetch = async function(endpoint) {
  // Ensure endpoint starts with a slash
  const normalizedEndpoint = endpoint.startsWith('/') ? endpoint : `/${endpoint}`;
  const url = isLocalDevelopment 
    ? `${API_BASE_URL}${normalizedEndpoint}`
    : `${normalizedEndpoint}`; // Relative URL for production

  console.log(`API Request: ${url}`);
  
  try {
    const response = await fetch(url, {
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-cache',
        'Pragma': 'no-cache'
      }
    });
    
    const data = await response.json().catch(() => ({}));
    
    if (!response.ok) {
      const errorMessage = data.message || response.statusText || 'Unknown error';
      console.error(`API Error (${response.status}):`, errorMessage, data);
      throw new Error(`API request failed: ${errorMessage}`);
    }
    
    return data;
  } catch (error) {
    console.error('API Fetch Error:', {
      endpoint,
      error: error.message,
      stack: error.stack
    });
    throw error;
  }
};

// Test the API connection on load
async function testApiConnection() {
  try {
    console.log('Testing API connection...');
    const data = await apiFetch('/health');
    console.log('API Connection successful:', data);
    return true;
  } catch (error) {
    console.error('API Connection test failed:', error);
    return false;
  }
}

// Run connection test in development or when explicitly enabled
if (isLocalDevelopment || window.enableApiDebug) {
  testApiConnection()
    .then(success => {
      if (success) {
        console.log('API connection test completed successfully');
      } else {
        console.warn('API connection test completed with warnings');
      }
    })
    .catch(err => {
      console.error('API connection test failed:', err);
    });
}
