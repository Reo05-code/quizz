// frontend/src/components/QuizCard.tsx
import React from 'react';
import { Link } from 'react-router-dom';
import { Quiz } from '../types';

interface QuizCardProps {
  quiz: Quiz;
}

const QuizCard: React.FC<QuizCardProps> = ({ quiz }) => {
  return (
    <Link to={`/quizzes/${quiz.id}/questions`} className="block">
      <div
        className="bg-blue-500 border-4 border-blue-400 rounded-xl p-5 shadow-lg transform hover:scale-105 hover:shadow-2xl transition-all duration-300 ease-in-out"
      >
        <h2 className="text-2xl font-bold mb-2 text-white truncate">{quiz.title}</h2>
        <p className="text-yellow-300 font-semibold">作成者: {quiz.author}</p>
      </div>
    </Link>
  );
};export default QuizCard;
