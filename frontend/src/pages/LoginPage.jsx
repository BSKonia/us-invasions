import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../services/supabaseClient';
import { Target, Lock, Mail, AlertTriangle } from 'lucide-react';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [username, setUsername] = useState('');
  const [isLogin, setIsLogin] = useState(true);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const navigate = useNavigate();

    const handleAuth = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      if (isLogin) {
        const { error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) throw error;
      } else {
        if (!username.trim()) throw new Error("Debes proporcionar un Nombre de Usuario");
        
        const { data, error } = await supabase.auth.signUp({ 
            email, 
            password,
            options: { data: { username: username } }
        });
        if (error) throw error;
        
        // Crear perfil público si el usuario se ha creado
        if (data?.user) {
            const { error: profileError } = await supabase.from('profiles').insert([{ 
                id: data.user.id, 
                username: username 
            }]);
            if (profileError && profileError.code !== '23505') { // ignorar si ya existe
                console.error("Error creating profile", profileError);
            }
        }
      }
      
      navigate('/dashboard');
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#0a0a0a] flex flex-col items-center justify-center font-mono text-gray-300 relative overflow-hidden">
      {/* Background effects */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-red-900/10 rounded-full blur-[100px] pointer-events-none" />
      
      <div className="w-full max-w-md p-8 bg-[#111] border border-gray-800 shadow-2xl rounded-sm z-10 relative">
        <div className="flex flex-col items-center mb-8">
          <Target className="w-12 h-12 text-red-500 mb-2" />
          <h1 className="text-3xl font-bold text-red-500 tracking-tighter uppercase">US_Interventions</h1>
          <p className="text-xs text-gray-500 mt-1">SISTEMA DE ARCHIVOS CLASIFICADOS</p>
        </div>

        {error && (
          <div className="mb-4 p-3 bg-red-900/20 border border-red-500/50 text-red-400 text-xs flex items-center gap-2">
            <AlertTriangle size={14} />
            {error}
          </div>
        )}

        <form onSubmit={handleAuth} className="space-y-4">

          {!isLogin && (
            <div>
              <label className="block text-xs text-gray-500 mb-1">NOMBRE EN CLAVE (USERNAME)</label>
              <div className="relative">
                <Target className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-600" />
                <input 
                  type="text" 
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  required={!isLogin}
                  className="w-full bg-[#0a0a0a] border border-gray-700 text-gray-300 p-2 pl-10 focus:border-red-500 focus:outline-none focus:ring-1 focus:ring-red-500 transition-colors"
                />
              </div>
            </div>
          )}
          <div>
            <label className="block text-xs text-gray-500 mb-1">IDENTIFICACIÓN (EMAIL)</label>
            <div className="relative">
              <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-600" />
              <input 
                type="email" 
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                className="w-full bg-[#0a0a0a] border border-gray-700 text-gray-300 p-2 pl-10 focus:border-red-500 focus:outline-none focus:ring-1 focus:ring-red-500 transition-colors"
              />
            </div>
          </div>

          <div>
            <label className="block text-xs text-gray-500 mb-1">CÓDIGO DE ACCESO (PASSWORD)</label>
            <div className="relative">
              <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-600" />
              <input 
                type="password" 
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className="w-full bg-[#0a0a0a] border border-gray-700 text-gray-300 p-2 pl-10 focus:border-red-500 focus:outline-none focus:ring-1 focus:ring-red-500 transition-colors"
              />
            </div>
          </div>

          <button 
            type="submit" 
            disabled={loading}
            className="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-3 mt-4 border border-red-500 transition-colors cursor-pointer uppercase text-sm tracking-widest disabled:opacity-50"
          >
            {loading ? 'Procesando...' : (isLogin ? 'Iniciar Sesión' : 'Registrarse')}
          </button>
        </form>

        <div className="mt-6 text-center text-xs">
          <button 
            onClick={() => setIsLogin(!isLogin)} 
            className="text-gray-500 hover:text-red-400 transition-colors cursor-pointer"
          >
            {isLogin ? '¿No tienes cuenta? Regístrate aquí.' : '¿Ya tienes cuenta? Inicia sesión aquí.'}
          </button>
        </div>
      </div>
    </div>
  );
}
