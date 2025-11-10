import React from 'react';
import { useLocation } from 'react-router-dom';
import AnswerHistory from '../components/AnswerHistory';
import { AnswerHistoryItem } from '../types';

const Result: React.FC = () => {
  const location = useLocation();
  const { score, answerHistory } = (location.state || { score: 0, answerHistory: [] }) as {
    score: number;
    answerHistory: AnswerHistoryItem[];
  };

  return (
    <div className="container mx-auto p-4 text-center">
      <h1 className="text-4xl font-bold mb-4">クイズ結果</h1>
      <div className="bg-white shadow-md rounded-lg p-6 mb-8">
        <h2 className="text-2xl font-semibold mb-2">あなたのスコア</h2>
        <p className="text-5xl font-bold text-yellow-500">{score}</p>
      </div>
      <AnswerHistory history={answerHistory} />
    </div>
  );
};

export default Result;
