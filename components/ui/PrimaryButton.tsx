import React from 'react';
import { Pressable, Text, ActivityIndicator } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from 'react-native-reanimated';

type PrimaryButtonProps = {
  label: string;
  onPress: () => void;
  disabled?: boolean;
  loading?: boolean;
};

/**
 * Bouton CTA principal — pleine largeur, 56px, vert profond.
 * Un seul PrimaryButton par page (hiérarchie visuelle).
 * DS: primary-button.component.md
 */
export function PrimaryButton({
  label,
  onPress,
  disabled = false,
  loading = false,
}: PrimaryButtonProps) {
  const scale = useSharedValue(1);
  const opacity = useSharedValue(1);
  const isDisabled = disabled || loading;

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
    opacity: isDisabled ? 0.4 : opacity.value,
  }));

  const handlePressIn = () => {
    if (isDisabled) return;
    scale.value = withTiming(0.98, { duration: 150 });
    opacity.value = withTiming(0.85, { duration: 150 });
  };

  const handlePressOut = () => {
    if (isDisabled) return;
    scale.value = withTiming(1, { duration: 150 });
    opacity.value = withTiming(1, { duration: 150 });
  };

  return (
    <Animated.View style={animatedStyle}>
      <Pressable
        onPress={onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        disabled={isDisabled}
        className="bg-primary rounded-card items-center justify-center px-6"
        style={{ minHeight: 56 }}
        accessibilityRole="button"
        accessibilityState={{ disabled: isDisabled, busy: loading }}
        accessibilityLabel={loading ? 'Chargement en cours' : label}
      >
        {loading ? (
          <ActivityIndicator color="white" size="small" />
        ) : (
          <Text className="text-white font-bold text-[18px]">
            {label}
          </Text>
        )}
      </Pressable>
    </Animated.View>
  );
}
