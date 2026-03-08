import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../services/supabaseClient';
import { getInterventions } from '../services/apiClient';
import { Target, Map as MapIcon, LogOut, Eye, AlertTriangle } from 'lucide-react';

export default function DashboardPage() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [discoveredIds, setDiscoveredIds] = useState([]);
  const [allInterventions, setAllInterventions] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    checkUser();
  }, []);

  const checkUser = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) {
      navigate('/login');
      return;
    }
    setUser(user);
    loadDashboardData(user.id);
  };

  const loadDashboardData = async (userId) => {
    try {
      // Fetch user discoveries
      const { data: discoveries } = await supabase
        .from('user_discovered_interventions')
        .select('intervention_id')
        .eq('user_id', userId);
        
      const ids = discoveries ? discoveries.map(d => d.intervention_id) : [];
      setDiscoveredIds(ids);

      // Fetch all interventions from API to show some data
      const data = await getInterventions(1850, 2026);
      if (data && data.features) {
        setAllInterventions(data.features);
      }
    } catch (error) {
      console.error("Error loading dashboard data", error);
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = async () => {
    await supabase.auth.signOut();
    navigate('/login');
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-[#0a0a0a] flex items-center justify-center text-red-500 font-mono">
        CARGANDO ARCHIVOS CLASIFICADOS...
      </div>
    );
  }

  // Filter interventions
  const discoveredInterventions = allInterventions.filter(f => discoveredIds.includes(f.properties.id));
  
  // Pick some random unexplored interventions
  const unexplored = allInterventions.filter(f => !discoveredIds.includes(f.properties.id));
  const randomUnexplored = unexplored.sort(() => 0.5 - Math.random()).slice(0, 3);

  return (
    <div className="min-h-screen bg-[#0a0a0a] font-mono text-gray-300 p-8">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <header className="flex justify-between items-center border-b border-gray-800 pb-6 mb-8">
          <div className="flex items-center gap-3">
            <Target className="w-8 h-8 text-red-500" />
            <div>
              <h1 className="text-2xl font-bold text-white tracking-tighter uppercase">Panel de Control Central</h1>
              <p className="text-xs text-gray-500">Agente: {user?.email}</p>
            </div>
          </div>
          
          <div className="flex gap-4">
            <button 
              onClick={() => navigate('/map')}
              className="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-6 py-2 font-bold cursor-pointer transition-colors text-sm uppercase tracking-wider"
            >
              <MapIcon size={16} />
              Acceder al Mapa Global
            </button>
            <button 
              onClick={handleLogout}
              className="flex items-center gap-2 bg-[#1a1a1a] hover:bg-[#222] border border-gray-700 text-gray-400 px-4 py-2 cursor-pointer transition-colors text-sm uppercase"
            >
              <LogOut size={16} />
              Desconectar
            </button>
          </div>
        </header>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {/* Stats Column */}
          <div className="col-span-1 space-y-6">
            <div className="bg-[#111] border border-gray-800 p-6">
              <h2 className="text-gray-500 text-xs mb-2">ESTADO DEL ARCHIVO</h2>
              <div className="text-4xl font-bold text-white mb-1">
                {discoveredIds.length} <span className="text-sm text-gray-500 font-normal">/ {allInterventions.length}</span>
              </div>
              <p className="text-xs text-red-500">Expedientes desclasificados analizados</p>
              
              <div className="w-full bg-gray-900 h-2 mt-4">
                <div 
                  className="bg-red-600 h-2" 
                  style={{ width: `${Math.min(100, (discoveredIds.length / Math.max(1, allInterventions.length)) * 100)}%` }}
                ></div>
              </div>
            </div>

            <div className="bg-[#111] border border-gray-800 p-6">
              <h2 className="text-gray-500 text-xs mb-4 flex items-center gap-2">
                <AlertTriangle size={14} className="text-orange-500"/> 
                FOCOS RECOMENDADOS PARA ANÁLISIS
              </h2>
              <div className="space-y-4">
                {randomUnexplored.map(item => (
                  <div key={item.properties.id} className="border-l-2 border-orange-500 pl-3">
                    <h3 className="text-white text-sm font-bold truncate">{item.properties.title}</h3>
                    <p className="text-xs text-gray-500">{item.properties.country_name} ({item.properties.start_year})</p>
                  </div>
                ))}
                {randomUnexplored.length === 0 && (
                  <p className="text-xs text-gray-600 italic">Has analizado todos los archivos disponibles.</p>
                )}
              </div>
            </div>
          </div>

          {/* Activity Column */}
          <div className="col-span-1 md:col-span-2">
            <div className="bg-[#111] border border-gray-800 p-6 h-full">
              <h2 className="text-gray-500 text-xs mb-6 flex items-center gap-2">
                <Eye size={14} /> 
                HISTORIAL DE DESCUBRIMIENTOS
              </h2>
              
              <div className="space-y-3">
                {discoveredInterventions.length > 0 ? (
                  discoveredInterventions.map((item) => (
                    <div key={item.properties.id} className="flex items-center justify-between p-3 bg-black border border-gray-800 hover:border-red-500/50 transition-colors">
                      <div>
                        <div className="flex items-center gap-2 mb-1">
                          <span className="text-[10px] px-1.5 py-0.5 bg-gray-900 text-gray-400 border border-gray-700">
                            {item.properties.start_year}
                          </span>
                          <span className="text-[10px] uppercase" style={{ color: item.properties.color_code }}>
                            {item.properties.type_name}
                          </span>
                        </div>
                        <h3 className="text-sm font-semibold text-white">{item.properties.title}</h3>
                      </div>
                      <div className="text-right">
                        <span className="text-xs text-gray-500">{item.properties.country_name}</span>
                      </div>
                    </div>
                  ))
                ) : (
                  <div className="text-center py-12 border border-dashed border-gray-800 text-gray-600">
                    <p className="mb-2 text-sm">No hay registros analizados aún.</p>
                    <p className="text-xs">Accede al mapa global para comenzar a explorar el archivo.</p>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
