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
    return response.data;
  } catch (error) {
    console.error('Error fetching interventions:', error);
    return { type: "FeatureCollection", features: [] };
  }
};

export const getAiSummary = async (interventionId) => {
  try {
    const response = await apiClient.get(`/interventions/${interventionId}/summary`);
    return response.data;
  } catch (error) {
    console.error('Error fetching AI summary:', error);
    return null;
  }
};

export const getComments = async (interventionId) => {
  try {
    const response = await apiClient.get(`/interventions/${interventionId}/comments`);
    return response.data;
  } catch (error) {
    console.error('Error fetching comments:', error);
    return [];
  }
};

export const addComment = async (interventionId, content, token) => {
  try {
    const response = await apiClient.post(
      `/interventions/${interventionId}/comments`,
      { content },
      { headers: { Authorization: `Bearer ${token}` } }
    );
    return response.data;
  } catch (error) {
    console.error('Error adding comment:', error);
    throw error;
  }
};

export const getVotes = async (interventionId) => {
  try {
    const response = await apiClient.get(`/interventions/${interventionId}/votes`);
    return response.data;
  } catch (error) {
    console.error('Error fetching votes:', error);
    return { averages: {}, total_votes: 0, raw: [] };
  }
};

export const addVote = async (interventionId, category, score, token) => {
  try {
    const response = await apiClient.post(
      `/interventions/${interventionId}/votes`,
      { category, score },
      { headers: { Authorization: `Bearer ${token}` } }
    );
    return response.data;
  } catch (error) {
    console.error('Error adding vote:', error);
    throw error;
  }
};

export default apiClient;
