import React, { useState, useEffect, useRef, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import Map, { Source, Layer, Popup, Marker } from 'react-map-gl/maplibre';
import 'maplibre-gl/dist/maplibre-gl.css';
import { getInterventions, getMilitaryBases } from '../services/apiClient';
import { supabase } from '../services/supabaseClient';
import { Target, AlertTriangle, Clock, X, ArrowLeft, Eye, TrendingUp, ChevronLeft, ChevronRight, LayoutDashboard, MapPin, Zap, MessageSquare, History, Filter, Shield, Sun, Moon, ChevronDown, ChevronUp, Menu } from 'lucide-react';
import InterventionPopup from './InterventionPopup';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';

const MAPTILER_KEY = import.meta.env.VITE_MAPTILER_KEY || 'Pw2ozdqe8K3Hu9Qg6OkX';

// Categorías y subtipos de intervención (fuente de verdad para leyenda y filtro)
const CONFLICT_CATEGORIES = [
  {
    category: 'Militar',
    color: '#ff2020',   // color representativo de la categoría
    types: [
      { name: 'Bombardeo', color: '#ff5500' },
      { name: 'Ocupación Militar', color: '#ff0055' },
      { name: 'Operación Naval', color: '#0088ff' },
      { name: 'Operación Encubierta', color: '#aa00ff' },
      { name: 'Acciones WW1', color: '#8B6914' },
      { name: 'Acciones WW2', color: '#B8860B' },
    ],
  },
  {
    category: 'Político',
    color: '#ffaa00',
    types: [
      { name: 'Golpe de Estado', color: '#ff0000' },
      { name: 'Injerencia Política', color: '#ffaa00' },
    ],
  },
  {
    category: 'Económico',
    color: '#00C853',
    types: [
      { name: 'Embargo', color: '#00C853' },
      { name: 'Desestabilización', color: '#00E676' },
      { name: 'Sanciones', color: '#69F0AE' },
    ],
  },
];

// Flat list of all types (for backwards compatibility)
const CONFLICT_TYPES = CONFLICT_CATEGORIES.flatMap(cat => cat.types);

// Map from type name to its parent category name
const TYPE_TO_CATEGORY = {};
CONFLICT_CATEGORIES.forEach(cat => {
  cat.types.forEach(t => { TYPE_TO_CATEGORY[t.name] = cat.category; });
});

// Map from category name to array of type names
const CATEGORY_TYPE_NAMES = {};
CONFLICT_CATEGORIES.forEach(cat => {
  CATEGORY_TYPE_NAMES[cat.category] = cat.types.map(t => t.name);
});

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
  const [selectedFilter, setSelectedFilter] = useState(null); // null = all, category name, or type name
  const [showBases, setShowBases] = useState(false);
  const [basesData, setBasesData] = useState({ type: "FeatureCollection", features: [] });
  const [darkMode, setDarkMode] = useState(true);
  const [legendCollapsed, setLegendCollapsed] = useState(false);
  const [mobileSidebarOpen, setMobileSidebarOpen] = useState(false);

  // Resolve which type names are active based on selectedFilter
  const activeTypeNames = useMemo(() => {
    if (!selectedFilter) return null; // null = show all
    // Check if it's a category name
    if (CATEGORY_TYPE_NAMES[selectedFilter]) {
      return CATEGORY_TYPE_NAMES[selectedFilter];
    }
    // Otherwise it's a single type name
    return [selectedFilter];
  }, [selectedFilter]);

  useEffect(() => {
    checkUser();
    loadData();
    loadBases();
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

  const loadBases = async () => {
    const geojsonBases = await getMilitaryBases();
    setBasesData(geojsonBases);
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
    // Filter by conflict type(s) or category
    if (activeTypeNames) {
      features = features.filter(f => activeTypeNames.includes(f.properties.type_name));
    }
    // Filter by year range
    features = features.filter(f => f.properties.start_year >= yearRange[0] && f.properties.start_year <= yearRange[1]);
    
    // Sort chronologically for the sidebar
    features = features.sort((a, b) => b.properties.start_year - a.properties.start_year);

    return {
      ...data,
      features
    };
  }, [data, showOnlyCommented, commentedIds, yearRange, activeTypeNames]);

  // Data for Global Tension Index (events per 25-year period)
  // Respects the selectedFilter
  const chartData = useMemo(() => {
    let features = data.features;
    if (activeTypeNames) {
      features = features.filter(f => activeTypeNames.includes(f.properties.type_name));
    }
    const periods = {};
    features.forEach(f => {
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
  }, [data.features, activeTypeNames]);

  // Counts per type AND per category (respecting yearRange) for the filter dropdown
  const typeCounts = useMemo(() => {
    const yearFiltered = data.features.filter(
      f => f.properties.start_year >= yearRange[0] && f.properties.start_year <= yearRange[1]
    );
    const counts = {};
    const categoryCounts = {};
    yearFiltered.forEach(f => {
      const t = f.properties.type_name;
      counts[t] = (counts[t] || 0) + 1;
      const cat = TYPE_TO_CATEGORY[t];
      if (cat) {
        categoryCounts[cat] = (categoryCounts[cat] || 0) + 1;
      }
    });
    counts._total = yearFiltered.length;
    counts._categories = categoryCounts;
    return counts;
  }, [data.features, yearRange]);

  // Determine bar chart color based on filter selection
  const chartBarColor = useMemo(() => {
    if (!selectedFilter) return '#ff003c';
    // If it's a category, use category color
    const cat = CONFLICT_CATEGORIES.find(c => c.category === selectedFilter);
    if (cat) return cat.color;
    // If it's a type, use type color
    const type = CONFLICT_TYPES.find(t => t.name === selectedFilter);
    if (type) return type.color;
    return '#ff003c';
  }, [selectedFilter]);

  // Map style URL based on dark/light mode
  const mapStyleUrl = useMemo(() => {
    return darkMode
      ? `https://api.maptiler.com/maps/hybrid/style.json?key=${MAPTILER_KEY}`
      : `https://api.maptiler.com/maps/streets/style.json?key=${MAPTILER_KEY}`;
  }, [darkMode]);

  // Legend: determine which categories/types to show based on filter
  const legendCategories = useMemo(() => {
    if (!selectedFilter) return CONFLICT_CATEGORIES; // show all
    // If a category is selected, show only that category
    const cat = CONFLICT_CATEGORIES.find(c => c.category === selectedFilter);
    if (cat) return [cat];
    // If a single type is selected, show its parent category but only that type
    const parentCat = CONFLICT_CATEGORIES.find(c => c.types.some(t => t.name === selectedFilter));
    if (parentCat) {
      return [{
        ...parentCat,
        types: parentCat.types.filter(t => t.name === selectedFilter),
      }];
    }
    return CONFLICT_CATEGORIES;
  }, [selectedFilter]);

  return (
    <div className="flex h-screen w-full bg-[#0a0a0a] text-gray-300 font-mono overflow-hidden relative">
      
      {/* Mobile hamburger button (visible on small screens when sidebar closed) */}
      <button 
        onClick={() => { setIsSidebarOpen(true); setMobileSidebarOpen(true); }}
        className="md:hidden absolute top-4 left-4 z-30 bg-[#111] border border-gray-700 text-gray-400 p-2 rounded shadow-2xl hover:text-white hover:border-gray-500 transition-colors"
        style={{ display: isSidebarOpen ? 'none' : 'flex' }}
        title="Abrir Panel"
      >
        <Menu size={22} />
      </button>

      {/* Desktop floating toggle (visible on md+ when sidebar closed) */}
      {!isSidebarOpen && (
        <button 
          onClick={() => setIsSidebarOpen(true)}
          className="hidden md:flex absolute top-4 left-4 z-20 bg-[#111] border border-gray-700 text-gray-400 p-2 rounded shadow-2xl hover:text-white hover:border-gray-500 transition-colors"
          title="Abrir Panel"
        >
          <ChevronRight size={24} />
        </button>
      )}

      {/* Mobile overlay backdrop */}
      {isSidebarOpen && mobileSidebarOpen && (
        <div 
          className="md:hidden fixed inset-0 bg-black/60 z-20 backdrop-blur-sm"
          onClick={() => { setIsSidebarOpen(false); setMobileSidebarOpen(false); }}
        />
      )}

      {/* Sidebar (Activity Feed) */}
      <div className={`transition-all duration-300 ease-in-out flex flex-col bg-[#111] border-r border-gray-800 shadow-2xl
        ${isSidebarOpen 
          ? 'fixed md:relative inset-y-0 left-0 z-30 md:z-10 w-[85vw] sm:w-[70vw] md:w-1/3 md:max-w-md' 
          : 'w-0 border-r-0'
        }`}
      >
        <div style={{ minWidth: '280px', width: '100%', height: '100%', display: isSidebarOpen ? 'flex' : 'none', flexDirection: 'column' }}>
        <div className="p-4 md:p-6 border-b border-gray-800 relative">
          <div className="flex justify-between items-start mb-4">
            <button 
              onClick={() => navigate('/dashboard')}
              className="flex items-center gap-2 text-xs font-bold bg-black border border-gray-700 text-gray-400 px-3 py-1.5 rounded hover:text-white hover:border-gray-500 transition-colors"
            >
              <LayoutDashboard size={14} />
              <span className="hidden sm:inline">VOLVER AL DASHBOARD</span>
              <span className="sm:hidden">DASHBOARD</span>
            </button>

            <button 
              onClick={() => { setIsSidebarOpen(false); setMobileSidebarOpen(false); }}
              className="text-gray-500 hover:text-white transition-colors p-1"
              title="Minimizar Panel"
            >
              <ChevronLeft size={20} />
            </button>
          </div>
          
          <h1 className="text-xl md:text-2xl font-bold text-red-500 tracking-tighter flex items-center gap-2 uppercase">
            <Target className="w-5 h-5 md:w-6 md:h-6 shrink-0" />
            US_Interventions
          </h1>
          <p className="text-xs text-gray-500 mt-2 hidden sm:block">REGISTRO DE INTERVENCIONES E INJERENCIAS CLASIFICADAS</p>
          
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
              <span className="hidden sm:inline">{showOnlyCommented ? 'MOSTRANDO SÓLO INTERVENCIONES COMENTADAS' : 'MOSTRAR SÓLO INTERVENCIONES COMENTADAS'}</span>
              <span className="sm:hidden">{showOnlyCommented ? 'SOLO COMENTADAS' : 'FILTRAR COMENTADAS'}</span>
            </button>
          )}

          {/* Filtro por tipo de conflicto con categorías */}
          <div className="mt-3 relative">
            <div className="flex items-center gap-2 mb-1.5">
              <Filter size={12} className="text-gray-500" />
              <span className="text-[10px] text-gray-500 uppercase tracking-wider">Filtrar por tipo de conflicto</span>
            </div>
            <select
              value={selectedFilter || ''}
              onChange={(e) => setSelectedFilter(e.target.value || null)}
              className="w-full bg-black border border-gray-700 text-xs text-gray-300 px-3 py-2 rounded appearance-none cursor-pointer hover:border-gray-500 focus:border-red-500 focus:outline-none transition-colors"
              style={{ backgroundImage: `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23666' stroke-width='2'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E")`, backgroundRepeat: 'no-repeat', backgroundPosition: 'right 10px center' }}
            >
              <option value="">Todos los tipos ({typeCounts._total || 0})</option>
              {CONFLICT_CATEGORIES.map(cat => (
                <optgroup key={cat.category} label={`── ${cat.category} ──`}>
                  <option value={cat.category}>
                    {cat.category} — Todos ({typeCounts._categories?.[cat.category] || 0})
                  </option>
                  {cat.types.map(ct => (
                    <option key={ct.name} value={ct.name}>
                      {'    '}{ct.name} ({typeCounts[ct.name] || 0})
                    </option>
                  ))}
                </optgroup>
              ))}
            </select>
          </div>

          {/* Toggle Bases Militares */}
          <button
            onClick={() => setShowBases(!showBases)}
            className={`mt-3 w-full flex items-center justify-center gap-2 py-2 text-xs font-bold transition-colors border ${
              showBases
              ? 'bg-[#00CED1]/15 text-[#00CED1] border-[#00CED1]/50'
              : 'bg-black text-gray-400 border-gray-700 hover:border-gray-500'
            }`}
          >
            <Shield size={14} />
            {showBases ? `BASES MILITARES (${basesData.features.length})` : `MOSTRAR BASES MILITARES (${basesData.features.length})`}
          </button>

          {/* Global Tension Index Chart */}
          <div className="mt-6 pt-4 border-t border-gray-800">
            <h3 className="text-xs text-gray-400 mb-2 flex items-center gap-2">
              <TrendingUp size={14} className="text-red-500" />
              ÍNDICE DE ACTIVIDAD GLOBAL
            </h3>
            <div className="h-16 w-full">
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
                  <Bar dataKey="events" fill={chartBarColor} radius={[2, 2, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        <div className="flex-1 overflow-y-auto p-3 md:p-4 space-y-3 custom-scrollbar">
          <h3 className="text-[10px] text-gray-500 uppercase tracking-widest font-bold px-1">SUGERENCIAS</h3>
          {filteredData.features.map((feature) => {
            const hasCommented = commentedIds.includes(feature.properties.id);
            return (
              <div 
                key={feature.properties.id}
                className={`p-3 md:p-4 bg-[#1a1a1a] border rounded cursor-pointer transition-all hover:bg-[#222] ${
                  hasCommented ? 'border-red-500/30' : 'border-gray-800 hover:border-gray-600'
                }`}
                onMouseEnter={() => setHoverInfo(feature.properties)}
                onMouseLeave={() => setHoverInfo(null)}
                onClick={() => {
                  mapRef.current?.flyTo({ center: feature.geometry.coordinates, zoom: 6 });
                  setSelectedEvent(feature);
                  // Close sidebar on mobile when selecting an event
                  if (window.innerWidth < 768) {
                    setIsSidebarOpen(false);
                    setMobileSidebarOpen(false);
                  }
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
        <div className="px-4 md:px-6 pt-4 pb-2 bg-[#0a0a0a] border-t border-gray-800 flex gap-2">
          <button
            onClick={() => {
              setActiveFilter(activeFilter === 'actuales' ? null : 'actuales');
              setYearRange(activeFilter === 'actuales' ? [1795, 1795] : [2020, 2026]);
            }}
            className={`flex-1 flex items-center justify-center gap-1 md:gap-2 py-2 text-[10px] md:text-xs font-bold rounded transition-colors border ${
              activeFilter === 'actuales'
                ? 'bg-red-600 hover:bg-red-700 text-white border-red-500/50'
                : 'bg-black hover:bg-[#1a1a1a] text-gray-300 border-gray-700 hover:border-gray-500'
            }`}
          >
            <Zap size={13} />
            <span className="hidden sm:inline">CONFLICTOS ACTUALES</span>
            <span className="sm:hidden">ACTUALES</span>
          </button>
          <button
            onClick={() => {
              setActiveFilter(activeFilter === 'historico' ? null : 'historico');
              setYearRange(activeFilter === 'historico' ? [1795, 1795] : [1795, 2026]);
            }}
            className={`flex-1 flex items-center justify-center gap-1 md:gap-2 py-2 text-[10px] md:text-xs font-bold rounded transition-colors border ${
              activeFilter === 'historico'
                ? 'bg-red-600 hover:bg-red-700 text-white border-red-500/50'
                : 'bg-black hover:bg-[#1a1a1a] text-gray-300 border-gray-700 hover:border-gray-500'
            }`}
          >
            <History size={13} />
            <span className="hidden sm:inline">HISTÓRICO TOTAL</span>
            <span className="sm:hidden">HISTÓRICO</span>
          </button>
        </div>

        {/* Timeline Slider */}
        <div className="px-4 md:px-6 pb-4 md:pb-6 pt-3 bg-[#0a0a0a]">
          <label className="text-xs text-gray-400 flex justify-between mb-6">
            <span>DESDE: <strong className="text-red-500">{yearRange[0]}</strong></span>
            <span>HASTA: <strong className="text-red-500">{yearRange[1]}</strong></span>
          </label>
          <div className="relative">
            {/* Year tooltip above thumb */}
            <div
              className="absolute -top-5 transform -translate-x-1/2 pointer-events-none"
              style={{
                left: `${((yearRange[1] - 1795) / (2026 - 1795)) * 100}%`
              }}
            >
              <span className="bg-red-600 text-white text-[9px] font-bold px-1.5 py-0.5 rounded">
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
          mapStyle={mapStyleUrl}
          
          renderWorldCopies={false}
          
          
          terrain={darkMode ? { source: 'terrainSource', exaggeration: 1.5 } : undefined}
        >
          {/* Relieve 3D (solo en dark mode con satélite) */}
          {darkMode && (
            <Source
              id="terrainSource"
              type="raster-dem"
              url={`https://api.maptiler.com/tiles/terrain-rgb-v2/tiles.json?key=${MAPTILER_KEY}`}
            />
          )}

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
                className="relative flex items-center justify-center cursor-pointer transition-all hover:scale-110 hover:-translate-y-1 z-10"
                style={{ filter: 'drop-shadow(0 2px 3px rgba(0,0,0,0.8))' }}
                onMouseEnter={() => setHoverInfo(feature.properties)}
                onMouseLeave={() => setHoverInfo(null)}
              >
                <MapPin 
                  size={22} 
                  strokeWidth={2} 
                  color={feature.properties.color_code || "#ff003c"} 
                  fill={feature.properties.color_code ? feature.properties.color_code + '30' : 'rgba(255, 0, 60, 0.15)'} 
                  className="transition-colors"
                />
              </div>
            </Marker>
          ))}


          {/* Military Base Markers */}
          {showBases && basesData.features.map(feature => (
            <Marker
              key={`base-${feature.properties.id}`}
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
                className="relative flex items-center justify-center cursor-pointer transition-all hover:scale-110 hover:-translate-y-1 z-10"
                style={{ filter: 'drop-shadow(0 2px 3px rgba(0,0,0,0.8))' }}
                onMouseEnter={() => setHoverInfo(feature.properties)}
                onMouseLeave={() => setHoverInfo(null)}
              >
                <Shield 
                  size={18} 
                  strokeWidth={2} 
                  color="#00CED1"
                  fill="rgba(0, 206, 209, 0.2)"
                  className="transition-colors"
                />
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

        {/* Dark/Light Mode Toggle - top right of map */}
        <button
          onClick={() => setDarkMode(!darkMode)}
          className={`absolute top-4 right-4 z-20 p-2.5 rounded-lg shadow-2xl border transition-all duration-300 ${
            darkMode 
              ? 'bg-[#111] border-gray-700 text-gray-400 hover:text-yellow-400 hover:border-yellow-500/50' 
              : 'bg-white border-gray-300 text-gray-600 hover:text-gray-900 hover:border-gray-400'
          }`}
          title={darkMode ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro'}
        >
          {darkMode ? <Sun size={18} /> : <Moon size={18} />}
        </button>

      {/* Map Legend - Collapsible */}
      <div className={`absolute z-20 transition-all duration-300 ${
        legendCollapsed 
          ? 'bottom-6 right-4 md:right-6' 
          : 'bottom-6 right-4 md:right-6 max-w-[200px] md:max-w-xs'
      }`}>
        {legendCollapsed ? (
          /* Collapsed: just show a small button */
          <button
            onClick={() => setLegendCollapsed(false)}
            className={`p-2.5 rounded-lg shadow-2xl border transition-colors ${
              darkMode 
                ? 'bg-[#111] border-gray-700 text-gray-400 hover:text-white hover:border-gray-500' 
                : 'bg-white border-gray-300 text-gray-600 hover:text-gray-900 hover:border-gray-400'
            }`}
            title="Mostrar leyenda"
          >
            <ChevronUp size={16} />
          </button>
        ) : (
          /* Expanded legend */
          <div className={`p-3 md:p-4 rounded-lg shadow-2xl border ${
            darkMode ? 'bg-[#111] border-gray-800' : 'bg-white border-gray-300'
          }`}>
            <div className="flex justify-between items-center mb-3 border-b pb-2" style={{ borderColor: darkMode ? '#1f2937' : '#d1d5db' }}>
              <h4 className={`text-xs font-bold uppercase tracking-wider ${darkMode ? 'text-gray-400' : 'text-gray-600'}`}>Clasificación</h4>
              <button 
                onClick={() => setLegendCollapsed(true)}
                className={`p-0.5 rounded transition-colors ${darkMode ? 'text-gray-500 hover:text-white' : 'text-gray-400 hover:text-gray-700'}`}
                title="Minimizar leyenda"
              >
                <ChevronDown size={14} />
              </button>
            </div>
            <div className="space-y-2 md:space-y-3">
              {legendCategories.map(cat => (
                <div key={cat.category}>
                  <h5 className="text-[10px] font-bold uppercase tracking-wider mb-1 md:mb-1.5" style={{ color: cat.color }}>
                    {cat.category}
                  </h5>
                  <div className="space-y-0.5 md:space-y-1 pl-1">
                    {cat.types.map(ct => (
                      <div key={ct.name} className="flex items-center gap-2">
                        <div className="w-2 h-2 md:w-2.5 md:h-2.5 rounded-full shrink-0" style={{ backgroundColor: ct.color }}></div>
                        <span className={`text-[10px] md:text-[11px] ${darkMode ? 'text-gray-300' : 'text-gray-700'}`}>{ct.name}</span>
                      </div>
                    ))}
                  </div>
                </div>
              ))}
              {showBases && (
                <div className="border-t pt-2 mt-2" style={{ borderColor: darkMode ? '#1f2937' : '#d1d5db' }}>
                  <div className="flex items-center gap-2">
                    <Shield size={12} color="#00CED1" fill="rgba(0, 206, 209, 0.2)" />
                    <span className={`text-[10px] md:text-[11px] ${darkMode ? 'text-gray-300' : 'text-gray-700'}`}>Base Militar ({basesData.features.length})</span>
                  </div>
                </div>
              )}
            </div>
          </div>
        )}
      </div>

      </div>
    </div>
  );
}
