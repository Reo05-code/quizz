// frontend/src/pages/QuizList.tsx
import React, { useState, useEffect } from 'react';
import { Quiz } from '../types';
import QuizCard from '../components/QuizCard';
import { apiClient } from '../lib/apiClient';

const QuizList: React.FC = () => {
  const [quizzes, setQuizzes] = useState<Quiz[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchQuizzes = async () => {
      try {
        const response = await apiClient.get('/quizzes');
        setQuizzes(response.data);
      } catch (err) {
        setError('クイズの読み込みに失敗しました。');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchQuizzes();
  }, []);

  if (loading) {
    return <div className="text-center mt-10 text-xl">読み込み中...</div>;
  }

  if (error) {
    return <div className="text-center mt-10 text-yellow-300 text-xl">{error}</div>;
  }

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-4xl font-extrabold mb-8 text-center text-yellow-300 drop-shadow-lg">クイズ一覧</h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {quizzes.map((quiz) => (
          <QuizCard key={quiz.id} quiz={quiz} />
        ))}
      </div>
    </div>
  );
};

export default QuizList;
