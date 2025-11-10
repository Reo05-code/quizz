// frontend/src/pages/Questions.tsx
import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { Question, Challenger } from '../types';
import { apiClient } from '../lib/apiClient';
import QuestionCard from '../components/QuestionCard';
import ChoiceButton from '../components/ChoiceButton';

const Questions: React.FC = () => {
  const { id: quizId } = useParams<{ id: string }>();
  const [challenger, setChallenger] = useState<Challenger | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [answerResult, setAnswerResult] = useState<'correct' | 'incorrect' | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);

  useEffect(() => {
    if (!quizId) return;

    const startQuiz = async () => {
      try {
        // 1. 挑戦者を作成
        const challengerResponse = await apiClient.post('/challengers', {
          challenger: { name: 'ゲスト' }, // 仮の挑戦者名
        });
        setChallenger(challengerResponse.data);

        // 2. 問題を取得
        const questionsResponse = await apiClient.get(`/quizzes/${quizId}/questions`);
        setQuestions(questionsResponse.data);
      } catch (err) {
        setError('クイズの開始に失敗しました。');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    startQuiz();
  }, [quizId]);

  const handleSelectChoice = async (choiceId: number) => {
    if (!challenger) return;
    setIsAnswered(true);

    try {
      const response = await apiClient.post(`/challengers/${challenger.id}/answers`, {
        answer: { choice_id: choiceId },
      });

      // APIレスポンスから正解かどうかを判断
      const createdAnswer = response.data;

      // HACK: 本来はanswers#createのレスポンスに正解情報を含めるべき
      // 今回は簡単のため、再度choiceを取得して判定
      const choice = currentQuestion.choices.find(c => c.id === createdAnswer.choice_id);

      if (choice?.correct_answer) {
        setAnswerResult('correct');
      } else {
        setAnswerResult('incorrect');
      }
    } catch (err) {
      setError('回答の送信に失敗しました。');
      console.error(err);
    }
  };

  const handleNext = () => {
    setAnswerResult(null);
    setIsAnswered(false);
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      alert('クイズ終了です！お疲れ様でした。');
      // ここで結果画面へ遷移
    }
  };

  if (loading) {
    return <div className="flex justify-center items-center h-screen">クイズを準備中...</div>;
  }

  if (error) {
    return <div className="flex justify-center items-center h-screen text-red-300">{error}</div>;
  }

  if (questions.length === 0) {
    return <div className="flex justify-center items-center h-screen">このクイズには問題がありません。</div>;
  }

  const currentQuestion = questions[currentIndex];

  return (
    <div className="flex flex-col items-center justify-center min-h-screen p-4">
      <div className="relative w-full max-w-2xl">
        {answerResult && (
          <div className="absolute inset-0 bg-black bg-opacity-75 flex justify-center items-center z-10 rounded-lg">
            <div className={`text-6xl font-extrabold ${answerResult === 'correct' ? 'text-green-400' : 'text-red-500'}`}>
              {answerResult === 'correct' ? '正解！' : '不正解…'}
            </div>
          </div>
        )}
        <QuestionCard question={currentQuestion} questionNumber={currentIndex + 1} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-8 w-full max-w-2xl">
        {currentQuestion.choices.map((choice) => (
          <ChoiceButton key={choice.id} choice={choice} onSelect={handleSelectChoice} disabled={isAnswered} />
        ))}
      </div>

      {isAnswered && (
        <button
          onClick={handleNext}
          className="mt-8 bg-yellow-400 text-gray-800 font-bold py-3 px-8 rounded-full shadow-lg hover:bg-yellow-500 transition-colors duration-300 animate-pulse"
        >
          {currentIndex < questions.length - 1 ? '次の問題へ' : '結果を見る'}
        </button>
      )}
    </div>
  );
};

export default Questions;
