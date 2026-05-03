import React from 'react';
import { Pressable, Text } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from 'react-native-reanimated';

type SecondaryButtonProps = {
  label: string;
  onPress: () => void;
  disabled?: boolean;
  fullWidth?: boolean;
};

/**
 * Bouton secondaire — bordure primary, fond transparent.
 * Peut coexister avec PrimaryButton sur la même page.
 * DS: secondary-actions.component.md
 */
export function SecondaryButton({
  label,
  onPress,
  disabled = false,
  fullWidth = true,
}: SecondaryButtonProps) {
  const scale = useSharedValue(1);
  const opacity = useSharedValue(1);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ scale: scale.value }],
    opacity: disabled ? 0.4 : opacity.value,
    alignSelf: fullWidth ? 'stretch' : 'auto',
  }));

  const handlePressIn = () => {
    if (disabled) return;
    scale.value = withTiming(0.98, { duration: 150 });
    opacity.value = withTiming(0.85, { duration: 150 });
  };

  const handlePressOut = () => {
    if (disabled) return;
    scale.value = withTiming(1, { duration: 150 });
    opacity.value = withTiming(1, { duration: 150 });
  };

  return (
    <Animated.View style={animatedStyle}>
      <Pressable
        onPress={onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        disabled={disabled}
        className="border border-primary rounded-card items-center justify-center px-6"
        style={{ height: 48 }}
        accessibilityRole="button"
        accessibilityState={{ disabled }}
      >
        <Text className="text-primary font-semibold text-[16px]">
          {label}
        </Text>
      </Pressable>
    </Animated.View>
  );
}
