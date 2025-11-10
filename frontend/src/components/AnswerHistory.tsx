import React from 'react';
import { AnswerHistoryItem } from '../types';

interface AnswerHistoryProps {
  history: AnswerHistoryItem[];
}

const AnswerHistory: React.FC<AnswerHistoryProps> = ({ history }) => {
  return (
    <div className="w-full max-w-2xl mx-auto">
      <h2 className="text-2xl font-bold mb-4 text-left">回答履歴</h2>
      <div className="bg-white shadow-md rounded-lg p-4">
        <ul className="divide-y divide-gray-200">
          {history.map((item, index) => (
            <li key={index} className="py-3 flex items-center justify-between">
              <div className="flex items-center">
                <span className="font-semibold mr-3">Q{item.questionNumber}.</span>
                <span className="truncate max-w-xs md:max-w-md">{item.questionText}</span>
              </div>
              {item.isCorrect ? (
                <span className="text-green-500 font-bold text-lg">正解</span>
              ) : (
                <span className="text-red-500 font-bold text-lg">不正解</span>
              )}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default AnswerHistory;
