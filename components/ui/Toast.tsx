import React, { useEffect } from 'react';
import { Text, View } from 'react-native';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withTiming,
  withSequence,
  withDelay,
  runOnJS,
} from 'react-native-reanimated';
import { Ionicons } from '@expo/vector-icons';

type ToastType = 'success' | 'error' | 'info';

type ToastProps = {
  message: string;
  type?: ToastType;
  visible: boolean;
  onHide: () => void;
  duration?: number;
};

const toastStyles = {
  success: {
    bg: '#f0fdf4',
    border: '#166534',
    text: '#166534',
    icon: 'checkmark-circle' as const,
  },
  error: {
    bg: '#fef2f2',
    border: '#dc2626',
    text: '#dc2626',
    icon: 'close-circle' as const,
  },
  info: {
    bg: '#f0fdf4',
    border: '#166534',
    text: '#166534',
    icon: 'information-circle' as const,
  },
};

/**
 * Toast de confirmation — non-bloquant, slide-up, auto-dismiss 2s.
 * DS: toast.component.md
 *
 * Usage:
 *   const [toastVisible, setToastVisible] = useState(false);
 *   <Toast message="Dépense ajoutée ✓" visible={toastVisible} onHide={() => setToastVisible(false)} />
 */
export function Toast({
  message,
  type = 'success',
  visible,
  onHide,
  duration = 2000,
}: ToastProps) {
  const translateY = useSharedValue(100);
  const opacity = useSharedValue(0);
  const styles = toastStyles[type];

  useEffect(() => {
    if (visible) {
      // Slide-up + fade-in
      translateY.value = withTiming(0, { duration: 200 });
      opacity.value = withSequence(
        withTiming(1, { duration: 200 }),
        withDelay(duration, withTiming(0, { duration: 200 }))
      );
      // Callback après l'animation complète
      const timeout = setTimeout(() => {
        runOnJS(onHide)();
      }, duration + 400);
      return () => clearTimeout(timeout);
    } else {
      translateY.value = 100;
      opacity.value = 0;
    }
  }, [visible]);

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateY: translateY.value }],
    opacity: opacity.value,
  }));

  if (!visible) return null;

  return (
    <Animated.View
      style={[
        animatedStyle,
        {
          position: 'absolute',
          bottom: 24,
          left: 20,
          right: 20,
          zIndex: 999,
        },
      ]}
    >
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          backgroundColor: styles.bg,
          borderRadius: 8,
          borderWidth: 1,
          borderColor: styles.border + '40',
          borderLeftWidth: 4,
          borderLeftColor: styles.border,
          paddingHorizontal: 16,
          paddingVertical: 12,
          gap: 10,
        }}
      >
        <Ionicons name={styles.icon} size={20} color={styles.border} />
        <Text style={{ flex: 1, color: styles.text, fontSize: 14, fontWeight: '500' }}>
          {message}
        </Text>
      </View>
    </Animated.View>
  );
}
