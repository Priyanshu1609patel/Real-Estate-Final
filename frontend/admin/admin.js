// --- Dashboard rendering ---
function renderDashboard() {
  const dashboard = document.getElementById('dashboard');
  dashboard.innerHTML = `
    <h1 style="font-size:2.2rem;font-weight:800;margin-bottom:1.5rem;letter-spacing:1px;color:#1a237e;">Dashboard</h1>
    <div id="dashboard-cards" style="display:flex;gap:2rem;flex-wrap:wrap;margin-bottom:2rem;"></div>
    <div style="display:flex;flex-wrap:wrap;gap:2rem;justify-content:center;">
      <div style="flex:1 1 320px;max-width:420px;background:#fff;padding:1.5rem 1rem;border-radius:16px;box-shadow:0 2px 12px rgba(0,0,0,0.08);">
        <h3 style='margin-top:0;'>Properties by Status</h3>
        <canvas id="dashboard-status-chart" width="180" height="180"></canvas>
      </div>
      <div style="flex:1 1 320px;max-width:420px;background:#fff;padding:1.5rem 1rem;border-radius:16px;box-shadow:0 2px 12px rgba(0,0,0,0.08);">
        <h3 style='margin-top:0;'>Top 5 Locations by Properties</h3>
        <canvas id="dashboard-location-chart"></canvas>
      </div>
      <div style="flex:1 1 320px;max-width:420px;background:#fff;padding:1.5rem 1rem;border-radius:16px;box-shadow:0 2px 12px rgba(0,0,0,0.08);">
        <h3 style='margin-top:0;'>Amenities by Category</h3>
        <canvas id="dashboard-amenity-chart"></canvas>
      </div>
    </div>
    <div style="margin-top:2.5rem;">
      <h2 style='color:#1a237e;font-size:1.5rem;font-weight:700;'>Recent Activity</h2>
      <div id="dashboard-recent" style="display:flex;gap:2rem;flex-wrap:wrap;"></div>
    </div>
  `;

  // Icon map for cards
  const iconMap = [
    { icon: 'fa-building', bg: 'linear-gradient(135deg,#1976d2 60%,#64b5f6 100%)', color: '#fff' },
    { icon: 'fa-user-tie', bg: 'linear-gradient(135deg,#43a047 60%,#a5d6a7 100%)', color: '#fff' },
    { icon: 'fa-map-marker-alt', bg: 'linear-gradient(135deg,#fbc02d 60%,#fff176 100%)', color: '#fff' },
    { icon: 'fa-star', bg: 'linear-gradient(135deg,#e53935 60%,#ffb74d 100%)', color: '#fff' },
    { icon: 'fa-cubes', bg: 'linear-gradient(135deg,#8e24aa 60%,#ce93d8 100%)', color: '#fff' },
    { icon: 'fa-exclamation-triangle', bg: 'linear-gradient(135deg,#00838f 60%,#4dd0e1 100%)', color: '#fff' }
  ];

  // Fetch stats
  Promise.all([
    fetch('http://localhost:3001/api/properties').then(r => r.json()),
    fetch('http://localhost:3001/api/developers').then(r => r.json()),
    fetch('http://localhost:3001/api/locations').then(r => r.json()),
    fetch('http://localhost:3001/api/reviews').then(r => r.json()),
    fetch('http://localhost:3001/api/amenities').then(r => r.json()),
    fetch('http://localhost:3001/api/challenges').then(r => r.json())
  ]).then(([properties, developers, locations, reviews, amenities, challenges]) => {
    // Cards
    const cards = [
      { label: 'Total Properties', value: properties.length, color: '#1976d2' },
      { label: 'Total Developers', value: developers.length, color: '#43a047' },
      { label: 'Total Locations', value: locations.length, color: '#fbc02d' },
      { label: 'Total Reviews', value: reviews.length, color: '#e53935' },
      { label: 'Total Amenities', value: amenities.length, color: '#8e24aa' },
      { label: 'Total Challenges', value: challenges.length, color: '#00838f' }
    ];
    document.getElementById('dashboard-cards').innerHTML = cards.map((card, i) => `
      <div style="background:#fff;padding:2rem 2.5rem;border-radius:18px;box-shadow:0 4px 24px rgba(25,118,210,0.10);min-width:180px;text-align:center;flex:1 1 180px;position:relative;overflow:hidden;transition:box-shadow 0.2s;cursor:pointer;">
        <div style="position:absolute;top:-30px;right:-30px;width:80px;height:80px;z-index:0;opacity:0.13;background:${iconMap[i].bg};border-radius:50%;"></div>
        <div style="display:flex;justify-content:center;align-items:center;margin-bottom:0.7rem;z-index:1;position:relative;">
          <span class="fa-solid ${iconMap[i].icon}" style="font-size:2.5rem;background:${iconMap[i].bg};color:${iconMap[i].color};padding:0.7rem 0.9rem;border-radius:50%;box-shadow:0 2px 8px rgba(0,0,0,0.08);"></span>
        </div>
        <div style="font-size:2.2rem;font-weight:800;color:${card.color};margin-bottom:0.5rem;z-index:1;position:relative;">${card.value}</div>
        <div style="font-size:1.1rem;color:#222;font-weight:600;z-index:1;position:relative;">${card.label}</div>
      </div>
    `).join('');

    // Chart: Properties by Status
    const statusMap = {};
    properties.forEach(p => {
      const status = p.status || 'Unknown';
      statusMap[status] = (statusMap[status] || 0) + 1;
    });
    const statusLabels = Object.keys(statusMap);
    const statusData = Object.values(statusMap);
    if (window.dashboardStatusChart) window.dashboardStatusChart.destroy();
    const statusCtx = document.getElementById('dashboard-status-chart').getContext('2d');
    window.dashboardStatusChart = new Chart(statusCtx, {
      type: 'pie',
      data: {
        labels: statusLabels,
        datasets: [{
          data: statusData,
          backgroundColor: ['#1976d2','#43a047','#fbc02d','#e53935','#8e24aa','#00838f','#757575']
        }]
      },
      options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
    });

    // Chart: Top 5 Locations by Properties
    const locMap = {};
    properties.forEach(p => {
      const loc = locations.find(l => l.id === p.location_id);
      const locName = loc ? loc.area_name : 'Unknown';
      locMap[locName] = (locMap[locName] || 0) + 1;
    });
    const topLocs = Object.entries(locMap).sort((a,b) => b[1]-a[1]).slice(0,5);
    const locLabels = topLocs.map(([name]) => name);
    const locData = topLocs.map(([_,count]) => count);
    if (window.dashboardLocationChart) window.dashboardLocationChart.destroy();
    const locCtx = document.getElementById('dashboard-location-chart').getContext('2d');
    window.dashboardLocationChart = new Chart(locCtx, {
      type: 'bar',
      data: {
        labels: locLabels,
        datasets: [{
          label: 'Properties',
          data: locData,
          backgroundColor: '#1976d2',
        }]
      },
      options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { precision:0 } } } }
    });

    // Chart: Amenities by Category
    const catMap = {};
    amenities.forEach(a => {
      const cat = a.category || 'Other';
      catMap[cat] = (catMap[cat] || 0) + 1;
    });
    const catLabels = Object.keys(catMap);
    const catData = Object.values(catMap);
    if (window.dashboardAmenityChart) window.dashboardAmenityChart.destroy();
    const catCtx = document.getElementById('dashboard-amenity-chart').getContext('2d');
    window.dashboardAmenityChart = new Chart(catCtx, {
      type: 'doughnut',
      data: {
        labels: catLabels,
        datasets: [{
          data: catData,
          backgroundColor: ['#1976d2','#43a047','#fbc02d','#e53935','#8e24aa','#00838f','#757575']
        }]
      },
      options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
    });

    // Recent Activity
    const recentProps = properties.slice(-5).reverse();
    const recentRevs = reviews.slice(-5).reverse();
    document.getElementById('dashboard-recent').innerHTML = `
      <div style='flex:1 1 420px;min-width:320px;margin-right:0.1rem;'>
        <h4 style="margin-bottom:0.7em;font-size:1.13rem;color:#182848;font-weight:700;">Recent Properties</h4>
        <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(24,40,72,0.07);overflow:hidden;">
          <thead>
            <tr style="background:#e8eaf6;color:#182848;font-weight:700;">
              <th style="padding:0.7em 0.5em;text-align:left;">Name</th>
              <th style="padding:0.7em 0.5em;text-align:left;">Status</th>
            </tr>
          </thead>
          <tbody>
            ${recentProps.map(p => `
              <tr>
                <td style="padding:0.6em 0.5em;border-bottom:1px solid #e0e0e0;">${p.name || 'Property #' + p.id}</td>
                <td style="padding:0.6em 0.5em;border-bottom:1px solid #e0e0e0;">${p.status || 'Unknown'}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
        </div>
      </div>
      <div style='flex:1 1 420px;min-width:320px;margin-left:0.1rem;'>
        <h4 style="margin-bottom:0.7em;font-size:1.13rem;color:#182848;font-weight:700;">Recent Reviews</h4>
        <div style="overflow-x:auto;">
        <table style="width:100%;border-collapse:collapse;background:#fff;border-radius:12px;box-shadow:0 2px 8px rgba(24,40,72,0.07);overflow:hidden;">
          <thead>
            <tr style="background:#e8eaf6;color:#182848;font-weight:700;">
              <th style="padding:0.7em 0.5em;text-align:left;">Reviewer</th>
              <th style="padding:0.7em 0.5em;text-align:left;">Review</th>
            </tr>
          </thead>
          <tbody>
            ${recentRevs.map(r => `
              <tr>
                <td style="padding:0.6em 0.5em;border-bottom:1px solid #e0e0e0;">${r.reviewer_name}</td>
                <td style="padding:0.6em 0.5em;border-bottom:1px solid #e0e0e0;">${r.review_text.slice(0,60)}${r.review_text.length>60?'...':''}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
        </div>
      </div>
    `;
  });
}

// --- Sidebar Navigation ---
const navLinks = document.querySelectorAll('.sidebar nav ul li a');
const sections = document.querySelectorAll('.admin-section');
navLinks.forEach(link => {
  link.addEventListener('click', e => {
    e.preventDefault();
    navLinks.forEach(l => l.classList.remove('active'));
    link.classList.add('active');
    sections.forEach(sec => sec.classList.remove('active'));
    document.getElementById(link.dataset.section).classList.add('active');
    if (link.dataset.section === 'dashboard') renderDashboard();
  });
});

// Render dashboard by default
if (document.getElementById('dashboard')) renderDashboard();

// --- Table Configurations ---
const TABLES = [
  // Developers
  {
    id: 'developers',
    api: 'developers',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'name', label: 'Name' },
      { key: 'established_year', label: 'Year' },
      { key: 'completed_projects', label: 'Projects' },
      { key: 'total_sqft_delivered', label: 'Sqft Delivered' },
      { key: 'specialization', label: 'Specialization' },
      { key: 'website_url', label: 'Website' }
    ],
    form: [
      { key: 'name', label: 'Name', type: 'text' },
      { key: 'established_year', label: 'Year', type: 'number' },
      { key: 'completed_projects', label: 'Projects', type: 'number' },
      { key: 'total_sqft_delivered', label: 'Sqft Delivered', type: 'text' },
      { key: 'description', label: 'Description', type: 'text' },
      { key: 'specialization', label: 'Specialization', type: 'text' },
      { key: 'website_url', label: 'Website', type: 'text' }
    ]
  },
  // Locations
  {
    id: 'locations',
    api: 'locations',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'area_name', label: 'Area Name' },
      { key: 'city', label: 'City' },
      { key: 'state', label: 'State' },
      { key: 'pincode', label: 'Pincode' },
      { key: 'market_average_price_per_sqft', label: 'Avg Price/Sqft' },
      { key: 'market_average_clubhouse_factor', label: 'Clubhouse Factor' }
    ],
    form: [
      { key: 'area_name', label: 'Area Name', type: 'text' },
      { key: 'city', label: 'City', type: 'text' },
      { key: 'state', label: 'State', type: 'text' },
      { key: 'pincode', label: 'Pincode', type: 'text' },
      { key: 'description', label: 'Description', type: 'text' },
      { key: 'market_average_price_per_sqft', label: 'Avg Price/Sqft', type: 'number' },
      { key: 'market_average_clubhouse_factor', label: 'Clubhouse Factor', type: 'number' },
      { key: 'coordinates_lat', label: 'Latitude', type: 'number' },
      { key: 'coordinates_lng', label: 'Longitude', type: 'number' }
    ]
  },
  // Properties
  {
    id: 'properties',
    api: 'properties',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'name', label: 'Name' },
      { key: 'developer_id', label: 'Developer ID' },
      { key: 'location_id', label: 'Location ID' },
      { key: 'property_type', label: 'Type' },
      { key: 'land_area_acres', label: 'Land Area (Acres)' },
      { key: 'total_units', label: 'Total Units' },
      { key: 'status', label: 'Status' }
    ],
    form: [
      { key: 'name', label: 'Name', type: 'text' },
      { key: 'developer_id', label: 'Developer ID', type: 'number' },
      { key: 'location_id', label: 'Location ID', type: 'number' },
      { key: 'property_type', label: 'Type', type: 'text' },
      { key: 'land_area_acres', label: 'Land Area (Acres)', type: 'number' },
      { key: 'land_area_sqft', label: 'Land Area (Sqft)', type: 'number' },
      { key: 'total_units', label: 'Total Units', type: 'number' },
      { key: 'total_towers', label: 'Towers', type: 'number' },
      { key: 'floors_per_tower', label: 'Floors/Tower', type: 'number' },
      { key: 'open_area_percentage', label: 'Open Area (%)', type: 'number' },
      { key: 'clubhouse_area_sqft', label: 'Clubhouse Area', type: 'number' },
      { key: 'clubhouse_factor', label: 'Clubhouse Factor', type: 'number' },
      { key: 'park_area_acres', label: 'Park Area (Acres)', type: 'number' },
      { key: 'unit_density_per_acre', label: 'Unit Density/Acre', type: 'number' },
      { key: 'closest_metro_distance_km', label: 'Metro Distance (km)', type: 'number' },
      { key: 'airport_distance_km', label: 'Airport Distance (km)', type: 'number' },
      { key: 'approach_road_width_meters', label: 'Road Width (m)', type: 'number' },
      { key: 'possession_date', label: 'Possession Date', type: 'date' },
      { key: 'rera_approved', label: 'RERA Approved', type: 'text' },
      { key: 'rera_registration_number', label: 'RERA Reg. No.', type: 'text' },
      { key: 'rera_approvals_count', label: 'RERA Approvals', type: 'number' },
      { key: 'total_rera_approvals', label: 'Total RERA Approvals', type: 'number' },
      { key: 'price_per_sqft', label: 'Price/Sqft', type: 'number' },
      { key: 'min_price', label: 'Min Price', type: 'number' },
      { key: 'max_price', label: 'Max Price', type: 'number' },
      { key: 'min_unit_size_sqft', label: 'Min Unit Size', type: 'number' },
      { key: 'max_unit_size_sqft', label: 'Max Unit Size', type: 'number' },
      { key: 'status', label: 'Status', type: 'text' },
      { key: 'propsoch_id', label: 'Propsoch ID', type: 'number' },
      { key: 'project_highlights', label: 'Highlights', type: 'text' },
      { key: 'description', label: 'Description', type: 'text' }
    ]
  },
  // Unit Types
  {
    id: 'unit-types',
    api: 'unit_types',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'bhk_type', label: 'BHK Type' },
      { key: 'configuration_name', label: 'Config Name' },
      { key: 'area_sqft', label: 'Area (Sqft)' },
      { key: 'price', label: 'Price' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'bhk_type', label: 'BHK Type', type: 'text' },
      { key: 'configuration_name', label: 'Config Name', type: 'text' },
      { key: 'area_sqft', label: 'Area (Sqft)', type: 'number' },
      { key: 'price', label: 'Price', type: 'number' },
      { key: 'carpet_area_sqft', label: 'Carpet Area', type: 'number' },
      { key: 'carpet_area_percentage', label: 'Carpet %', type: 'number' },
      { key: 'balcony_area_sqft', label: 'Balcony Area', type: 'number' },
      { key: 'ceiling_height_meters', label: 'Ceiling Height', type: 'number' },
      { key: 'bedrooms', label: 'Bedrooms', type: 'number' },
      { key: 'bathrooms', label: 'Bathrooms', type: 'number' },
      { key: 'unit_count', label: 'Unit Count', type: 'number' },
      { key: 'floor_count', label: 'Floor Count', type: 'number' },
      { key: 'price_per_sqft', label: 'Price/Sqft', type: 'number' },
      { key: 'configuration_details', label: 'Config Details', type: 'text' }
    ]
  },
  // Room Details
  {
    id: 'room-details',
    api: 'room_details',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'unit_type_id', label: 'Unit Type ID' },
      { key: 'room_type', label: 'Room Type' },
      { key: 'length_ft', label: 'Length (ft)' },
      { key: 'breadth_ft', label: 'Breadth (ft)' },
      { key: 'area_sqft', label: 'Area (sqft)' },
      { key: 'room_category', label: 'Category' }
    ],
    form: [
      { key: 'unit_type_id', label: 'Unit Type ID', type: 'number' },
      { key: 'room_type', label: 'Room Type', type: 'text' },
      { key: 'length_ft', label: 'Length (ft)', type: 'number' },
      { key: 'breadth_ft', label: 'Breadth (ft)', type: 'number' },
      { key: 'area_sqft', label: 'Area (sqft)', type: 'number' },
      { key: 'room_category', label: 'Category', type: 'text' },
      { key: 'room_description', label: 'Description', type: 'text' }
    ]
  },
  // Unit Specifications
  {
    id: 'unit-specifications',
    api: 'unit_specifications',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'unit_type_id', label: 'Unit Type ID' },
      { key: 'efficiency_percentage', label: 'Efficiency %' },
      { key: 'most_misused_bedrooms', label: 'Misused Bedrooms' },
      { key: 'balcony_area_ratio', label: 'Balcony Ratio' },
      { key: 'common_walls_count', label: 'Common Walls' },
      { key: 'floor_height_meters', label: 'Floor Height' }
    ],
    form: [
      { key: 'unit_type_id', label: 'Unit Type ID', type: 'number' },
      { key: 'efficiency_percentage', label: 'Efficiency %', type: 'number' },
      { key: 'most_misused_bedrooms', label: 'Misused Bedrooms', type: 'text' },
      { key: 'balcony_area_ratio', label: 'Balcony Ratio', type: 'number' },
      { key: 'common_walls_count', label: 'Common Walls', type: 'number' },
      { key: 'common_walls_percentage', label: 'Common Walls %', type: 'number' },
      { key: 'floor_height_meters', label: 'Floor Height', type: 'number' },
      { key: 'carpet_area_average_price', label: 'Carpet Avg Price', type: 'number' },
      { key: 'elevator_count', label: 'Elevators', type: 'number' },
      { key: 'elevator_ratio', label: 'Elevator Ratio', type: 'text' },
      { key: 'typologies', label: 'Typologies', type: 'text' },
      { key: 'vastu_compliant', label: 'Vastu', type: 'text' },
      { key: 'ventilation_rating', label: 'Ventilation', type: 'text' },
      { key: 'natural_light_rating', label: 'Natural Light', type: 'text' }
    ]
  },
  // Amenities
  {
    id: 'amenities',
    api: 'amenities',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'name', label: 'Name' },
      { key: 'category', label: 'Category' },
      { key: 'rarity', label: 'Rarity' },
      { key: 'description', label: 'Description' }
    ],
    form: [
      { key: 'name', label: 'Name', type: 'text' },
      { key: 'category', label: 'Category', type: 'text' },
      { key: 'rarity', label: 'Rarity', type: 'text' },
      { key: 'description', label: 'Description', type: 'text' }
    ]
  },
  // Property Amenities
  {
    id: 'property-amenities',
    api: 'property_amenities',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'amenity_id', label: 'Amenity ID' },
      { key: 'available', label: 'Available' },
      { key: 'area_sqft', label: 'Area Sqft' },
      { key: 'capacity', label: 'Capacity' },
      { key: 'location_within_property', label: 'Location' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'amenity_id', label: 'Amenity ID', type: 'number' },
      { key: 'available', label: 'Available', type: 'text' },
      { key: 'area_sqft', label: 'Area Sqft', type: 'number' },
      { key: 'capacity', label: 'Capacity', type: 'number' },
      { key: 'location_within_property', label: 'Location', type: 'text' }
    ]
  },
  // Challenges
  {
    id: 'challenges',
    api: 'challenges',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'name', label: 'Name' },
      { key: 'category', label: 'Category' },
      { key: 'description', label: 'Description' },
      { key: 'severity', label: 'Severity' }
    ],
    form: [
      { key: 'name', label: 'Name', type: 'text' },
      { key: 'category', label: 'Category', type: 'text' },
      { key: 'description', label: 'Description', type: 'text' },
      { key: 'severity', label: 'Severity', type: 'text' }
    ]
  },
  // Property Challenges
  {
    id: 'property-challenges',
    api: 'property_challenges',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'challenge_id', label: 'Challenge ID' },
      { key: 'impact_level', label: 'Impact Level' },
      { key: 'notes', label: 'Notes' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'challenge_id', label: 'Challenge ID', type: 'number' },
      { key: 'impact_level', label: 'Impact Level', type: 'text' },
      { key: 'notes', label: 'Notes', type: 'text' }
    ]
  },
  // Property Connectivity
  {
    id: 'property-connectivity',
    api: 'property_connectivity',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'landmark_type', label: 'Landmark Type' },
      { key: 'landmark_name', label: 'Landmark Name' },
      { key: 'distance_km', label: 'Distance (km)' },
      { key: 'travel_time_minutes', label: 'Travel Time (min)' },
      { key: 'transport_mode', label: 'Mode' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'landmark_type', label: 'Landmark Type', type: 'text' },
      { key: 'landmark_name', label: 'Landmark Name', type: 'text' },
      { key: 'distance_km', label: 'Distance (km)', type: 'number' },
      { key: 'travel_time_minutes', label: 'Travel Time (min)', type: 'number' },
      { key: 'transport_mode', label: 'Mode', type: 'text' }
    ]
  },
  // Property Gallery
  {
    id: 'property-gallery',
    api: 'property_gallery',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'image_type', label: 'Type' },
      { key: 'image_title', label: 'Title' },
      { key: 'image_url', label: 'Image URL' },
      { key: 'image_description', label: 'Description' },
      { key: 'display_order', label: 'Order' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'image_type', label: 'Type', type: 'text' },
      { key: 'image_title', label: 'Title', type: 'text' },
      { key: 'image_url', label: 'Image URL', type: 'text' },
      { key: 'image_description', label: 'Description', type: 'text' },
      { key: 'display_order', label: 'Order', type: 'number' }
    ]
  },
  // Property Documents
  {
    id: 'property-documents',
    api: 'property_documents',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'document_type', label: 'Type' },
      { key: 'document_name', label: 'Name' },
      { key: 'document_url', label: 'URL' },
      { key: 'upload_date', label: 'Upload Date' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'document_type', label: 'Type', type: 'text' },
      { key: 'document_name', label: 'Name', type: 'text' },
      { key: 'document_url', label: 'URL', type: 'text' },
      { key: 'upload_date', label: 'Upload Date', type: 'date' }
    ]
  },
  // Timeline
  {
    id: 'timeline',
    api: 'timeline',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'phase', label: 'Phase' },
      { key: 'start_date', label: 'Start Date' },
      { key: 'end_date', label: 'End Date' },
      { key: 'completion_percentage', label: 'Completion %' },
      { key: 'status', label: 'Status' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'phase', label: 'Phase', type: 'text' },
      { key: 'start_date', label: 'Start Date', type: 'date' },
      { key: 'end_date', label: 'End Date', type: 'date' },
      { key: 'completion_percentage', label: 'Completion %', type: 'number' },
      { key: 'status', label: 'Status', type: 'text' },
      { key: 'milestone_description', label: 'Milestone', type: 'text' }
    ]
  },
  // Financial Details
  {
    id: 'financial-details',
    api: 'financial_details',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'base_price_per_sqft', label: 'Base Price/Sqft' },
      { key: 'premium_charges_per_sqft', label: 'Premium/Sqft' },
      { key: 'total_charges_per_sqft', label: 'Total/Sqft' },
      { key: 'registration_percentage', label: 'Reg. %' },
      { key: 'gst_percentage', label: 'GST %' },
      { key: 'maintenance_per_sqft', label: 'Maint/Sqft' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'base_price_per_sqft', label: 'Base Price/Sqft', type: 'number' },
      { key: 'premium_charges_per_sqft', label: 'Premium/Sqft', type: 'number' },
      { key: 'total_charges_per_sqft', label: 'Total/Sqft', type: 'number' },
      { key: 'registration_percentage', label: 'Reg. %', type: 'number' },
      { key: 'gst_percentage', label: 'GST %', type: 'number' },
      { key: 'maintenance_per_sqft', label: 'Maint/Sqft', type: 'number' },
      { key: 'corpus_fund_per_sqft', label: 'Corpus/Sqft', type: 'number' },
      { key: 'parking_charges', label: 'Parking', type: 'number' },
      { key: 'total_other_charges', label: 'Other Charges', type: 'number' },
      { key: 'loan_eligibility_percentage', label: 'Loan %', type: 'number' },
      { key: 'preferred_banks', label: 'Banks', type: 'text' },
      { key: 'emi_example_tenure', label: 'EMI Tenure', type: 'number' },
      { key: 'emi_example_amount', label: 'EMI Amount', type: 'number' },
      { key: 'roi_potential_percentage', label: 'ROI %', type: 'number' },
      { key: 'rental_yield_percentage', label: 'Rental Yield %', type: 'number' }
    ]
  },
  // Market Analysis
  {
    id: 'market-analysis',
    api: 'market_analysis',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'current_avg_price_per_sqft', label: 'Avg Price/Sqft' },
      { key: 'price_appreciation_1year', label: '1Y Appreciation' },
      { key: 'price_appreciation_3year', label: '3Y Appreciation' },
      { key: 'price_appreciation_5year', label: '5Y Appreciation' },
      { key: 'demand_supply_ratio', label: 'Demand/Supply' },
      { key: 'market_segment', label: 'Segment' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'current_avg_price_per_sqft', label: 'Avg Price/Sqft', type: 'number' },
      { key: 'price_appreciation_1year', label: '1Y Appreciation', type: 'number' },
      { key: 'price_appreciation_3year', label: '3Y Appreciation', type: 'number' },
      { key: 'price_appreciation_5year', label: '5Y Appreciation', type: 'number' },
      { key: 'demand_supply_ratio', label: 'Demand/Supply', type: 'number' },
      { key: 'inventory_months', label: 'Inventory Months', type: 'number' },
      { key: 'similar_properties_count', label: 'Similar Properties', type: 'number' },
      { key: 'market_segment', label: 'Segment', type: 'text' },
      { key: 'buyer_profile', label: 'Buyer Profile', type: 'text' },
      { key: 'resale_potential', label: 'Resale', type: 'text' },
      { key: 'rental_demand', label: 'Rental Demand', type: 'text' }
    ]
  },
  // Reviews
  {
    id: 'reviews',
    api: 'reviews',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'reviewer_name', label: 'Reviewer' },
      { key: 'rating', label: 'Rating' },
      { key: 'review_text', label: 'Review' },
      { key: 'review_date', label: 'Date' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'reviewer_name', label: 'Reviewer', type: 'text' },
      { key: 'rating', label: 'Rating', type: 'number' },
      { key: 'review_text', label: 'Review', type: 'text' },
      { key: 'pros', label: 'Pros', type: 'text' },
      { key: 'cons', label: 'Cons', type: 'text' },
      { key: 'recommendation', label: 'Recommendation', type: 'text' },
      { key: 'purchase_status', label: 'Purchase Status', type: 'text' },
      { key: 'review_date', label: 'Date', type: 'date' },
      { key: 'is_verified', label: 'Verified', type: 'text' }
    ]
  },
  // Legal Details
  {
    id: 'legal-details',
    api: 'legal_details',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'rera_registration', label: 'RERA Reg.' },
      { key: 'commencement_certificate', label: 'Commencement Cert.' },
      { key: 'occupancy_certificate', label: 'Occupancy Cert.' },
      { key: 'approved_plan', label: 'Approved Plan' },
      { key: 'compliance_status', label: 'Compliance' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'rera_registration', label: 'RERA Reg.', type: 'text' },
      { key: 'commencement_certificate', label: 'Commencement Cert.', type: 'text' },
      { key: 'occupancy_certificate', label: 'Occupancy Cert.', type: 'text' },
      { key: 'approved_plan', label: 'Approved Plan', type: 'text' },
      { key: 'deviation_status', label: 'Deviation', type: 'text' },
      { key: 'litigation_status', label: 'Litigation', type: 'text' },
      { key: 'title_verification', label: 'Title Verification', type: 'text' },
      { key: 'bank_approvals', label: 'Bank Approvals', type: 'text' },
      { key: 'insurance_coverage', label: 'Insurance', type: 'text' },
      { key: 'compliance_status', label: 'Compliance', type: 'text' },
      { key: 'legal_opinion', label: 'Legal Opinion', type: 'text' }
    ]
  },
  // Investment Analysis
  {
    id: 'investment-analysis',
    api: 'investment_analysis',
    columns: [
      { key: 'id', label: 'ID' },
      { key: 'property_id', label: 'Property ID' },
      { key: 'investment_type', label: 'Type' },
      { key: 'entry_cost', label: 'Entry Cost' },
      { key: 'annual_rental_income', label: 'Rental Income' },
      { key: 'annual_appreciation', label: 'Appreciation' },
      { key: 'maintenance_cost', label: 'Maintenance' },
      { key: 'total_returns_5year', label: '5Y Returns' },
      { key: 'irr_percentage', label: 'IRR %' },
      { key: 'payback_period_years', label: 'Payback (Yrs)' },
      { key: 'risk_assessment', label: 'Risk' },
      { key: 'liquidity_rating', label: 'Liquidity' },
      { key: 'investment_grade', label: 'Grade' }
    ],
    form: [
      { key: 'property_id', label: 'Property ID', type: 'number' },
      { key: 'investment_type', label: 'Type', type: 'text' },
      { key: 'entry_cost', label: 'Entry Cost', type: 'number' },
      { key: 'annual_rental_income', label: 'Rental Income', type: 'number' },
      { key: 'annual_appreciation', label: 'Appreciation', type: 'number' },
      { key: 'maintenance_cost', label: 'Maintenance', type: 'number' },
      { key: 'total_returns_5year', label: '5Y Returns', type: 'number' },
      { key: 'irr_percentage', label: 'IRR %', type: 'number' },
      { key: 'payback_period_years', label: 'Payback (Yrs)', type: 'number' },
      { key: 'risk_assessment', label: 'Risk', type: 'text' },
      { key: 'liquidity_rating', label: 'Liquidity', type: 'text' },
      { key: 'tax_benefits', label: 'Tax Benefits', type: 'text' },
      { key: 'investment_grade', label: 'Grade', type: 'text' }
    ]
  }
];

const API_BASE = 'http://localhost:3001/api/';

function renderSection(table) {
  const section = document.getElementById(table.id);
  section.innerHTML = `
    <form class="admin-form" id="form-${table.id}"></form>
    <div class="table-card">
      <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:1.2rem;">
        <h3 style="margin:0;">All ${table.id.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase())}</h3>
        <div style="position:relative;">
          <input type="text" id="search-${table.id}" placeholder="Search..." style="padding:8px 14px;border-radius:6px;border:1.5px solid #d1d5db;font-size:1rem;background:#f8fafc;min-width:180px;box-shadow:0 1px 4px rgba(24,40,72,0.04);">
          <div id="reco-${table.id}" style="position:absolute;top:110%;left:0;width:100%;background:#fff;border:1px solid #e0e0e0;border-radius:0 0 8px 8px;box-shadow:0 2px 8px rgba(24,40,72,0.08);z-index:10;display:none;"></div>
        </div>
      </div>
      <table id="table-${table.id}">
        <thead><tr>${table.columns.map(col => `<th>${col.label}</th>`).join('')}<th>Actions</th></tr></thead>
        <tbody></tbody>
      </table>
    </div>
  `;
  renderForm(table);
  fetchAndRenderTableWithSearch(table);
}

function renderForm(table, editing = null) {
  const form = document.getElementById(`form-${table.id}`);
  form.innerHTML = '';
  form.style.display = 'flex';
  form.style.flexWrap = 'wrap';
  form.style.gap = '1.2em 2em';
  form.style.marginBottom = '1.5em';
  table.form.forEach(field => {
    if (field.key === 'id') return; // Never include id in the form
    const input = document.createElement('input');
    input.type = field.type;
    input.name = field.key;
    input.placeholder = field.label;
    input.style.padding = '14px 20px';
    input.style.borderRadius = '10px';
    input.style.border = '1.5px solid #b0bec5';
    input.style.fontSize = '1.09rem';
    input.style.background = 'linear-gradient(120deg,#f8fafc 60%,#e3f0ff 100%)';
    input.style.boxShadow = '0 2px 8px rgba(24,40,72,0.06)';
    input.style.marginBottom = '1.1em';
    input.style.flex = '1 1 240px';
    input.style.transition = 'border 0.2s, box-shadow 0.2s';
    input.onfocus = function() {
      input.style.border = '1.5px solid #1976d2';
      input.style.boxShadow = '0 4px 16px rgba(25,118,210,0.13)';
      input.style.background = '#fff';
    };
    input.onblur = function() {
      input.style.border = '1.5px solid #b0bec5';
      input.style.boxShadow = '0 2px 8px rgba(24,40,72,0.06)';
      input.style.background = 'linear-gradient(120deg,#f8fafc 60%,#e3f0ff 100%)';
    };
    if (editing) input.value = editing[field.key] || '';
    form.appendChild(input);
  });
  if (editing) {
    const saveBtn = document.createElement('button');
    saveBtn.type = 'submit';
    saveBtn.textContent = 'Update';
    saveBtn.style.background = 'linear-gradient(90deg,#43a047 60%,#ffd700 100%)';
    saveBtn.style.color = '#fff';
    saveBtn.style.fontWeight = '700';
    saveBtn.style.fontSize = '1.08rem';
    saveBtn.style.border = 'none';
    saveBtn.style.borderRadius = '999px';
    saveBtn.style.padding = '12px 36px';
    saveBtn.style.boxShadow = '0 2px 8px rgba(24,40,72,0.10)';
    saveBtn.style.letterSpacing = '0.2px';
    saveBtn.style.cursor = 'pointer';
    saveBtn.style.marginRight = '1em';
    saveBtn.style.marginBottom = '0.7em';
    saveBtn.style.transition = 'background 0.2s, box-shadow 0.2s';
    saveBtn.onmouseover = () => { saveBtn.style.background = 'linear-gradient(90deg,#388e3c 60%,#ffd700 100%)'; };
    saveBtn.onmouseout = () => { saveBtn.style.background = 'linear-gradient(90deg,#43a047 60%,#ffd700 100%)'; };
    form.appendChild(saveBtn);
    const cancelBtn = document.createElement('button');
    cancelBtn.type = 'button';
    cancelBtn.textContent = 'Cancel';
    cancelBtn.style.background = '#e53935';
    cancelBtn.style.color = '#fff';
    cancelBtn.style.fontWeight = '700';
    cancelBtn.style.fontSize = '1.08rem';
    cancelBtn.style.border = 'none';
    cancelBtn.style.borderRadius = '999px';
    cancelBtn.style.padding = '12px 36px';
    cancelBtn.style.boxShadow = '0 2px 8px rgba(24,40,72,0.10)';
    cancelBtn.style.letterSpacing = '0.2px';
    cancelBtn.style.cursor = 'pointer';
    cancelBtn.style.marginBottom = '0.7em';
    cancelBtn.style.transition = 'background 0.2s, box-shadow 0.2s';
    cancelBtn.onmouseover = () => { cancelBtn.style.background = '#b71c1c'; };
    cancelBtn.onmouseout = () => { cancelBtn.style.background = '#e53935'; };
    cancelBtn.onclick = () => { renderForm(table); };
    form.appendChild(cancelBtn);
  } else {
    const addBtn = document.createElement('button');
    addBtn.type = 'submit';
    addBtn.textContent = 'Add';
    addBtn.style.background = '#1a237e';
    addBtn.style.color = '#fff';
    addBtn.style.fontWeight = '700';
    addBtn.style.fontSize = '1.09rem';
    addBtn.style.border = 'none';
    addBtn.style.borderRadius = '999px';
    addBtn.style.padding = '13px 38px';
    addBtn.style.boxShadow = '0 2px 10px rgba(26,35,126,0.10)';
    addBtn.style.letterSpacing = '0.2px';
    addBtn.style.cursor = 'pointer';
    addBtn.style.marginBottom = '0.7em';
    addBtn.style.transition = 'background 0.2s, box-shadow 0.2s';
    addBtn.onmouseover = () => { addBtn.style.background = '#0d1333'; };
    addBtn.onmouseout = () => { addBtn.style.background = '#1a237e'; };
    form.appendChild(addBtn);
  }
  form.onsubmit = e => {
    e.preventDefault();
    const data = {};
    table.form.forEach(field => {
      if (field.key === 'id') return; // Never include id in the form
      data[field.key] = form[field.key].value;
    });
    if (editing) {
      fetch(API_BASE + table.api + '/' + editing.id, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      }).then(() => {
        renderForm(table);
        fetchAndRenderTableWithSearch(table);
      });
    } else {
      fetch(API_BASE + table.api, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      }).then(() => {
        form.reset();
        fetchAndRenderTableWithSearch(table);
      });
    }
  };
}

function fetchAndRenderTableWithSearch(table) {
  fetch(API_BASE + table.api)
    .then(res => {
      if (!res.ok) throw new Error('Failed to fetch: ' + res.status);
      return res.json();
    })
    .then(data => {
      let allData = Array.isArray(data) ? data : [];
      const tbody = document.querySelector(`#table-${table.id} tbody`);
      const searchInput = document.getElementById(`search-${table.id}`);
      const recoBox = document.getElementById(`reco-${table.id}`);
      // Determine main name key (prefer 'name', else first string column)
      let mainCol = table.columns.find(col => col.key === 'name') || table.columns.find(col => typeof allData[0]?.[col.key] === 'string');
      if (!mainCol) mainCol = table.columns[0];
      function renderRows(filtered) {
        tbody.innerHTML = '';
        if (!filtered.length) {
          tbody.innerHTML = `<tr><td colspan="${table.columns.length + 1}">No data found.</td></tr>`;
          return;
        }
        filtered.forEach(row => {
          const tr = document.createElement('tr');
          tr.innerHTML = table.columns.map(col => `<td>${row[col.key] !== undefined && row[col.key] !== null ? row[col.key] : ''}</td>`).join('') +
            `<td class="actions">
              <button class="edit">Edit</button>
              <button class="delete">Delete</button>
            </td>`;
          tr.querySelector('.edit').onclick = () => renderForm(table, row);
          tr.querySelector('.delete').onclick = () => {
            if (confirm('Delete this record?')) {
              fetch(API_BASE + table.api + '/' + row.id, { method: 'DELETE' })
                .then(() => fetchAndRenderTableWithSearch(table));
            }
          };
          tbody.appendChild(tr);
        });
      }
      renderRows(allData);
      searchInput.oninput = function() {
        const val = this.value.trim().toLowerCase();
        if (!val) {
          renderRows(allData);
          recoBox.style.display = 'none';
          return;
        }
        const filtered = allData.filter(row =>
          (row[mainCol.key] + '').toLowerCase().includes(val)
        );
        renderRows(filtered);
        // Recommendations
        if (filtered.length) {
          recoBox.innerHTML = filtered.slice(0, 7).map(row =>
            `<div style='padding:7px 12px;cursor:pointer;' onmouseover="this.style.background='#f7fafd'" onmouseout="this.style.background='#fff'">${row[mainCol.key]}</div>`
          ).join('');
          recoBox.style.display = 'block';
          Array.from(recoBox.children).forEach((child, idx) => {
            child.onclick = () => {
              searchInput.value = filtered[idx][mainCol.key];
              renderRows([filtered[idx]]);
              recoBox.style.display = 'none';
            };
          });
        } else {
          recoBox.innerHTML = '<div style="padding:7px 12px;color:#888;">No matches</div>';
          recoBox.style.display = 'block';
        }
      };
      searchInput.onblur = function() { setTimeout(() => { recoBox.style.display = 'none'; }, 200); };
      searchInput.onfocus = function() { if (this.value.trim()) recoBox.style.display = 'block'; };
    })
    .catch(err => {
      const tbody = document.querySelector(`#table-${table.id} tbody`);
      tbody.innerHTML = `<tr><td colspan="${table.columns.length + 1}">Error: ${err.message}</td></tr>`;
      console.error('Fetch error for', table.api, err);
    });
}

// Render all sections
TABLES.forEach(renderSection); 