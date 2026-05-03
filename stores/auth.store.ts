import { create } from 'zustand';
import type { UserProfile } from '@/types/models';

type AuthState = {
  user: UserProfile | null;
  isLoading: boolean;
  isOnboardingComplete: boolean;
  setUser: (user: UserProfile | null) => void;
  setLoading: (loading: boolean) => void;
  setOnboardingComplete: (complete: boolean) => void;
  reset: () => void;
};

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isLoading: true,
  isOnboardingComplete: false,
  setUser: (user) => set({ user }),
  setLoading: (isLoading) => set({ isLoading }),
  setOnboardingComplete: (isOnboardingComplete) => set({ isOnboardingComplete }),
  reset: () => set({ user: null, isLoading: false, isOnboardingComplete: false }),
}));
