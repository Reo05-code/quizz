// frontend/src/components/QuestionCard.tsx
import React from 'react';
import { Question } from '../types';

interface QuestionCardProps {
  question: Question;
}

const QuestionCard: React.FC<QuestionCardProps> = ({ question }) => {
  return (
    <div className="bg-white text-gray-800 rounded-lg shadow-xl p-8 w-full max-w-2xl text-center">
      <p className="text-2xl font-bold">{question.content}</p>
    </div>
  );
};

export default QuestionCard;
