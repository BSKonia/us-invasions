import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../services/supabaseClient';
import { getInterventions } from '../services/apiClient';
import { Target, Map as MapIcon, LogOut, Eye, AlertTriangle, MessageSquare, Star, X, ChevronDown } from 'lucide-react';

export default function DashboardPage() {
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [discoveredIds, setDiscoveredIds] = useState([]);
  const [allInterventions, setAllInterventions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState(null);
  const [userComments, setUserComments] = useState([]);
  const [userVotes, setUserVotes] = useState([]);

  // Modal states
  const [showAllComments, setShowAllComments] = useState(false);
  const [showAllVotes, setShowAllVotes] = useState(false);
  const [showAllDiscoveries, setShowAllDiscoveries] = useState(false);

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
    loadDashboardData(user);
  };

  const loadDashboardData = async (currentUser) => {
    const userId = currentUser.id;
    try {
      // Try to fetch profile from profiles table
      let { data: profileData } = await supabase
        .from('profiles')
        .select('username')
        .eq('id', userId)
        .single();
      
      // If no profile exists, try to create it from user_metadata
      if (!profileData) {
        const metaUsername = currentUser.user_metadata?.username;
        if (metaUsername) {
          const { data: newProfile } = await supabase
            .from('profiles')
            .insert([{ id: userId, username: metaUsername }])
            .select('username')
            .single();
          profileData = newProfile;
        }
      }

      // Final fallback: use user_metadata directly
      setProfile(profileData || { username: currentUser.user_metadata?.username });

      const { data: discoveries } = await supabase
        .from('user_discovered_interventions')
        .select('intervention_id')
        .eq('user_id', userId);
      const ids = discoveries ? discoveries.map(d => d.intervention_id) : [];
      setDiscoveredIds(ids);

      const { data: comments } = await supabase
        .from('intervention_comments')
        .select('*, interventions(title)')
        .eq('user_id', userId)
        .order('created_at', { ascending: false });
      setUserComments(comments || []);

      const { data: votes } = await supabase
        .from('intervention_votes')
        .select('*, interventions(title)')
        .eq('user_id', userId)
        .order('created_at', { ascending: false });
      setUserVotes(votes || []);

      const data = await getInterventions(1795, new Date().getFullYear());
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

  const categoryLabels = {
    justification: 'Justificada',
    success: 'Exito Militar',
    impact: 'Impacto Civil'
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-[#0a0a0a] flex items-center justify-center text-red-500 font-mono">
        CARGANDO ARCHIVOS CLASIFICADOS...
      </div>
    );
  }

  const discoveredInterventions = allInterventions.filter(f => discoveredIds.includes(f.properties.id));
  const unexplored = allInterventions.filter(f => !discoveredIds.includes(f.properties.id));
  const randomUnexplored = unexplored.sort(() => 0.5 - Math.random()).slice(0, 3);

  const commentsPreview = userComments.slice(0, 3);
  const votesPreview = userVotes.slice(0, 3);
  const discoveriesPreview = discoveredInterventions.slice(0, 3);

  return (
    <div className="min-h-screen bg-[#0a0a0a] font-mono text-gray-300 p-4 md:p-8">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <header className="flex flex-col sm:flex-row justify-between items-start sm:items-center border-b border-gray-800 pb-6 mb-8 gap-4">
          <div className="flex items-center gap-3">
            <Target className="w-8 h-8 text-red-500" />
            <div>
              <h1 className="text-2xl font-bold text-white tracking-tighter uppercase">Hola, {profile?.username || "Agente"}!</h1>
              <p className="text-xs text-gray-500">Agente: {user?.email}</p>
            </div>
          </div>
          <div className="flex gap-3">
            <button 
              onClick={() => navigate('/map')}
              className="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-5 py-2 font-bold cursor-pointer transition-colors text-sm uppercase tracking-wider"
            >
              <MapIcon size={16} />
              Mapa Global
            </button>
            <button 
              onClick={handleLogout}
              className="flex items-center gap-2 bg-[#1a1a1a] hover:bg-[#222] border border-gray-700 text-gray-400 px-4 py-2 cursor-pointer transition-colors text-sm uppercase"
            >
              <LogOut size={16} />
              Salir
            </button>
          </div>
        </header>

        {/* ============================================ */}
        {/* SECCION 1: ACTIVIDAD SOCIAL (arriba, destacada) */}
        {/* ============================================ */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
          
          {/* MIS COMENTARIOS */}
          <div className="bg-[#111] border border-gray-800 p-5">
            <h2 className="text-gray-500 text-xs mb-4 flex items-center justify-between">
              <span className="flex items-center gap-2"><MessageSquare size={14} className="text-blue-400" /> MIS COMENTARIOS</span>
              <span className="text-[10px] text-gray-600 bg-gray-900 px-2 py-0.5 rounded">{userComments.length}</span>
            </h2>
            <div className="space-y-3">
              {commentsPreview.length > 0 ? (
                commentsPreview.map(c => (
                  <div key={c.id} className="border-l-2 border-blue-500 pl-3">
                    <p className="text-[10px] text-blue-400 font-semibold mb-0.5">{c.interventions?.title}</p>
                    <p className="text-xs text-gray-300 line-clamp-2">{c.content}</p>
                    <p className="text-[10px] text-gray-600 mt-1">{new Date(c.created_at).toLocaleDateString()}</p>
                  </div>
                ))
              ) : (
                <p className="text-xs text-gray-600 italic py-4 text-center">No has participado en debates aun. Explora el mapa y comparte tu opinion.</p>
              )}
            </div>
            {userComments.length > 3 && (
              <button 
                onClick={() => setShowAllComments(true)}
                className="mt-4 w-full flex items-center justify-center gap-1.5 text-xs text-blue-400 hover:text-blue-300 border border-gray-800 hover:border-blue-500/50 py-2 rounded transition-colors cursor-pointer"
              >
                <ChevronDown size={14} />
                Ver todos los comentarios ({userComments.length})
              </button>
            )}
          </div>

          {/* MIS VALORACIONES */}
          <div className="bg-[#111] border border-gray-800 p-5">
            <h2 className="text-gray-500 text-xs mb-4 flex items-center justify-between">
              <span className="flex items-center gap-2"><Star size={14} className="text-yellow-400" /> MIS VALORACIONES</span>
              <span className="text-[10px] text-gray-600 bg-gray-900 px-2 py-0.5 rounded">{userVotes.length}</span>
            </h2>
            <div className="space-y-3">
              {votesPreview.length > 0 ? (
                votesPreview.map(v => (
                  <div key={v.id} className="border-l-2 border-yellow-500 pl-3 flex justify-between items-center">
                    <div>
                      <p className="text-[10px] text-yellow-400 font-semibold mb-0.5">{v.interventions?.title}</p>
                      <p className="text-[10px] text-gray-500 uppercase">{categoryLabels[v.category] || v.category}</p>
                    </div>
                    <div className="flex gap-0.5 text-yellow-500">
                      {[...Array(v.score)].map((_, i) => <Star key={i} size={10} className="fill-yellow-500" />)}
                      {[...Array(5 - v.score)].map((_, i) => <Star key={i + v.score} size={10} className="text-gray-700" />)}
                    </div>
                  </div>
                ))
              ) : (
                <p className="text-xs text-gray-600 italic py-4 text-center">No has valorado ningun expediente aun. Abre un conflicto y puntua.</p>
              )}
            </div>
            {userVotes.length > 3 && (
              <button 
                onClick={() => setShowAllVotes(true)}
                className="mt-4 w-full flex items-center justify-center gap-1.5 text-xs text-yellow-400 hover:text-yellow-300 border border-gray-800 hover:border-yellow-500/50 py-2 rounded transition-colors cursor-pointer"
              >
                <ChevronDown size={14} />
                Ver todas las valoraciones ({userVotes.length})
              </button>
            )}
          </div>
        </div>

        {/* ============================================ */}
        {/* SECCION 2: STATS + DESCUBRIMIENTOS */}
        {/* ============================================ */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          
          {/* Columna izquierda: Stats */}
          <div className="col-span-1 space-y-6">
            <div className="bg-[#111] border border-gray-800 p-5">
              <h2 className="text-gray-500 text-xs mb-2">ESTADO DEL ARCHIVO</h2>
              <div className="text-4xl font-bold text-white mb-1">
                {discoveredIds.length} <span className="text-sm text-gray-500 font-normal">/ {allInterventions.length}</span>
              </div>
              <p className="text-xs text-red-500">Expedientes analizados</p>
              <div className="w-full bg-gray-900 h-2 mt-3">
                <div 
                  className="bg-red-600 h-2 transition-all" 
                  style={{ width: `${Math.min(100, (discoveredIds.length / Math.max(1, allInterventions.length)) * 100)}%` }}
                ></div>
              </div>
            </div>

            <div className="bg-[#111] border border-gray-800 p-5">
              <h2 className="text-gray-500 text-xs mb-4 flex items-center gap-2">
                <AlertTriangle size={14} className="text-orange-500"/> 
                FOCOS RECOMENDADOS
              </h2>
              <div className="space-y-3">
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

          {/* Columna derecha: Historial de descubrimientos (comprimido a 3) */}
          <div className="col-span-1 md:col-span-2">
            <div className="bg-[#111] border border-gray-800 p-5">
              <h2 className="text-gray-500 text-xs mb-4 flex items-center justify-between">
                <span className="flex items-center gap-2"><Eye size={14} /> HISTORIAL DE DESCUBRIMIENTOS</span>
                <span className="text-[10px] text-gray-600 bg-gray-900 px-2 py-0.5 rounded">{discoveredInterventions.length} expedientes</span>
              </h2>
              
              <div className="space-y-2">
                {discoveriesPreview.length > 0 ? (
                  discoveriesPreview.map((item) => (
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
                      <span className="text-xs text-gray-500">{item.properties.country_name}</span>
                    </div>
                  ))
                ) : (
                  <div className="text-center py-8 border border-dashed border-gray-800 text-gray-600">
                    <p className="mb-1 text-sm">No hay registros analizados aun.</p>
                    <p className="text-xs">Accede al mapa global para comenzar a explorar.</p>
                  </div>
                )}
              </div>

              {discoveredInterventions.length > 3 && (
                <button 
                  onClick={() => setShowAllDiscoveries(true)}
                  className="mt-4 w-full flex items-center justify-center gap-1.5 text-xs text-red-400 hover:text-red-300 border border-gray-800 hover:border-red-500/50 py-2 rounded transition-colors cursor-pointer"
                >
                  <ChevronDown size={14} />
                  Ver todo el historial ({discoveredInterventions.length})
                </button>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* ============================================ */}
      {/* MODALES */}
      {/* ============================================ */}

      {/* MODAL: Todos los comentarios */}
      {showAllComments && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4" onClick={() => setShowAllComments(false)}>
          <div className="bg-[#111] border border-gray-700 rounded shadow-2xl w-full max-w-2xl max-h-[80vh] flex flex-col" onClick={e => e.stopPropagation()}>
            <div className="flex justify-between items-center p-5 border-b border-gray-800 shrink-0">
              <div className="flex items-center gap-3">
                <MessageSquare size={18} className="text-blue-400" />
                <div>
                  <h3 className="text-white font-bold text-sm uppercase">Todos mis comentarios</h3>
                  <p className="text-[10px] text-gray-500">{userComments.length} comentarios en total</p>
                </div>
              </div>
              <button onClick={() => setShowAllComments(false)} className="text-gray-500 hover:text-white transition-colors cursor-pointer">
                <X size={18} />
              </button>
            </div>
            <div className="p-5 overflow-y-auto custom-scrollbar flex-1 space-y-3">
              {userComments.map(c => (
                <div key={c.id} className="bg-black border border-gray-800 p-4 rounded hover:border-blue-500/30 transition-colors">
                  <div className="flex justify-between items-start mb-2">
                    <p className="text-xs text-blue-400 font-bold">{c.interventions?.title || 'Conflicto desconocido'}</p>
                    <span className="text-[10px] text-gray-600 bg-gray-900 px-2 py-0.5 rounded shrink-0 ml-3">
                      {new Date(c.created_at).toLocaleDateString()}
                    </span>
                  </div>
                  <p className="text-xs text-gray-300 leading-relaxed">{c.content}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* MODAL: Todas las valoraciones */}
      {showAllVotes && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4" onClick={() => setShowAllVotes(false)}>
          <div className="bg-[#111] border border-gray-700 rounded shadow-2xl w-full max-w-2xl max-h-[80vh] flex flex-col" onClick={e => e.stopPropagation()}>
            <div className="flex justify-between items-center p-5 border-b border-gray-800 shrink-0">
              <div className="flex items-center gap-3">
                <Star size={18} className="text-yellow-400" />
                <div>
                  <h3 className="text-white font-bold text-sm uppercase">Todas mis valoraciones</h3>
                  <p className="text-[10px] text-gray-500">{userVotes.length} valoraciones en total</p>
                </div>
              </div>
              <button onClick={() => setShowAllVotes(false)} className="text-gray-500 hover:text-white transition-colors cursor-pointer">
                <X size={18} />
              </button>
            </div>
            <div className="p-5 overflow-y-auto custom-scrollbar flex-1 space-y-3">
              {userVotes.map(v => (
                <div key={v.id} className="bg-black border border-gray-800 p-4 rounded hover:border-yellow-500/30 transition-colors flex justify-between items-center">
                  <div>
                    <p className="text-xs text-yellow-400 font-bold mb-1">{v.interventions?.title || 'Conflicto desconocido'}</p>
                    <p className="text-[10px] text-gray-500 uppercase">{categoryLabels[v.category] || v.category}</p>
                    <p className="text-[10px] text-gray-600 mt-1">{new Date(v.created_at).toLocaleDateString()}</p>
                  </div>
                  <div className="flex gap-0.5 text-yellow-500">
                    {[...Array(v.score)].map((_, i) => <Star key={i} size={12} className="fill-yellow-500" />)}
                    {[...Array(5 - v.score)].map((_, i) => <Star key={i + v.score} size={12} className="text-gray-700" />)}
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* MODAL: Todo el historial de descubrimientos */}
      {showAllDiscoveries && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4" onClick={() => setShowAllDiscoveries(false)}>
          <div className="bg-[#111] border border-gray-700 rounded shadow-2xl w-full max-w-3xl max-h-[80vh] flex flex-col" onClick={e => e.stopPropagation()}>
            <div className="flex justify-between items-center p-5 border-b border-gray-800 shrink-0">
              <div className="flex items-center gap-3">
                <Eye size={18} className="text-red-400" />
                <div>
                  <h3 className="text-white font-bold text-sm uppercase">Historial completo</h3>
                  <p className="text-[10px] text-gray-500">{discoveredInterventions.length} expedientes descubiertos</p>
                </div>
              </div>
              <button onClick={() => setShowAllDiscoveries(false)} className="text-gray-500 hover:text-white transition-colors cursor-pointer">
                <X size={18} />
              </button>
            </div>
            <div className="p-5 overflow-y-auto custom-scrollbar flex-1 space-y-2">
              {discoveredInterventions.map((item) => (
                <div key={item.properties.id} className="flex items-center justify-between p-3 bg-black border border-gray-800 hover:border-red-500/50 transition-colors rounded">
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
                  <span className="text-xs text-gray-500">{item.properties.country_name}</span>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
