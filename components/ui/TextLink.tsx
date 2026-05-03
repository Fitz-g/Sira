import React from 'react';
import { Pressable, Text } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
} from 'react-native-reanimated';

type TextLinkProps = {
  label: string;
  onPress: () => void;
  align?: 'left' | 'center' | 'right';
};

/**
 * Lien texte tertiaire — neutre, discret, ne concurrence pas les CTAs.
 * Toujours sous PrimaryButton ou SecondaryButton, jamais seul.
 * DS: secondary-actions.component.md
 */
export function TextLink({ label, onPress, align = 'center' }: TextLinkProps) {
  const underline = useSharedValue(0);

  const animatedStyle = useAnimatedStyle(() => ({
    opacity: underline.value === 1 ? 0.7 : 1,
  }));

  const handlePressIn = () => {
    underline.value = withTiming(1, { duration: 150 });
  };

  const handlePressOut = () => {
    underline.value = withTiming(0, { duration: 150 });
  };

  const alignClass =
    align === 'center' ? 'text-center' :
    align === 'right' ? 'text-right' : 'text-left';

  return (
    <Pressable
      onPress={onPress}
      onPressIn={handlePressIn}
      onPressOut={handlePressOut}
      accessibilityRole="link"
    >
      <Animated.Text
        style={animatedStyle}
        className={`text-neutral-500 text-[14px] ${alignClass}`}
      >
        {label}
      </Animated.Text>
    </Pressable>
  );
}
