import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import QuizList from './pages/QuizList';
import Questions from './pages/Questions';
import Ranking from './pages/Ranking'; // 追加
import './App.css';

function App() {
  return (
    <Router>
      <div className="min-h-screen">
        <nav className="p-4 text-right">
          <Link to="/ranking" className="text-white font-bold hover:text-yellow-300 transition-colors">ランキングを見る</Link>
        </nav>
        <Routes>
          <Route path="/" element={<QuizList />} />
          <Route path="/quizzes/:id/questions" element={<Questions />} />
          <Route path="/ranking" element={<Ranking />} /> {/* 追加 */}
        </Routes>
      </div>
    </Router>
  );
}

export default App;
