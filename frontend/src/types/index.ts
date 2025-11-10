// frontend/src/types/index.ts
export interface Quiz {
  id: number;
  title: string;
  author: string;
  created_at: string;
  updated_at: string;
}

export interface Choice {
  id: number;
  content: string;
  correct_answer: boolean;
}

export interface Question {
  id: number;
  content: string;
  choices: Choice[];
}

export interface Challenger {
  id: number;
  name: string;
  score: number;
}
