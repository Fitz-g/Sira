import { Redirect } from 'expo-router';
import { useAuthStore } from '@/stores/auth.store';

/**
 * Point d'entrée — redirige selon l'état de session.
 * L'Expo Router gère le rendu conditionnel via les groupes de routes.
 */
export default function Index() {
  const { user, isLoading } = useAuthStore();

  if (isLoading) return null; // Splash screen natif visible pendant ce temps

  if (!user) {
    return <Redirect href="/(auth)/welcome" />;
  }

  return <Redirect href="/(tabs)/" />;
}
