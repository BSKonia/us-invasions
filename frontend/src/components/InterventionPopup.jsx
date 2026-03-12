import React, { useState, useEffect } from 'react';
import { Popup } from 'react-map-gl/maplibre';
import { Target, AlertTriangle, Clock, X, BrainCircuit, MessageSquare, Star, Send, RefreshCw, Shield } from 'lucide-react';
import { ExternalLink } from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import { supabase } from '../services/supabaseClient';
import { getAiSummary, getComments, addComment, getVotes, addVote, getAiSources, getBaseAiSummary, getBaseComments, addBaseComment, getBaseVotes, addBaseVote, getBaseAiSources } from '../services/apiClient';

export default function InterventionPopup({ feature, onClose }) {
  const [activeTab, setActiveTab] = useState('summary');
  const isBase = feature.properties.is_base === true;
  
  // States for AI
  const [aiSummary, setAiSummary] = useState(null);
  const [aiLoading, setAiLoading] = useState(false);
  const [aiError, setAiError] = useState(null);

  // States for Social (Comments)
  const [comments, setComments] = useState([]);
  const [newComment, setNewComment] = useState("");
  const [commentsLoading, setCommentsLoading] = useState(false);

  // States for Social (Votes)
  const [votesData, setVotesData] = useState({ averages: {}, total_votes: 0 });
  const [userVoteState, setUserVoteState] = useState({ justification: 0, success: 0, impact: 0 });
  const [votingLoading, setVotingLoading] = useState(false);


  // States for AI Sources
  const [aiSources, setAiSources] = useState(null);
  const [aiSourcesLoading, setAiSourcesLoading] = useState(false);
  const [aiSourcesError, setAiSourcesError] = useState(null);

  const [user, setUser] = useState(null);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user || null);
    });
  }, []);

  useEffect(() => {
    // Reset states when feature changes
    setAiSummary(null);
    setAiError(null);
    setComments([]);
    setVotesData({ averages: {}, total_votes: 0 });

    setUserVoteState({ justification: 0, success: 0, impact: 0 });
    setAiSources(null);
    setAiSourcesError(null);
    setActiveTab('summary');
  }, [feature]);

  useEffect(() => {
    if (activeTab === 'ai' && !aiSummary && !aiError) {
      fetchAiSummary();
    }
    if (activeTab === 'sources' && aiSources === null && !aiSourcesError) {
      fetchAiSources();
    }
    if (activeTab === 'social' && comments.length === 0) {
      fetchSocialData();
    }
  }, [activeTab, feature]);

  const fetchAiSummary = async () => {
    setAiLoading(true);
    setAiError(null);
    try {
      const data = isBase
        ? await getBaseAiSummary(feature.properties.id)
        : await getAiSummary(feature.properties.id);
      if (data && data.summary) {
        setAiSummary(data.summary);
      } else {
        setAiError("No se pudo generar el análisis. Verifica tu conexión o clave de API.");
      }
    } catch (err) {
      setAiError("Error de comunicación con el servidor de inteligencia artificial.");
    } finally {
      setAiLoading(false);
    }
  };

  const fetchAiSources = async (force = false) => {
    setAiSourcesLoading(true);
    setAiSourcesError(null);
    try {
      const data = isBase
        ? await getBaseAiSources(feature.properties.id, force)
        : await getAiSources(feature.properties.id, force);
      if (data && Array.isArray(data.sources)) {
        setAiSources(data.sources);
      } else {
        setAiSourcesError("No se pudieron generar fuentes fiables.");
      }
    } catch (err) {
      setAiSourcesError("Error al conectar con la IA para buscar archivos.");
    } finally {
      setAiSourcesLoading(false);
    }
  };

  const fetchSocialData = async () => {
    setCommentsLoading(true);
    try {
      const cData = isBase
        ? await getBaseComments(feature.properties.id)
        : await getComments(feature.properties.id);
      setComments(cData || []);
      
      const vData = isBase
        ? await getBaseVotes(feature.properties.id)
        : await getVotes(feature.properties.id);
      setVotesData(vData || { averages: {}, total_votes: 0 });
    } catch (err) {
      console.error("Error al cargar datos sociales", err);
    } finally {
      setCommentsLoading(false);
    }
  };

  const handlePostComment = async () => {
    if (!newComment.trim() || !user) return;
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) return;
      
      if (isBase) {
        await addBaseComment(feature.properties.id, newComment, session.access_token);
      } else {
        await addComment(feature.properties.id, newComment, session.access_token);
      }
      setNewComment("");
      fetchSocialData();
    } catch (err) {
      alert("Error al enviar comentario");
    }
  };

  const handleVote = async (category, score) => {
    if (!user) {
      alert("Debes iniciar sesión para votar.");
      return;
    }
    setVotingLoading(true);
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session) return;
      
      if (isBase) {
        await addBaseVote(feature.properties.id, category, score, session.access_token);
      } else {
        await addVote(feature.properties.id, category, score, session.access_token);
      }
      setUserVoteState(prev => ({ ...prev, [category]: score }));
      fetchSocialData();
    } catch (err) {
      alert("Error al registrar voto");
    } finally {
      setVotingLoading(false);
    }
  };

  const renderStars = (category, currentAverage) => {
    const userVoted = userVoteState[category] || 0;
    
    return (
      <div className="flex items-center gap-1 mt-1">
        {[1, 2, 3, 4, 5].map((star) => (
          <Star 
            key={star} 
            size={14} 
            className={`cursor-pointer transition-colors ${
              (userVoted >= star || (!userVoted && currentAverage >= star)) 
                ? 'text-yellow-500 fill-yellow-500' 
                : 'text-gray-600 hover:text-yellow-400'
            }`}
            onClick={() => handleVote(category, star)}
          />
        ))}
        <span className="text-[10px] text-gray-500 ml-2">
          {currentAverage ? currentAverage.toFixed(1) : 'S/V'}
        </span>
      </div>
    );
  };

  return (
    <Popup
      longitude={feature.geometry.coordinates[0]}
      latitude={feature.geometry.coordinates[1]}
      anchor="bottom"
      onClose={onClose}
      className="dark-popup"
      maxWidth="450px"
      closeButton={false}
    >
      <div className="bg-[#111] border border-gray-700 shadow-2xl rounded text-gray-300 w-[350px] font-mono overflow-hidden flex flex-col" style={{ maxHeight: '450px' }}>
        {/* Header */}
        <div className="flex justify-between items-center p-3 border-b border-gray-800 bg-black">
          <h3 className="font-bold text-white text-sm truncate pr-2 flex-1">{feature.properties.title}</h3>
          <button onClick={onClose} className="text-gray-500 hover:text-white shrink-0">
            <X size={16} />
          </button>
        </div>
        
        {/* Tabs */}
        <div className="flex border-b border-gray-800 text-[10px] sm:text-xs bg-black shrink-0">
          <button 
            className={`flex-1 p-2 text-center transition-colors ${activeTab === 'summary' ? 'text-red-500 border-b-2 border-red-500 bg-[#1a1a1a]' : 'hover:bg-[#1a1a1a]'}`}
            onClick={() => setActiveTab('summary')}
          >
            FICHA
          </button>
          <button 
            className={`flex-1 p-2 text-center transition-colors ${activeTab === 'sources' ? 'text-red-500 border-b-2 border-red-500 bg-[#1a1a1a]' : 'hover:bg-[#1a1a1a]'}`}
            onClick={() => setActiveTab('sources')}
          >
            FUENTES
          </button>
          <button 
            className={`flex-1 p-2 text-center transition-colors flex items-center justify-center gap-1 ${activeTab === 'ai' ? 'text-blue-400 border-b-2 border-blue-400 bg-[#1a1a1a]' : 'hover:bg-[#1a1a1a]'}`}
            onClick={() => setActiveTab('ai')}
          >
            <BrainCircuit size={12} />
            A.I.
          </button>
          <button 
            className={`flex-1 p-2 text-center transition-colors flex items-center justify-center gap-1 ${activeTab === 'social' ? 'text-yellow-500 border-b-2 border-yellow-500 bg-[#1a1a1a]' : 'hover:bg-[#1a1a1a]'}`}
            onClick={() => setActiveTab('social')}
          >
            <MessageSquare size={12} />
            DEBATE
          </button>
        </div>

        {/* Content Area */}
        <div className="p-4 overflow-y-auto text-sm custom-scrollbar flex-1" style={{ minHeight: '250px' }}>
          
          {/* TAB 1: SUMMARY */}
          {activeTab === 'summary' && (
            <div className="space-y-3 text-xs text-gray-400">
              <div className="flex items-center gap-2 text-white">
                {isBase ? (
                  <>
                    <Shield size={14} color="#00CED1" />
                    <span style={{ color: '#00CED1' }}>Base Militar</span>
                  </>
                ) : (
                  <>
                    <AlertTriangle size={14} style={{ color: feature.properties.color_code }}/>
                    <span>{feature.properties.type_name}</span>
                  </>
                )}
              </div>

              {/* Base-specific metadata */}
              {isBase && (
                <div className="grid grid-cols-2 gap-2 mt-2">
                  {feature.properties.category && (
                    <div className="bg-black border border-gray-800 rounded px-2 py-1.5">
                      <span className="text-[10px] text-gray-500 uppercase block">Categoría</span>
                      <span className="text-xs text-white">{feature.properties.category}</span>
                    </div>
                  )}
                  {feature.properties.branch && (
                    <div className="bg-black border border-gray-800 rounded px-2 py-1.5">
                      <span className="text-[10px] text-gray-500 uppercase block">Rama</span>
                      <span className="text-xs text-white">{feature.properties.branch}</span>
                    </div>
                  )}
                  {feature.properties.status && (
                    <div className="bg-black border border-gray-800 rounded px-2 py-1.5">
                      <span className="text-[10px] text-gray-500 uppercase block">Estado</span>
                      <span className={`text-xs ${feature.properties.status === 'Active' ? 'text-green-400' : feature.properties.status === 'Closed' ? 'text-red-400' : 'text-yellow-400'}`}>
                        {feature.properties.status}
                      </span>
                    </div>
                  )}
                  {feature.properties.year_established && (
                    <div className="bg-black border border-gray-800 rounded px-2 py-1.5">
                      <span className="text-[10px] text-gray-500 uppercase block">Establecida</span>
                      <span className="text-xs text-white">{feature.properties.year_established}</span>
                    </div>
                  )}
                </div>
              )}
              
              {!isBase && feature.properties.tags && (
                <div className="flex flex-wrap gap-1 mt-2">
                  {JSON.parse(feature.properties.tags).map((tag, idx) => (
                    <span key={idx} className="bg-red-900/30 text-red-400 px-1.5 py-0.5 rounded text-[10px] border border-red-900/50">
                      {tag}
                    </span>
                  ))}
                </div>
              )}

              <p className="leading-relaxed mt-3 text-gray-300">{feature.properties.description}</p>
              
              {!isBase && (
                <div className="flex items-center gap-2 pt-2 border-t border-gray-800 mt-2">
                  <Clock size={14} className="text-gray-500"/>
                  <span>{feature.properties.start_year} {feature.properties.end_year ? `- ${feature.properties.end_year}` : ''}</span>
                </div>
              )}
              {isBase && feature.properties.year_closed && (
                <div className="flex items-center gap-2 pt-2 border-t border-gray-800 mt-2">
                  <Clock size={14} className="text-gray-500"/>
                  <span>Cerrada: {feature.properties.year_closed}</span>
                </div>
              )}
            </div>
          )}
          
          {/* TAB 2: SOURCES */}
          {activeTab === 'sources' && (
            <div className="space-y-3">
              <p className="text-[10px] text-gray-500 mb-2 border-b border-gray-800 pb-2">Hemeroteca Inteligente: Archivos recuperados.</p>
              {aiSourcesLoading ? (
                <div className="flex flex-col items-center justify-center py-10 opacity-70">
                  <BrainCircuit size={32} className="text-yellow-600 animate-pulse mb-3" />
                  <p className="text-xs text-yellow-600 text-center">Buscando documentos y noticias históricas...</p>
                </div>
              ) : aiSourcesError ? (
                <p className="text-xs text-red-500 border border-red-900/50 bg-red-900/20 p-3 rounded">{aiSourcesError}</p>
               ) : aiSources && aiSources.length > 0 ? (
                 <>
                   {aiSources.map((src, i) => (
                     <div 
                       key={i} 
                       className="bg-black p-3 border border-gray-800 rounded cursor-pointer hover:border-blue-500/50 transition-colors group"
                       onClick={() => window.open(src.url, '_blank', 'noopener,noreferrer')}
                     >
                       <div className="flex justify-between items-start mb-1">
                         <span className="text-blue-400 font-bold text-xs group-hover:text-blue-300 flex items-center gap-1">
                           {src.source_name} <ExternalLink size={10} />
                         </span>
                         <span className="text-[10px] text-gray-500 bg-gray-900 px-1.5 rounded">{src.date}</span>
                       </div>
                       <p className="text-xs text-white font-semibold mb-1">{src.headline}</p>
                       <p className="text-[10px] text-gray-400 leading-tight">{src.snippet}</p>
                     </div>
                   ))}
                   <button
                     onClick={() => fetchAiSources(true)}
                     className="w-full mt-2 flex items-center justify-center gap-1 text-[10px] text-gray-500 hover:text-yellow-500 border border-gray-800 hover:border-yellow-500/50 py-1.5 rounded transition-colors cursor-pointer"
                   >
                     <RefreshCw size={10} />
                     Regenerar fuentes
                   </button>
                 </>
              ) : (
                <p className="text-xs text-gray-600 italic">No hay fuentes disponibles para este conflicto.</p>
              )}
            </div>
          )}

          {/* TAB 3: INTELIGENCIA ARTIFICIAL */}
          {activeTab === 'ai' && (
            <div className="space-y-3 relative">
              {aiLoading ? (
                <div className="flex flex-col items-center justify-center py-10 opacity-70">
                  <BrainCircuit size={32} className="text-blue-400 animate-pulse mb-3" />
                  <p className="text-xs text-blue-400">Analizando registros históricos...</p>
                </div>
              ) : aiError ? (
                <p className="text-xs text-red-500 border border-red-900/50 bg-red-900/20 p-3 rounded">{aiError}</p>
              ) : (
                <div className="prose prose-invert prose-sm max-w-none text-xs text-gray-300 leading-relaxed">
                  <div className="flex items-center gap-2 mb-3 pb-2 border-b border-gray-800">
                    <BrainCircuit size={14} className="text-blue-400" />
                    <span className="text-[10px] text-blue-400 uppercase font-bold tracking-widest">Análisis Generativo (Gemini)</span>
                  </div>
                  {aiSummary ? (
                    <ReactMarkdown>{aiSummary}</ReactMarkdown>
                  ) : (
                    <p>No se pudo obtener el resumen.</p>
                  )}
                </div>
              )}
            </div>
          )}

          {/* TAB 4: DEBATE Y VALORACIONES (TripAdvisor) */}
          {activeTab === 'social' && (
            <div className="flex flex-col h-full">
              
              {/* Votos */}
              <div className="bg-black border border-gray-800 rounded p-3 mb-4 shrink-0">
                <h4 className="text-[10px] text-gray-400 uppercase font-bold mb-2 flex justify-between items-center">
                  <span>Valoración Comunitaria</span>
                  <span className="text-gray-600">{votesData.total_votes} votos</span>
                </h4>
                <div className="space-y-2">
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-gray-300">{isBase ? '¿Necesaria?' : '¿Justificada?'}</span>
                    {renderStars('justification', votesData.averages?.justification || 0)}
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-gray-300">{isBase ? 'Importancia Estratégica' : 'Éxito Militar'}</span>
                    {renderStars('success', votesData.averages?.success || 0)}
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-gray-300">{isBase ? 'Impacto Local' : 'Impacto Civil'}</span>
                    {renderStars('impact', votesData.averages?.impact || 0)}
                  </div>
                </div>
              </div>

              {/* Comentarios */}
              <div className="flex-1 overflow-y-auto mb-2 space-y-2 border-t border-gray-800 pt-2 custom-scrollbar">
                <h4 className="text-[10px] text-gray-400 uppercase font-bold mb-2">Debate Abierto</h4>
                {commentsLoading ? (
                  <p className="text-xs text-gray-600">Cargando comentarios...</p>
                ) : comments.length > 0 ? (
                  comments.map(c => (
                    <div key={c.id} className="bg-[#1a1a1a] p-2 rounded border border-gray-800">
                      <p className="text-[10px] text-gray-500 mb-1"><span className="text-blue-400 font-bold">{c.username || 'Usuario Anónimo'}</span> • {new Date(c.created_at).toLocaleDateString()}</p>
                      <p className="text-xs text-gray-300">{c.content}</p>
                    </div>
                  ))
                ) : (
                  <p className="text-xs text-gray-600 italic">No hay comentarios aún. ¡Sé el primero!</p>
                )}
              </div>

              {/* Input Nuevo Comentario */}
              {user ? (
                <div className="flex gap-2 mt-2 shrink-0 pt-2 border-t border-gray-800 bg-[#111]">
                  <input 
                    type="text" 
                    value={newComment}
                    onChange={(e) => setNewComment(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && handlePostComment()}
                    placeholder="Escribe tu opinión..."
                    className="flex-1 bg-black border border-gray-700 rounded px-2 py-1.5 text-xs text-white focus:outline-none focus:border-yellow-500"
                  />
                  <button 
                    onClick={handlePostComment}
                    className="bg-yellow-600 hover:bg-yellow-500 text-black p-1.5 rounded transition-colors flex items-center justify-center w-8"
                  >
                    <Send size={14} />
                  </button>
                </div>
              ) : (
                <div className="mt-2 shrink-0 pt-2 text-center border-t border-gray-800">
                  <p className="text-xs text-yellow-500/80">Inicia sesión para votar y debatir.</p>
                </div>
              )}

            </div>
          )}

        </div>

      </div>
    </Popup>
  );
}