import React from 'react'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import MapDashboard from './components/MapDashboard'
import LoginPage from './pages/LoginPage'
import DashboardPage from './pages/DashboardPage'

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Navigate to="/login" replace />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/map" element={<MapDashboard />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
