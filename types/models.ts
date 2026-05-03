/**
 * Modèles métier — miroir du schéma Supabase.
 * snake_case en DB → camelCase ici (transformation dans les services).
 * Montants toujours en entiers (FCFA).
 */

// --- Auth & Profil ---

export type UserProfile = {
  id: string;
  fullName: string;
  email: string;
  avatarUrl: string | null;
  // Situation financière (onboarding)
  monthlyIncome: number;       // FCFA entier
  employmentStatus: EmploymentStatus;
  currency: 'XOF';             // FCFA — seule devise supportée au MVP
  createdAt: string;
  updatedAt: string;
};

export type EmploymentStatus =
  | 'employed'
  | 'self_employed'
  | 'student'
  | 'unemployed'
  | 'retired';

// --- Transactions ---

export type Transaction = {
  id: string;
  userId: string;
  amount: number;              // FCFA entier, toujours positif
  categoryId: string;
  note: string | null;
  date: string;                // ISO date string
  createdAt: string;
};

// --- Budget ---

export type BudgetCategory = {
  id: string;
  userId: string;
  categoryId: string;
  monthlyLimit: number;        // FCFA entier
  month: string;               // Format: "2026-04"
};

// --- Dettes ---

export type Debt = {
  id: string;
  userId: string;
  creditorName: string;
  totalAmount: number;         // FCFA entier — montant initial
  remainingAmount: number;     // FCFA entier — solde actuel
  monthlyPayment: number;      // FCFA entier
  interestRate: number | null; // Float 0-1 (ex: 0.15 = 15%)
  startDate: string | null;
  createdAt: string;
};

export type DebtPayment = {
  id: string;
  debtId: string;
  amount: number;              // FCFA entier
  paidAt: string;
};

// --- Objectifs d'épargne ---

export type SavingsGoal = {
  id: string;
  userId: string;
  name: string;
  targetAmount: number;        // FCFA entier
  currentAmount: number;       // FCFA entier — cumulé des versements
  targetDate: string;          // ISO date string
  isArchived: boolean;
  createdAt: string;
};

export type GoalContribution = {
  id: string;
  goalId: string;
  amount: number;              // FCFA entier
  paidAt: string;
};

// --- Simulation ---

export type Simulation = {
  id: string;
  userId: string;
  name: string | null;
  params: SimulationParams;
  result: SimulationResult;
  createdAt: string;
};

export type SimulationParams = {
  objectiveType: 'epargne' | 'investissement' | 'retraite' | 'projet' | 'dette';
  targetAmount: number;        // FCFA entier
  durationMonths: number;
  initialAmount: number;       // FCFA entier
  annualRate: number;          // Float 0-1
};

export type SimulationResult = {
  monthlyContribution: number; // FCFA entier — ce qu'il faut épargner/mois
  finalAmount: number;         // FCFA entier — montant final projeté
  realReturnRate: number;      // Après inflation
  monthlyData: SimulationDataPoint[];
};

export type SimulationDataPoint = {
  month: number;
  amount: number;              // FCFA entier
};

// --- Abonnement ---

export type SubscriptionPlan = 'free' | 'premium';

export type Subscription = {
  id: string;
  userId: string;
  plan: SubscriptionPlan;
  billingCycle: 'monthly' | 'yearly' | 'lifetime';
  status: 'active' | 'expired' | 'cancelled';
  currentPeriodEnd: string | null;
  createdAt: string;
};
