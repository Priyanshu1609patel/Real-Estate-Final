// Import configuration
import { API_BASE } from './config.js';

// --- Dashboard rendering ---
function renderDashboard() {
  const dashboard = document.getElementById('dashboard');
  dashboard.innerHTML = `
    <div style="position:relative;z-index:1;">
      <h1 style="font-size:2.2rem;font-weight:800;margin-bottom:2.5rem;letter-spacing:0.5px;color:var(--primary-color);position:relative;display:inline-block;">
        <span style="position:relative;z-index:1;">Dashboard Overview</span>
        <span style="position:absolute;bottom:-5px;left:0;width:60%;height:8px;background:rgba(245,158,11,0.2);z-index:0;border-radius:var(--radius-md);"></span>
      </h1>
      <div id="dashboard-cards" style="display:flex;gap:1.5rem;flex-wrap:wrap;margin-bottom:3rem;position:relative;"></div>
      <div style="display:flex;flex-wrap:wrap;gap:2rem;justify-content:center;margin-bottom:3rem;">
        <div style="flex:1 1 320px;max-width:420px;background:var(--bg-primary);padding:2rem 1.5rem;border-radius:var(--radius-lg);box-shadow:var(--shadow-lg);transition:all 0.3s ease;position:relative;overflow:hidden;border:1px solid var(--border-light);">
          <div style="position:absolute;top:-30px;right:-30px;width:150px;height:150px;background:rgba(37,99,235,0.05);border-radius:50%;"></div>
          <h3 style='margin-top:0;color:var(--text-primary);font-size:1.2rem;font-weight:700;margin-bottom:1.5rem;display:flex;align-items:center;gap:0.7rem;'>
            <i class="fas fa-chart-pie" style="color:var(--primary-color);background:rgba(37,99,235,0.1);padding:0.7rem;border-radius:50%;"></i>
            Properties by Status
          </h3>
          <canvas id="dashboard-status-chart" width="180" height="180"></canvas>
        </div>
      </div>
    </div>`;

  // Card data
  const cardData = [
    { icon: 'fa-building', bg: 'linear-gradient(135deg, var(--primary-color) 60%, #93c5fd 100%)', color: 'white' },
    { icon: 'fa-user-tie', bg: 'linear-gradient(135deg, var(--secondary-color) 60%, #a7f3d0 100%)', color: 'white' },
    { icon: 'fa-map-marker-alt', bg: 'linear-gradient(135deg, var(--accent-color) 60%, #fef3c7 100%)', color: 'white' },
    { icon: 'fa-star', bg: 'linear-gradient(135deg, #ef4444 60%, #fca5a5 100%)', color: 'white' },
    { icon: 'fa-cubes', bg: 'linear-gradient(135deg, #8b5cf6 60%, #ddd6fe 100%)', color: 'white' },
    { icon: 'fa-exclamation-triangle', bg: 'linear-gradient(135deg, #0ea5e9 60%, #bae6fd 100%)', color: 'white' }
  ];

  // Fetch stats
  Promise.all([
    fetch(`${API_BASE}properties`).then(handleResponse),
    fetch(`${API_BASE}developers`).then(handleResponse),
    fetch(`${API_BASE}locations`).then(handleResponse),
    fetch(`${API_BASE}reviews`).then(handleResponse),
    fetch(`${API_BASE}amenities`).then(handleResponse),
    fetch(`${API_BASE}challenges`).then(handleResponse)
  ]).then(([properties, developers, locations, reviews, amenities, challenges]) => {
    // Update dashboard cards
    const cards = [
      { label: 'Total Properties', value: properties.length, color: 'var(--primary-color)' },
      { label: 'Total Developers', value: developers.length, color: 'var(--secondary-color)' },
      { label: 'Locations', value: locations.length, color: 'var(--accent-color)' },
      { label: 'Reviews', value: reviews.length, color: '#ef4444' },
      { label: 'Amenities', value: amenities.length, color: '#8b5cf6' },
      { label: 'Challenges', value: challenges.length, color: '#0ea5e9' }
    ];

    const cardsContainer = document.getElementById('dashboard-cards');
    cardsContainer.innerHTML = cards.map((card, index) => `
      <div class="dashboard-card" style="flex:1 1 200px;min-width:200px;background:white;padding:1.5rem;border-radius:var(--radius-lg);box-shadow:var(--shadow-sm);transition:all 0.3s ease;border:1px solid var(--border-light);">
        <div style="display:flex;align-items:center;margin-bottom:1rem;">
          <div class="icon-container" style="width:50px;height:50px;border-radius:12px;display:flex;align-items:center;justify-content:center;margin-right:1rem;${cardData[index].bg}">
            <i class="fas ${cardData[index].icon}" style="color:${cardData[index].color};font-size:1.2rem;"></i>
          </div>
          <div>
            <div style="font-size:0.9rem;color:var(--text-secondary);">${card.label}</div>
            <div style="font-size:1.8rem;font-weight:700;color:${card.color};">${card.value}</div>
          </div>
        </div>
      </div>
    `).join('');

    // Render charts
    renderCharts(properties, developers, locations, reviews);
  }).catch(error => {
    console.error('Error loading dashboard data:', error);
    showError('Failed to load dashboard data. Please try again.');
  });
}

// Helper function to handle API responses
async function handleResponse(response) {
  if (!response.ok) {
    const error = await response.text();
    throw new Error(error || 'Failed to fetch data');
  }
  return response.json();
}

// Error handling
function showError(message) {
  const errorDiv = document.createElement('div');
  errorDiv.className = 'error-message';
  errorDiv.style = 'background:#fee2e2;color:#dc2626;padding:1rem;border-radius:var(--radius-md);margin-bottom:1.5rem;';
  errorDiv.innerHTML = `
    <div style="display:flex;align-items:center;gap:0.5rem;">
      <i class="fas fa-exclamation-circle"></i>
      <span>${message}</span>
    </div>
  `;
  document.getElementById('dashboard').prepend(errorDiv);
}

// Initialize dashboard when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  renderDashboard();
});

// Export for testing
if (typeof module !== 'undefined' && module.exports) {
  module.exports = { renderDashboard, handleResponse };
}
