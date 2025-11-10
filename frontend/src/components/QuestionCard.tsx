// frontend/src/components/QuestionCard.tsx
import React from 'react';
import { Question } from '../types';

interface QuestionCardProps {
  question: Question;
  questionNumber: number;
}

const QuestionCard: React.FC<QuestionCardProps> = ({ question, questionNumber }) => {
  return (
    <div className="bg-white text-gray-800 rounded-lg shadow-xl p-8 w-full">
      <div className="text-xl font-bold mb-4 text-blue-600">第{questionNumber}問</div>
      <p className="text-2xl font-bold text-center">{question.content}</p>
    </div>
  );
};

export default QuestionCard;
