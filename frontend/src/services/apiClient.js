import axios from 'axios';

const API_BASE_URL = 'http://localhost:8000/api';

const apiClient = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const getInterventions = async (startYear, endYear, typeId = null) => {
  try {
    const params = { start_year: startYear, end_year: endYear };
    if (typeId) params.type_id = typeId;
    
    const response = await apiClient.get('/interventions', { params });
    return response.data; // Devuelve el GeoJSON
  } catch (error) {
    console.error('Error fetching interventions:', error);
    return { type: "FeatureCollection", features: [] };
  }
};

export default apiClient;
