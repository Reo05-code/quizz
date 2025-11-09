// frontend/src/pages/Questions.tsx
import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { Question } from '../types';
import { apiClient } from '../lib/apiClient';
import QuestionCard from '../components/QuestionCard';

const Questions: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!id) return;
    const fetchQuestions = async () => {
      try {
        const response = await apiClient.get(`/quizzes/${id}/questions`);
        setQuestions(response.data);
      } catch (err) {
        setError('問題の読み込みに失敗しました。');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchQuestions();
  }, [id]);

  const handleNext = () => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      // クイズ終了時の処理（例: 結果画面へ遷移）
      alert('クイズ終了です！');
    }
  };

  if (loading) {
    return <div className="flex justify-center items-center h-screen">読み込み中...</div>;
  }

  if (error) {
    return <div className="flex justify-center items-center h-screen text-red-500">{error}</div>;
  }

  if (questions.length === 0) {
    return <div className="flex justify-center items-center h-screen">このクイズには問題がありません。</div>;
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen p-4">
      <QuestionCard question={questions[currentIndex]} />
      <button
        onClick={handleNext}
        className="mt-8 bg-yellow-400 text-gray-800 font-bold py-3 px-8 rounded-full shadow-lg hover:bg-yellow-500 transition-colors duration-300"
      >
        {currentIndex < questions.length - 1 ? '次へ' : '結果を見る'}
      </button>
    </div>
  );
};

export default Questions;
