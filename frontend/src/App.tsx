import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import QuizList from './pages/QuizList';
import Questions from './pages/Questions';
import './App.css';

function App() {
  return (
    <Router>
      <div className="min-h-screen">
        <Routes>
          <Route path="/" element={<QuizList />} />
          <Route path="/quizzes/:id/questions" element={<Questions />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
