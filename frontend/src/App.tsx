import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import QuizList from './pages/QuizList';
import './App.css';

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-yellow-100">
        <Routes>
          <Route path="/" element={<QuizList />} />
          {/* 他のクイズ関連のルートをここに追加 */}
        </Routes>
      </div>
    </Router>
  );
}

export default App;
