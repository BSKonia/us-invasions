import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import Map, { Source, Layer, Popup, Marker } from 'react-map-gl/maplibre';
import 'maplibre-gl/dist/maplibre-gl.css';
import { getInterventions } from '../services/apiClient';
import { supabase } from '../services/supabaseClient';
import { Target, AlertTriangle, Clock, X, ArrowLeft, Eye, TrendingUp, ChevronLeft, ChevronRight, LayoutDashboard, MapPin, Zap, MessageSquare, History } from 'lucide-react';
import InterventionPopup from './InterventionPopup';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';

const MAPTILER_KEY = import.meta.env.VITE_MAPTILER_KEY || 'Pw2ozdqe8K3Hu9Qg6OkX';

export default function MapDashboard() {
  const mapRef = useRef();
  const navigate = useNavigate();
  const [data, setData] = useState({ type: "FeatureCollection", features: [] });
  const [yearRange, setYearRange] = useState([1795, 1795]);
  const [hoverInfo, setHoverInfo] = useState(null);
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [activeTab, setActiveTab] = useState('summary');
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);
  
  // States para tracking de comentarios del usuario
  const [user, setUser] = useState(null);
  const [commentedIds, setCommentedIds] = useState([]);
  const [showOnlyCommented, setShowOnlyCommented] = useState(false);
  const [activeFilter, setActiveFilter] = useState(null); // null | 'actuales' | 'historico'

  useEffect(() => {
    checkUser();
    loadData();
  }, []);

  const checkUser = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (user) {
      setUser(user);
      // Fetch intervention IDs where this user has commented
      const { data: comments } = await supabase
        .from('intervention_comments')
        .select('intervention_id')
        .eq('user_id', user.id);
      
      if (comments) {
        const uniqueIds = [...new Set(comments.map(c => c.intervention_id))];
        setCommentedIds(uniqueIds);
      }
    }
  };


  const loadData = async () => {
    const geojsonData = await getInterventions(1795, 2026); // load all for timeline/chart
    setData(geojsonData);
  };

  const handleYearChange = (e) => {
    setYearRange([1795, parseInt(e.target.value)]);
    setActiveFilter(null); // Deselect buttons when user manually adjusts slider
  };

  const onPointClick = (event) => {
    const feature = event.features[0];
    if (feature) {
      mapRef.current?.flyTo({
        center: feature.geometry.coordinates,
        zoom: 5,
        duration: 1500
      });
      setSelectedEvent(feature);
    }
  };

  
  const hoverLayerStyle = {
    id: 'interventions-hover-layer',
    type: 'circle',
    paint: {
      'circle-radius': 20,
      'circle-color': 'transparent',
      'circle-stroke-width': 2,
      'circle-stroke-color': '#ff003c',
      'circle-opacity': 1,
      'circle-blur': 0.2
    },
    filter: ['==', 'id', hoverInfo?.id || -1]
  };

  const filteredData = useMemo(() => {
    let features = data.features;
    if (showOnlyCommented) {
      features = features.filter(f => commentedIds.includes(f.properties.id));
    }
    // Filter by year range
    features = features.filter(f => f.properties.start_year >= yearRange[0] && f.properties.start_year <= yearRange[1]);
    
    // Sort chronologically for the sidebar
    features = features.sort((a, b) => b.properties.start_year - a.properties.start_year);

    return {
      ...data,
      features
    };
  }, [data, showOnlyCommented, commentedIds, yearRange]);

  // Data for Global Tension Index (events per 25-year period)
  const chartData = useMemo(() => {
    const periods = {};
    data.features.forEach(f => {
      const year = f.properties.start_year;
      const periodStart = Math.floor(year / 25) * 25;
      periods[periodStart] = (periods[periodStart] || 0) + 1;
    });
    
    return Object.entries(periods)
      .map(([periodStart, count]) => ({
        period: `${periodStart}`,
        events: count
      }))
      .sort((a, b) => parseInt(a.period) - parseInt(b.period));
  }, [data.features]);

  return (
    <div className="flex h-screen w-full bg-[#0a0a0a] text-gray-300 font-mono overflow-hidden">
      
      {/* Floating Toggle Button (visible when sidebar closed) */}
      {!isSidebarOpen && (
        <button 
          onClick={() => setIsSidebarOpen(true)}
          className="absolute top-4 left-4 z-20 bg-[#111] border border-gray-700 text-gray-400 p-2 rounded shadow-2xl hover:text-white hover:border-gray-500 transition-colors"
          title="Abrir Panel"
        >
          <ChevronRight size={24} />
        </button>
      )}

      {/* Sidebar (Activity Feed) */}
      <div className={`transition-all duration-300 ease-in-out flex flex-col bg-[#111] border-r border-gray-800 z-10 shadow-2xl ${isSidebarOpen ? 'w-1/3 max-w-md' : 'w-0 border-r-0'}`}>
        <div style={{ minWidth: '320px', width: '100%', height: '100%', display: isSidebarOpen ? 'flex' : 'none', flexDirection: 'column' }}>
        <div className="p-6 border-b border-gray-800 relative">
          <div className="flex justify-between items-start mb-4">
            <button 
              onClick={() => navigate('/dashboard')}
              className="flex items-center gap-2 text-xs font-bold bg-black border border-gray-700 text-gray-400 px-3 py-1.5 rounded hover:text-white hover:border-gray-500 transition-colors"
            >
              <LayoutDashboard size={14} />
              VOLVER AL DASHBOARD
            </button>

            <button 
              onClick={() => setIsSidebarOpen(false)}
              className="text-gray-500 hover:text-white transition-colors p-1"
              title="Minimizar Panel"
            >
              <ChevronLeft size={20} />
            </button>
          </div>
          
          <h1 className="text-2xl font-bold text-red-500 tracking-tighter flex items-center gap-2 uppercase">
            <Target className="w-6 h-6" />
            US_Interventions
          </h1>
          <p className="text-xs text-gray-500 mt-2">REGISTRO DE INTERVENCIONES E INJERENCIAS CLASIFICADAS</p>
          
          {user && (
            <button
              onClick={() => setShowOnlyCommented(!showOnlyCommented)}
              className={`mt-4 w-full flex items-center justify-center gap-2 py-2 text-xs font-bold transition-colors border ${
                showOnlyCommented 
                ? 'bg-red-900/30 text-red-400 border-red-500/50' 
                : 'bg-black text-gray-400 border-gray-700 hover:border-gray-500'
              }`}
            >
              <MessageSquare size={14} />
              {showOnlyCommented ? 'MOSTRANDO SOLO COMENTADOS' : 'MOSTRAR SOLO COMENTADOS'}
            </button>
          )}

          {/* Global Tension Index Chart */}
          <div className="mt-6 pt-4 border-t border-gray-800">
            <h3 className="text-xs text-gray-400 mb-2 flex items-center gap-2">
              <TrendingUp size={14} className="text-red-500" />
              ÍNDICE DE ACTIVIDAD GLOBAL
            </h3>
            <div className="h-32 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={chartData} margin={{ top: 0, right: 0, bottom: 0, left: 0 }}>
                  <XAxis 
                    dataKey="period" 
                    tick={{ fontSize: 9, fill: '#666' }} 
                    axisLine={{ stroke: '#333' }}
                    tickLine={false}
                    interval={0}
                    angle={-45}
                    textAnchor="end"
                    height={35}
                  />
                  <YAxis hide />
                  <Tooltip 
                    cursor={{fill: '#222'}} 
                    contentStyle={{backgroundColor: '#000', borderColor: '#333', fontSize: '12px'}}
                    itemStyle={{color: '#ff003c'}}
                    labelFormatter={(label) => `${label} - ${parseInt(label) + 24}`}
                  />
                  <Bar dataKey="events" fill="#ff003c" radius={[2, 2, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        <div className="flex-1 overflow-y-auto p-4 space-y-3 custom-scrollbar">
          {filteredData.features.map((feature) => {
            const hasCommented = commentedIds.includes(feature.properties.id);
            return (
              <div 
                key={feature.properties.id}
                className={`p-4 bg-[#1a1a1a] border rounded cursor-pointer transition-all hover:bg-[#222] ${
                  hasCommented ? 'border-red-500/30' : 'border-gray-800 hover:border-gray-600'
                }`}
                onMouseEnter={() => setHoverInfo(feature.properties)}
                onMouseLeave={() => setHoverInfo(null)}
                onClick={() => {
                  mapRef.current?.flyTo({ center: feature.geometry.coordinates, zoom: 6 });
                  setSelectedEvent(feature);
                }}
              >
                <div className="flex justify-between items-start mb-2">
                  <span className="text-xs font-bold px-2 py-1 rounded bg-black text-gray-400 border border-gray-700">
                    {feature.properties.start_year}
                  </span>
                  <div className="flex items-center gap-2">
                    {hasCommented && <MessageSquare size={12} className="text-red-500" title="Comentado" />}
                    <span className="text-[10px] uppercase tracking-widest" style={{ color: feature.properties.color_code }}>
                      {feature.properties.type_name}
                    </span>
                  </div>
                </div>
                <h3 className="text-sm font-semibold text-white mb-1">{feature.properties.title}</h3>
                <p className="text-xs text-gray-500 line-clamp-2">{feature.properties.description}</p>
              </div>
            );
          })}
        </div>

        {/* Quick Action Buttons */}
        <div className="px-6 pt-4 pb-2 bg-[#0a0a0a] border-t border-gray-800 flex gap-2">
          <button
            onClick={() => {
              setActiveFilter(activeFilter === 'actuales' ? null : 'actuales');
              setYearRange(activeFilter === 'actuales' ? [1795, 1795] : [2020, 2026]);
            }}
            className={`flex-1 flex items-center justify-center gap-2 py-2 text-xs font-bold rounded transition-colors border ${
              activeFilter === 'actuales'
                ? 'bg-red-600 hover:bg-red-700 text-white border-red-500/50'
                : 'bg-black hover:bg-[#1a1a1a] text-gray-300 border-gray-700 hover:border-gray-500'
            }`}
          >
            <Zap size={13} />
            CONFLICTOS ACTUALES
          </button>
          <button
            onClick={() => {
              setActiveFilter(activeFilter === 'historico' ? null : 'historico');
              setYearRange(activeFilter === 'historico' ? [1795, 1795] : [1795, 2026]);
            }}
            className={`flex-1 flex items-center justify-center gap-2 py-2 text-xs font-bold rounded transition-colors border ${
              activeFilter === 'historico'
                ? 'bg-red-600 hover:bg-red-700 text-white border-red-500/50'
                : 'bg-black hover:bg-[#1a1a1a] text-gray-300 border-gray-700 hover:border-gray-500'
            }`}
          >
            <History size={13} />
            HISTÓRICO TOTAL
          </button>
        </div>

        {/* Timeline Slider */}
        <div className="px-6 pb-6 pt-3 bg-[#0a0a0a]">
          <label className="text-xs text-gray-400 flex justify-between mb-4">
            <span>DESDE: <strong className="text-red-500">{yearRange[0]}</strong></span>
            <span>HASTA: <strong className="text-red-500">{yearRange[1]}</strong></span>
          </label>
          <div className="relative">
            {/* Year tooltip above thumb */}
            <div
              className="absolute -top-7 transform -translate-x-1/2 pointer-events-none"
              style={{
                left: `${((yearRange[1] - 1795) / (2026 - 1795)) * 100}%`
              }}
            >
              <span className="bg-red-600 text-white text-[11px] font-bold px-2 py-0.5 rounded shadow-lg">
                {yearRange[1]}
              </span>
            </div>
            <input 
              type="range" 
              min="1795" 
              max="2026" 
              value={yearRange[1]}
              onChange={handleYearChange}
              className="w-full h-1 bg-gray-800 rounded-lg appearance-none cursor-pointer accent-red-500"
            />
          </div>
        </div>
        </div> {/* End of minWidth wrapper */}
      </div>

      {/* Map Area */}
      <div className="flex-1 relative h-full w-full">
        <Map
          ref={mapRef}
          initialViewState={{ longitude: -0, latitude: 20, zoom: 2, pitch: 45 }}
          style={{ width: '100%', height: '100%' }}
          mapStyle={`https://api.maptiler.com/maps/hybrid/style.json?key=${MAPTILER_KEY}`}
          
          renderWorldCopies={false}
          
          
          terrain={{ source: 'terrainSource', exaggeration: 1.5 }}
        >
          {/* Relieve 3D */}
          <Source
            id="terrainSource"
            type="raster-dem"
            url={`https://api.maptiler.com/tiles/terrain-rgb-v2/tiles.json?key=${MAPTILER_KEY}`}
          />

          <Source id="interventions" type="geojson" data={filteredData}>
                        <Layer {...hoverLayerStyle} />
          </Source>

          {filteredData.features.map(feature => (
            <Marker
              key={feature.properties.id}
              longitude={feature.geometry.coordinates[0]}
              latitude={feature.geometry.coordinates[1]}
              anchor="bottom"
              onClick={e => {
                e.originalEvent.stopPropagation();
                mapRef.current?.flyTo({ center: feature.geometry.coordinates, zoom: 6 });
                setSelectedEvent(feature);
              }}
            >
              <div 
                className="relative flex items-center justify-center cursor-pointer transition-all hover:scale-125 hover:-translate-y-2 drop-shadow-[0_4px_6px_rgba(0,0,0,1)] z-10 group"
                onMouseEnter={() => setHoverInfo(feature.properties)}
                onMouseLeave={() => setHoverInfo(null)}
              >
                {/* Chincheta estilo mapa-sabores */}
                <MapPin 
                  size={32} 
                  strokeWidth={2.5} 
                  color={feature.properties.color_code || "#ff003c"} 
                  fill={feature.properties.color_code ? feature.properties.color_code + '40' : 'rgba(255, 0, 60, 0.2)'} 
                  className="transition-colors"
                />
                <div className="absolute bottom-[4px] left-1/2 -translate-x-1/2 w-1.5 h-1.5 rounded-full bg-black shadow-inner" />
              </div>
            </Marker>
          ))}


          {/* Popup Detallado con IA y Social */}
          {selectedEvent && (
            <InterventionPopup 
              feature={selectedEvent} 
              onClose={() => setSelectedEvent(null)} 
            />
          )}
        </Map>


      {/* Map Legend */}
      <div className="absolute bottom-6 right-6 bg-[#111] border border-gray-800 p-4 rounded-lg shadow-2xl z-20">
        <h4 className="text-xs text-gray-400 font-bold mb-3 uppercase tracking-wider border-b border-gray-800 pb-2">Clasificación</h4>
        <div className="space-y-2">
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#ff0000]"></div><span className="text-xs text-gray-300">Golpe de Estado</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#ff5500]"></div><span className="text-xs text-gray-300">Bombardeo</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#ff0055]"></div><span className="text-xs text-gray-300">Ocupación Militar</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#ffaa00]"></div><span className="text-xs text-gray-300">Injerencia Política</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#0088ff]"></div><span className="text-xs text-gray-300">Operación Naval</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#aa00ff]"></div><span className="text-xs text-gray-300">Operación Encubierta</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#006400]"></div><span className="text-xs text-gray-300">Acciones WW1</span></div>
          <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-[#32CD32]"></div><span className="text-xs text-gray-300">Acciones WW2</span></div>
        </div>
      </div>

      </div>
    </div>
  );
}
