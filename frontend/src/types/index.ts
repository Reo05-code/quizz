// frontend/src/types/index.ts
export interface Quiz {
  id: number;
  title: string;
  author: string;
  created_at: string;
  updated_at: string;
}

export interface Question {
  id: number;
  content: string;
  // 必要に応じて他のプロパティ（choicesなど）も追加
}
