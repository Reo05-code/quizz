// frontend/src/components/QuizCard.tsx

import React from 'react';
import { Link } from 'react-router-dom';
import { Quiz } from '../types';

interface QuizCardProps {
  quiz: Quiz;
}

const QuizCard: React.FC<QuizCardProps> = ({ quiz }) => {
  return (
    <div className="bg-red-500 border rounded-lg p-4 shadow-md hover:shadow-lg transition-shadow">
      <Link to={`/quizzes/${quiz.id}`}>
        <h2 className="text-xl font-bold mb-2 text-gray-800">{quiz.title}</h2>
        <p className="text-gray-600">作成者: {quiz.author}</p>
      </Link>
    </div>
  );
};

export default QuizCard;
