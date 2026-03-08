import React, { useState, useEffect } from 'react';
import { Popup } from 'react-map-gl/maplibre';
import { Target, AlertTriangle, Clock, X, BrainCircuit, MessageSquare, Star, Send } from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import { supabase } from '../services/supabaseClient';
import { getAiSummary, getComments, addComment, getVotes, addVote } from '../services/apiClient';

export default function InterventionPopup({ feature, onClose }) {
  const [activeTab, setActiveTab] = useState('summary');
  
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
    setActiveTab('summary');
  }, [feature]);

  useEffect(() => {
    if (activeTab === 'ai' && !aiSummary && !aiError) {
      fetchAiSummary();
    }
    if (activeTab === 'social' && comments.length === 0) {
      fetchSocialData();
    }
  }, [activeTab, feature]);

  const fetchAiSummary = async () => {
    setAiLoading(true);
    setAiError(null);
    try {
      const data = await getAiSummary(feature.properties.id);
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

  const fetchSocialData = async () => {
    setCommentsLoading(true);
    try {
      const cData = await getComments(feature.properties.id);
      setComments(cData || []);
      
      const vData = await getVotes(feature.properties.id);
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
      
      await addComment(feature.properties.id, newComment, session.access_token);
      setNewComment("");
      fetchSocialData(); // Refresh comments
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
      
      await addVote(feature.properties.id, category, score, session.access_token);
      setUserVoteState(prev => ({ ...prev, [category]: score }));
      fetchSocialData(); // Refresh averages
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
                <AlertTriangle size={14} style={{ color: feature.properties.color_code }}/>
                <span>{feature.properties.type_name}</span>
              </div>
              
              {feature.properties.tags && (
                <div className="flex flex-wrap gap-1 mt-2">
                  {JSON.parse(feature.properties.tags).map((tag, idx) => (
                    <span key={idx} className="bg-red-900/30 text-red-400 px-1.5 py-0.5 rounded text-[10px] border border-red-900/50">
                      {tag}
                    </span>
                  ))}
                </div>
              )}

              <p className="leading-relaxed mt-3 text-gray-300">{feature.properties.description}</p>
              
              <div className="flex items-center gap-2 pt-2 border-t border-gray-800 mt-2">
                <Clock size={14} className="text-gray-500"/>
                <span>{feature.properties.start_year} {feature.properties.end_year ? `- ${feature.properties.end_year}` : ''}</span>
              </div>
            </div>
          )}
          
          {/* TAB 2: SOURCES */}
          {activeTab === 'sources' && (
            <div className="space-y-3">
              {JSON.parse(feature.properties.sources || '[]').length > 0 ? (
                 JSON.parse(feature.properties.sources).map((src, i) => (
                   <div key={i} className="bg-black p-2 border border-gray-800 rounded">
                     <a href={src.url} target="_blank" rel="noreferrer" className="text-blue-400 hover:text-blue-300 text-xs font-bold block mb-1">
                       {src.source_name}
                     </a>
                     <p className="text-[10px] text-gray-500">{src.snippet}</p>
                   </div>
                 ))
              ) : (
                <p className="text-xs text-gray-600 italic">No hay fuentes desclasificadas disponibles.</p>
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
                    <span className="text-xs text-gray-300">¿Justificada?</span>
                    {renderStars('justification', votesData.averages?.justification || 0)}
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-gray-300">Éxito Militar</span>
                    {renderStars('success', votesData.averages?.success || 0)}
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-xs text-gray-300">Impacto Civil</span>
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
                      <p className="text-[10px] text-gray-500 mb-1">Usuario Anónimo • {new Date(c.created_at).toLocaleDateString()}</p>
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