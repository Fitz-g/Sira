import { create } from 'zustand';
import type { SubscriptionPlan } from '@/types/models';

type SubscriptionState = {
  plan: SubscriptionPlan;
  setPlan: (plan: SubscriptionPlan) => void;
  isPremium: () => boolean;
};

export const useSubscriptionStore = create<SubscriptionState>((set, get) => ({
  plan: 'free',
  setPlan: (plan) => set({ plan }),
  isPremium: () => get().plan === 'premium',
}));
