import React, { useState, useEffect, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../services/supabaseClient';
import { getInterventions } from '../services/apiClient';
import { Target, Map as MapIcon, LogOut, AlertTriangle, MessageSquare, Star, X, ChevronDown, TrendingUp, Filter } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';

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
  const [showAllRecommendations, setShowAllRecommendations] = useState(false);

  // Intervention type definitions for the stacked chart
  const CHART_TYPES = [
    { key: 'Bombardeo', color: '#ff5500' },
    { key: 'Ocupación Militar', color: '#ff0055' },
    { key: 'Operación Naval', color: '#0088ff' },
    { key: 'Operación Encubierta', color: '#aa00ff' },
    { key: 'Acciones WW1', color: '#8B6914' },
    { key: 'Acciones WW2', color: '#B8860B' },
    { key: 'Golpe de Estado', color: '#ff0000' },
    { key: 'Injerencia Política', color: '#ffaa00' },
    { key: 'Embargo', color: '#00C853' },
    { key: 'Desestabilización', color: '#00E676' },
    { key: 'Sanciones', color: '#69F0AE' },
  ];

  // Compute stacked bar chart data: interventions grouped by decade and type
  const decadeChartData = useMemo(() => {
    if (!allInterventions.length) return [];
    const decades = {};
    allInterventions.forEach(f => {
      const year = f.properties.start_year;
      let decadeStart;
      if (year >= 2020) {
        decadeStart = 2020; // 2020-present
      } else {
        decadeStart = Math.floor(year / 10) * 10;
      }
      if (!decades[decadeStart]) {
        decades[decadeStart] = {};
      }
      const typeName = f.properties.type_name || 'Otro';
      decades[decadeStart][typeName] = (decades[decadeStart][typeName] || 0) + 1;
    });
    
    const typeKeys = CHART_TYPES.map(ct => ct.key);
    return Object.entries(decades)
      .map(([decadeStart, types]) => {
        const ds = parseInt(decadeStart);
        const label = ds >= 2020 ? '2020-HOY' : `${ds}-${ds + 9}`;
        const total = Object.values(types).reduce((sum, v) => sum + v, 0);
        // Pre-compute cumulative sums for each type in stack order
        const cumulative = {};
        let runningSum = 0;
        typeKeys.forEach(key => {
          const val = types[key] || 0;
          if (val > 0) {
            runningSum += val;
            cumulative[`_cum_${key}`] = runningSum;
          }
        });
        return { decade: label, _sort: ds, total, ...types, ...cumulative };
      })
      .sort((a, b) => a._sort - b._sort);
  }, [allInterventions]);

  // Custom tooltip for the stacked bar chart
  const DecadeTooltip = ({ active, payload, label }) => {
    if (!active || !payload || !payload.length) return null;
    const total = payload.reduce((sum, p) => sum + (p.value || 0), 0);
    return (
      <div className="bg-black border border-gray-700 rounded p-3 shadow-2xl font-mono text-xs max-w-[220px]">
        <p className="text-white font-bold mb-2 border-b border-gray-800 pb-1">{label} <span className="text-gray-500">({total})</span></p>
        <div className="space-y-1">
          {payload.filter(p => p.value > 0).map(p => (
            <div key={p.dataKey} className="flex justify-between items-center gap-3">
              <div className="flex items-center gap-1.5">
                <div className="w-2 h-2 rounded-full shrink-0" style={{ backgroundColor: p.fill }}></div>
                <span className="text-gray-400 truncate">{p.dataKey}</span>
              </div>
              <span className="text-white font-bold">{p.value}</span>
            </div>
          ))}
        </div>
      </div>
    );
  };

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

  const unexplored = allInterventions.filter(f => !discoveredIds.includes(f.properties.id));

  // Smart recommendation: analyze which types the user interacts with most
  const interactedTypeCount = {};
  // Build a lookup map from intervention id -> type_name
  const idToType = {};
  allInterventions.forEach(f => { idToType[f.properties.id] = f.properties.type_name; });

  // Count types from comments
  userComments.forEach(c => {
    const typeName = idToType[c.intervention_id];
    if (typeName) interactedTypeCount[typeName] = (interactedTypeCount[typeName] || 0) + 1;
  });
  // Count types from votes
  userVotes.forEach(v => {
    const typeName = idToType[v.intervention_id];
    if (typeName) interactedTypeCount[typeName] = (interactedTypeCount[typeName] || 0) + 1;
  });
  // Count types from discoveries
  discoveredIds.forEach(id => {
    const typeName = idToType[id];
    if (typeName) interactedTypeCount[typeName] = (interactedTypeCount[typeName] || 0) + 1;
  });

  // Find the most interacted type(s)
  const sortedTypes = Object.entries(interactedTypeCount).sort((a, b) => b[1] - a[1]);
  const topType = sortedTypes.length > 0 ? sortedTypes[0][0] : null;

  // Smart recommendations: unexplored interventions of the user's preferred type
  let smartRecommendations;
  let recommendationLabel;
  if (topType) {
    smartRecommendations = unexplored.filter(f => f.properties.type_name === topType);
    recommendationLabel = topType;
    // If not enough of that type, supplement with second-most type
    if (smartRecommendations.length < 3 && sortedTypes.length > 1) {
      const secondType = sortedTypes[1][0];
      const secondBatch = unexplored.filter(f => f.properties.type_name === secondType);
      smartRecommendations = [...smartRecommendations, ...secondBatch];
      recommendationLabel = `${topType} / ${secondType}`;
    }
  } else {
    // No interaction data: rotate across all types
    smartRecommendations = unexplored.sort(() => 0.5 - Math.random());
    recommendationLabel = 'Todos los tipos';
  }
  const recommendationsPreview = smartRecommendations.slice(0, 3);

  const commentsPreview = userComments.slice(0, 3);
  const votesPreview = userVotes.slice(0, 3);

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

        {/* App description */}
        <p className="text-sm text-gray-400 mb-8 -mt-4 max-w-3xl leading-relaxed">
          Intervenciones y bases militares de EE.UU. en todo el mundo, desde su independencia hasta hoy. 
          Explora el mapa interactivo, analiza expedientes clasificados y participa con la comunidad.
        </p>

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
        {/* SECCION 1.5: TIPOS DE INTERVENCIÓN (referencia visual) */}
        {/* ============================================ */}
        <div className="bg-[#111] border border-gray-800 p-4 md:p-5 mb-8">
          <h2 className="text-gray-500 text-xs mb-4 flex items-center gap-2">
            <Filter size={14} className="text-red-500" />
            TIPOS DE INTERVENCIÓN
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {/* Militar */}
            <div className="space-y-2">
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#ff2020] border-b border-[#ff2020]/20 pb-1">Militar</h3>
              <div className="space-y-1.5">
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#ff5500' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Bombardeo</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Ataques aéreos y bombardeos estratégicos</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#ff0055' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Ocupación Militar</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Despliegue de tropas y ocupación territorial</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#0088ff' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Operación Naval</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Bloqueos navales y despliegue de flotas</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#aa00ff' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Operación Encubierta</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Acciones clandestinas de la CIA y operaciones secretas</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#8B6914' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Acciones WW1</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Intervenciones durante la Primera Guerra Mundial</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#B8860B' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Acciones WW2</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Intervenciones durante la Segunda Guerra Mundial</p>
                  </div>
                </div>
              </div>
            </div>
            {/* Político */}
            <div className="space-y-2">
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#ffaa00] border-b border-[#ffaa00]/20 pb-1">Político</h3>
              <div className="space-y-1.5">
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#ff0000' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Golpe de Estado</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Apoyo o ejecución de golpes contra gobiernos</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#ffaa00' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Injerencia Política</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Manipulación electoral e influencia política</p>
                  </div>
                </div>
              </div>
            </div>
            {/* Económico */}
            <div className="space-y-2">
              <h3 className="text-xs font-bold uppercase tracking-wider text-[#00C853] border-b border-[#00C853]/20 pb-1">Económico</h3>
              <div className="space-y-1.5">
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#00C853' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Embargo</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Bloqueos comerciales y embargos económicos</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#00E676' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Desestabilización</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Sabotaje económico y desestabilización financiera</p>
                  </div>
                </div>
                <div className="flex items-start gap-2">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0 mt-0.5" style={{ backgroundColor: '#69F0AE' }}></div>
                  <div>
                    <span className="text-[11px] text-white font-semibold">Sanciones</span>
                    <p className="text-[10px] text-gray-500 leading-tight">Sanciones económicas y restricciones comerciales</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        {/* ============================================ */}
        {/* SECCION 1.5b: GRAFICO DE INTERVENCIONES POR DÉCADA */}
        {/* ============================================ */}
        {decadeChartData.length > 0 && (
          <div className="bg-[#111] border border-gray-800 p-4 md:p-5 mb-8">
            <h2 className="text-gray-500 text-xs mb-4 flex items-center gap-2">
              <TrendingUp size={14} className="text-red-500" />
              INTERVENCIONES POR DÉCADA Y TIPO
            </h2>
            <div className="w-full overflow-x-auto custom-scrollbar">
              <div className="flex" style={{ minWidth: '600px' }}>
                {/* Chart area */}
                <div className="flex-1" style={{ height: `${Math.max(300, decadeChartData.length * 36 + 60)}px` }}>
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart 
                      data={decadeChartData} 
                      layout="vertical" 
                      margin={{ top: 5, right: 10, bottom: 5, left: 10 }}
                      barSize={20}
                      barGap={2}
                    >
                    <XAxis type="number" hide />
                    <YAxis 
                      type="category" 
                      dataKey="decade" 
                      tick={{ fontSize: 11, fill: '#9ca3af', fontFamily: 'monospace' }} 
                      axisLine={false}
                      tickLine={false}
                      width={85}
                    />
                    <Tooltip content={<DecadeTooltip />} cursor={{ fill: 'rgba(255,255,255,0.03)' }} />
                    {CHART_TYPES.map(ct => (
                      <Bar 
                        key={ct.key} 
                        dataKey={ct.key} 
                        stackId="a" 
                        fill={ct.color}
                        radius={0}
                        label={({ x, y, width, height, value, index }) => {
                          if (!value || width < 18) return null;
                          const cumVal = decadeChartData[index]?.[`_cum_${ct.key}`] || value;
                          return (
                            <text x={x + width / 2} y={y + height / 2 + 1} textAnchor="middle" dominantBaseline="middle" fill="#fff" fontSize={10} fontWeight="bold" fontFamily="monospace">
                              {cumVal}
                            </text>
                          );
                        }}
                      />
                    ))}
                  </BarChart>
                </ResponsiveContainer>
                </div>
                {/* Totals column */}
                <div className="flex flex-col justify-start shrink-0 w-10" style={{ paddingTop: '5px', paddingBottom: '5px' }}>
                  {decadeChartData.map(d => (
                    <div 
                      key={d.decade} 
                      className="flex items-center justify-end text-xs text-gray-400 font-bold font-mono"
                      style={{ height: `${(Math.max(300, decadeChartData.length * 36 + 60) - 10) / decadeChartData.length}px` }}
                    >
                      {d.total}
                    </div>
                  ))}
              </div>
            </div>
            {/* Totals summary row */}
            <div className="flex items-center mt-3 pt-3 border-t border-gray-700" style={{ minWidth: '600px' }}>
              <span className="text-xs text-gray-400 font-bold font-mono uppercase shrink-0" style={{ width: '95px', paddingLeft: '10px' }}>TOTAL</span>
              <div className="flex-1 flex items-center gap-1 flex-wrap">
                {CHART_TYPES.map(ct => {
                  const typeTotal = decadeChartData.reduce((sum, d) => sum + (d[ct.key] || 0), 0);
                  if (!typeTotal) return null;
                  return (
                    <span key={ct.key} className="inline-flex items-center gap-1 text-[10px] font-bold font-mono text-white px-1.5 py-0.5 rounded" style={{ backgroundColor: ct.color }}>
                      {ct.key.split(' ')[0]}: {typeTotal}
                    </span>
                  );
                })}
              </div>
              <span className="text-xs text-white font-bold font-mono shrink-0 w-10 text-right">
                {decadeChartData.reduce((sum, d) => sum + d.total, 0)}
              </span>
            </div>
            </div>
            {/* Compact legend below chart */}
            <div className="flex flex-wrap gap-x-4 gap-y-1.5 mt-4 pt-3 border-t border-gray-800">
              {CHART_TYPES.map(ct => (
                <div key={ct.key} className="flex items-center gap-1.5">
                  <div className="w-2.5 h-2.5 rounded-full shrink-0" style={{ backgroundColor: ct.color }}></div>
                  <span className="text-[10px] text-gray-500">{ct.key}</span>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* ============================================ */}
        {/* SECCION 2: STATS + FOCOS RECOMENDADOS */}
        {/* ============================================ */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          
          {/* Columna izquierda: Stats */}
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

          {/* Columna derecha: Focos Recomendados (inteligente) */}
          <div className="bg-[#111] border border-gray-800 p-5">
            <h2 className="text-gray-500 text-xs mb-1 flex items-center justify-between">
              <span className="flex items-center gap-2">
                <AlertTriangle size={14} className="text-orange-500"/> 
                FOCOS RECOMENDADOS
              </span>
              {topType && (
                <span className="text-[10px] text-orange-400 bg-orange-500/10 px-2 py-0.5 rounded border border-orange-500/20">
                  Basado en: {recommendationLabel}
                </span>
              )}
            </h2>
            <p className="text-[10px] text-gray-600 mb-4">
              {topType 
                ? 'Sugerencias basadas en tus interacciones anteriores'
                : 'Explora el mapa para recibir recomendaciones personalizadas'}
            </p>
            <div className="space-y-3">
              {recommendationsPreview.map(item => (
                <div key={item.properties.id} className="border-l-2 border-orange-500 pl-3 flex justify-between items-center">
                  <div className="min-w-0 flex-1">
                    <h3 className="text-white text-sm font-bold truncate">{item.properties.title}</h3>
                    <div className="flex items-center gap-2 mt-0.5">
                      <span className="text-[10px] uppercase" style={{ color: item.properties.color_code }}>
                        {item.properties.type_name}
                      </span>
                      <span className="text-xs text-gray-500">{item.properties.country_name} ({item.properties.start_year})</span>
                    </div>
                  </div>
                </div>
              ))}
              {recommendationsPreview.length === 0 && (
                <p className="text-xs text-gray-600 italic py-4 text-center">Has analizado todos los archivos disponibles.</p>
              )}
            </div>
            {smartRecommendations.length > 3 && (
              <button 
                onClick={() => setShowAllRecommendations(true)}
                className="mt-4 w-full flex items-center justify-center gap-1.5 text-xs text-orange-400 hover:text-orange-300 border border-gray-800 hover:border-orange-500/50 py-2 rounded transition-colors cursor-pointer"
              >
                <ChevronDown size={14} />
                Ver todo ({smartRecommendations.length})
              </button>
            )}
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

      {/* MODAL: Todas las recomendaciones */}
      {showAllRecommendations && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm p-4" onClick={() => setShowAllRecommendations(false)}>
          <div className="bg-[#111] border border-gray-700 rounded shadow-2xl w-full max-w-2xl max-h-[80vh] flex flex-col" onClick={e => e.stopPropagation()}>
            <div className="flex justify-between items-center p-5 border-b border-gray-800 shrink-0">
              <div className="flex items-center gap-3">
                <AlertTriangle size={18} className="text-orange-400" />
                <div>
                  <h3 className="text-white font-bold text-sm uppercase">Focos Recomendados</h3>
                  <p className="text-[10px] text-gray-500">{smartRecommendations.length} intervenciones sugeridas{topType && ` — ${recommendationLabel}`}</p>
                </div>
              </div>
              <button onClick={() => setShowAllRecommendations(false)} className="text-gray-500 hover:text-white transition-colors cursor-pointer">
                <X size={18} />
              </button>
            </div>
            <div className="p-5 overflow-y-auto custom-scrollbar flex-1 space-y-2">
              {smartRecommendations.map(item => (
                <div key={item.properties.id} className="flex items-center justify-between p-3 bg-black border border-gray-800 hover:border-orange-500/50 transition-colors rounded">
                  <div className="min-w-0 flex-1">
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
                  <span className="text-xs text-gray-500 shrink-0 ml-3">{item.properties.country_name}</span>
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

    </div>
  );
}
