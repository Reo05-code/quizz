import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Question, Challenger, AnswerHistoryItem } from '../types';
import { apiClient } from '../lib/apiClient';
import QuestionCard from '../components/QuestionCard';
import ChoiceButton from '../components/ChoiceButton';

const Questions: React.FC = () => {
  const { id: quizId } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [challenger, setChallenger] = useState<Challenger | null>(null);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [answerResult, setAnswerResult] = useState<'correct' | 'incorrect' | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);
  const [score, setScore] = useState(0);
  const [answerHistory, setAnswerHistory] = useState<AnswerHistoryItem[]>([]);

  useEffect(() => {
    if (!quizId) return;

    const startQuiz = async () => {
      try {
        setLoading(true);
        const challengerResponse = await apiClient.post('/challengers', {
          challenger: { name: 'ゲスト' },
        });
        setChallenger(challengerResponse.data);

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
    if (!challenger || isAnswered) return;
    setIsAnswered(true);

    try {
      const response = await apiClient.post(`/challengers/${challenger.id}/answers`, {
        answer: { choice_id: choiceId },
      });

      const { correct, score: newScore } = response.data;
      setScore(newScore);
      setAnswerResult(correct ? 'correct' : 'incorrect');

      const newHistoryItem: AnswerHistoryItem = {
        questionNumber: currentIndex + 1,
        questionText: questions[currentIndex].content,
        isCorrect: correct,
      };
      setAnswerHistory([...answerHistory, newHistoryItem]);
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
      navigate('/result', { state: { score, answerHistory } });
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
      <div className="w-full max-w-2xl mb-4 text-right">
        <span className="text-2xl font-bold text-yellow-400">SCORE: {score}</span>
      </div>
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
