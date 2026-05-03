import React from 'react';
import { View, Text, Pressable } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from 'react-native-reanimated';

type CardVariant = 'default' | 'info';

type CardProps = {
  children: React.ReactNode;
  variant?: CardVariant;
  onPress?: () => void;
  className?: string;
};

/**
 * Card — conteneur visuel de base.
 *
 * variant="default"  → fond blanc, bordure légère (metric, preview, recap, list-item)
 * variant="info"     → fond teinté vert + bord gauche coloré (insight IA, motivation)
 *
 * Pour les layouts internes (MetricRow, RecapRow, etc.) → voir les composants features/.
 * DS: card.component.md
 */
export function Card({
  children,
  variant = 'default',
  onPress,
  className = '',
}: CardProps) {
  const scale = useSharedValue(1);
  const opacity = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
    opacity: opacity.value,
  }));

  const handlePressIn = () => {
    if (!onPress) return;
    scale.value = withTiming(0.98, { duration: 150 });
    opacity.value = withTiming(0.85, { duration: 150 });
  };

  const handlePressOut = () => {
    if (!onPress) return;
    scale.value = withTiming(1, { duration: 150 });
    opacity.value = withTiming(1, { duration: 150 });
  };

  const containerStyle = {
    backgroundColor: variant === 'info' ? '#f0fdf4' : '#ffffff',
    borderRadius: 12,
    borderWidth: 1,
    borderColor: variant === 'info' ? '#166534' + '33' : '#d4d4d4',
    padding: 16,
    // Bord gauche coloré pour les cards info
    ...(variant === 'info' && {
      borderLeftWidth: 4,
      borderLeftColor: '#166534',
    }),
  };

  if (onPress) {
    return (
      <Animated.View style={animatedStyle}>
        <Pressable
          onPress={onPress}
          onPressIn={handlePressIn}
          onPressOut={handlePressOut}
          style={containerStyle}
          accessibilityRole="button"
        >
          {children}
        </Pressable>
      </Animated.View>
    );
  }

  return (
    <View style={containerStyle}>
      {children}
    </View>
  );
}

// ---
// Sous-composants utilitaires pour les layouts internes des cards
// ---

/**
 * Ligne de métriques — 2 à 4 colonnes alignées.
 * Usage: <MetricRow items={[{ label: 'Revenus', value: '150 000 FCFA' }]} />
 */
type MetricItem = {
  label: string;
  value: string;
  valueColor?: string;
};

export function MetricRow({ items }: { items: MetricItem[] }) {
  return (
    <View className="flex-row">
      {items.map((item, index) => (
        <React.Fragment key={item.label}>
          {index > 0 && (
            <View style={{ width: 1, backgroundColor: '#d4d4d4', marginHorizontal: 12 }} />
          )}
          <View className="flex-1 items-center">
            <Text className="text-neutral-500 text-[14px] mb-1" numberOfLines={1}>
              {item.label}
            </Text>
            <Text
              style={{ color: item.valueColor ?? '#171717', fontSize: 18, fontWeight: '700' }}
              numberOfLines={1}
            >
              {item.value}
            </Text>
          </View>
        </React.Fragment>
      ))}
    </View>
  );
}

/**
 * Ligne récapitulatif — label à gauche, valeur à droite.
 * Usage: <RecapRow label="Objectif" value="Voyage" />
 */
export function RecapRow({
  label,
  value,
  isLast = false,
}: {
  label: string;
  value: string;
  isLast?: boolean;
}) {
  return (
    <View
      style={{
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingVertical: 10,
        borderBottomWidth: isLast ? 0 : 1,
        borderBottomColor: '#f5f5f5',
      }}
    >
      <Text className="text-neutral-500 text-[14px]">{label}</Text>
      <Text className="text-neutral-900 text-[16px] font-semibold">{value}</Text>
    </View>
  );
}
