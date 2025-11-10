// frontend/src/pages/Ranking.tsx
import React, { useState, useEffect } from 'react';
import { Challenger } from '../types';
import { apiClient } from '../lib/apiClient';

const Ranking: React.FC = () => {
  const [ranking, setRanking] = useState<Challenger[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchRanking = async () => {
      try {
        const response = await apiClient.get('/challengers/ranking');
        setRanking(response.data);
      } catch (err) {
        setError('ランキングの読み込みに失敗しました。');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchRanking();
  }, []);

  if (loading) {
    return <div className="text-center mt-10 text-xl">ランキング集計中...</div>;
  }

  if (error) {
    return <div className="text-center mt-10 text-yellow-300 text-xl">{error}</div>;
  }

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-4xl font-extrabold mb-8 text-center text-yellow-300 drop-shadow-lg">ランキング</h1>
      <div className="bg-white bg-opacity-10 rounded-xl p-6 max-w-md mx-auto">
        <ol>
          {ranking.map((challenger, index) => (
            <li key={challenger.id} className="flex items-center justify-between text-lg border-b border-gray-500 py-3">
              <span className="font-bold">
                {index + 1}位: {challenger.name}
              </span>
              <span className="text-yellow-300 font-bold">{challenger.score} 点</span>
            </li>
          ))}
        </ol>
      </div>
    </div>
  );
};

export default Ranking;
