import { useEffect } from 'react';
import { Stack } from 'expo-router';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { StatusBar } from 'expo-status-bar';
import { supabase } from '@/services/supabase';
import { useAuthStore } from '@/stores/auth.store';
import '../global.css';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 2,
      staleTime: 1000 * 60 * 5, // 5 minutes
    },
  },
});

export default function RootLayout() {
  const { setUser, setLoading } = useAuthStore();

  useEffect(() => {
    // Récupère la session courante au démarrage
    supabase.auth.getSession().then(({ data: { session } }) => {
      // TODO: charger le profil complet depuis Supabase si session active
      setLoading(false);
    });

    // Écoute les changements d'auth (connexion / déconnexion)
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (_event, session) => {
        if (!session) setUser(null);
        setLoading(false);
      }
    );

    return () => subscription.unsubscribe();
  }, []);

  return (
    <QueryClientProvider client={queryClient}>
      <StatusBar style="light" backgroundColor="#166534" />
      <Stack screenOptions={{ headerShown: false }} />
    </QueryClientProvider>
  );
}
