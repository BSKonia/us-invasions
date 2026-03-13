import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000/api';

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

export const getAiSources = async (interventionId, force = false) => {
  try {
    const params = force ? { force: true } : {};
    const response = await apiClient.get(`/interventions/${interventionId}/ai_sources`, { params });
    return response.data;
  } catch (error) {
    console.error('Error fetching AI sources:', error);
    return null;
  }
};

export const clearAiSourcesCache = async () => {
  try {
    const response = await apiClient.delete('/interventions/ai_sources/cache');
    return response.data;
  } catch (error) {
    console.error('Error clearing AI sources cache:', error);
    throw error;
  }
};

// ================================
// MILITARY BASES
// ================================

export const getMilitaryBases = async () => {
  try {
    const response = await apiClient.get('/military_bases');
    return response.data;
  } catch (error) {
    console.error('Error fetching military bases:', error);
    return { type: "FeatureCollection", features: [] };
  }
};

export const getBaseAiSummary = async (baseId) => {
  try {
    const response = await apiClient.get(`/military_bases/${baseId}/summary`);
    return response.data;
  } catch (error) {
    console.error('Error fetching base AI summary:', error);
    return null;
  }
};

export const getBaseAiSources = async (baseId, force = false) => {
  try {
    const params = force ? { force: true } : {};
    const response = await apiClient.get(`/military_bases/${baseId}/ai_sources`, { params });
    return response.data;
  } catch (error) {
    console.error('Error fetching base AI sources:', error);
    return null;
  }
};

export const getBaseComments = async (baseId) => {
  try {
    const response = await apiClient.get(`/military_bases/${baseId}/comments`);
    return response.data;
  } catch (error) {
    console.error('Error fetching base comments:', error);
    return [];
  }
};

export const addBaseComment = async (baseId, content, token) => {
  try {
    const response = await apiClient.post(
      `/military_bases/${baseId}/comments`,
      { content },
      { headers: { Authorization: `Bearer ${token}` } }
    );
    return response.data;
  } catch (error) {
    console.error('Error adding base comment:', error);
    throw error;
  }
};

export const getBaseVotes = async (baseId) => {
  try {
    const response = await apiClient.get(`/military_bases/${baseId}/votes`);
    return response.data;
  } catch (error) {
    console.error('Error fetching base votes:', error);
    return { averages: {}, total_votes: 0, raw: [] };
  }
};

export const addBaseVote = async (baseId, category, score, token) => {
  try {
    const response = await apiClient.post(
      `/military_bases/${baseId}/votes`,
      { category, score },
      { headers: { Authorization: `Bearer ${token}` } }
    );
    return response.data;
  } catch (error) {
    console.error('Error adding base vote:', error);
    throw error;
  }
};

// ================================
// DASHBOARD FEATURES
// ================================

export const getEphemeris = async () => {
  try {
    const response = await apiClient.get('/ephemeris');
    return response.data;
  } catch (error) {
    console.error('Error fetching ephemeris:', error);
    return { date: '', interventions: [] };
  }
};

export const getRecentActivity = async (limit = 15) => {
  try {
    const response = await apiClient.get('/recent_activity', { params: { limit } });
    return response.data;
  } catch (error) {
    console.error('Error fetching recent activity:', error);
    return [];
  }
};

export default apiClient;
