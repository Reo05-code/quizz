// frontend/src/components/ChoiceButton.tsx
import React from 'react';
import { Choice } from '../types';

interface ChoiceButtonProps {
  choice: Choice;
  onSelect: (choiceId: number) => void;
  disabled: boolean;
}

const ChoiceButton: React.FC<ChoiceButtonProps> = ({ choice, onSelect, disabled }) => {
  return (
    <button
      onClick={() => onSelect(choice.id)}
      disabled={disabled}
      className="w-full bg-white text-blue-800 font-semibold py-3 px-6 rounded-lg shadow-md hover:bg-blue-100 disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
    >
      {choice.content}
    </button>
  );
};

export default ChoiceButton;
