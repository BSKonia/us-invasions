import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { supabase } from '../services/supabaseClient';
import { Target, Lock, Mail, AlertTriangle } from 'lucide-react';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [username, setUsername] = useState('');
  const [isLogin, setIsLogin] = useState(true);
  const [rememberMe, setRememberMe] = useState(true);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const navigate = useNavigate();

  // Check if user is already logged in and load remembered email
  useEffect(() => {
    const checkUser = async () => {
      const { data: { session } } = await supabase.auth.getSession();
      if (session) {
        navigate('/dashboard');
      }
    };
    checkUser();

    const savedEmail = localStorage.getItem('rememberedEmail');
    if (savedEmail) {
      setEmail(savedEmail);
      setRememberMe(true);
    }
  }, [navigate]);

  const handleAuth = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setSuccess(null);

    try {
      if (isLogin) {
        const { error } = await supabase.auth.signInWithPassword({ email, password });
        if (error) throw error;
        
        // Save or remove remembered email ONLY on successful login
        if (rememberMe) {
          localStorage.setItem('rememberedEmail', email);
        } else {
          localStorage.removeItem('rememberedEmail');
        }

        navigate('/dashboard');
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
        
        // Sign out automatically to force the user to log in manually
        await supabase.auth.signOut();
        
        // Switch to login view, clear password, and show success message
        setIsLogin(true);
        setPassword('');
        setSuccess("Registro exitoso. Por favor, inicia sesión con tu nueva cuenta.");
      }
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

        {success && (
          <div className="mb-4 p-3 bg-green-900/20 border border-green-500/50 text-green-400 text-xs flex items-center gap-2">
            <Target size={14} />
            {success}
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

          {/* Remember me checkbox */}
          <div className="flex items-center gap-2 mt-1">
            <input
              type="checkbox"
              id="rememberMe"
              checked={rememberMe}
              onChange={(e) => setRememberMe(e.target.checked)}
              className="w-3.5 h-3.5 accent-red-500 bg-[#0a0a0a] border-gray-700 cursor-pointer"
            />
            <label htmlFor="rememberMe" className="text-xs text-gray-500 cursor-pointer select-none">
              Recordar sesión
            </label>
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
            onClick={() => {
              setIsLogin(!isLogin);
              setError(null);
              setSuccess(null);
            }} 
            className="text-gray-500 hover:text-red-400 transition-colors cursor-pointer"
          >
            {isLogin ? '¿No tienes cuenta? Regístrate aquí.' : '¿Ya tienes cuenta? Inicia sesión aquí.'}
          </button>
        </div>
      </div>
    </div>
  );
}
