import React from 'react';
import { View, Text, Pressable } from 'react-native';
import { useRouter } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

type HeaderVariant = 'hero' | 'primary' | 'standard';
type LeftAction = 'back' | 'close' | 'none';

type RightAction = {
  icon: keyof typeof Ionicons.glyphMap;
  label: string;
  onPress: () => void;
};

type PageHeaderProps = {
  title: string;
  variant?: HeaderVariant;
  leftAction?: LeftAction;
  rightAction?: RightAction;
  titleAlign?: 'left' | 'center';
};

const variantStyles = {
  hero: {
    fontSize: 30,
    fontWeight: '700' as const,
    align: 'center' as const,
  },
  primary: {
    fontSize: 24,
    fontWeight: '700' as const,
    align: 'left' as const,
  },
  standard: {
    fontSize: 20,
    fontWeight: '600' as const,
    align: 'left' as const,
  },
};

/**
 * En-tête de page — 3 variantes (hero, primary, standard).
 * Action gauche : retour ← ou fermer X.
 * Action droite : optionnelle (ajouter, modifier...).
 * DS: page-header.component.md
 */
export function PageHeader({
  title,
  variant = 'standard',
  leftAction = 'none',
  rightAction,
  titleAlign,
}: PageHeaderProps) {
  const router = useRouter();
  const styles = variantStyles[variant];
  const align = titleAlign ?? styles.align;

  const handleLeftPress = () => {
    if (leftAction === 'back' || leftAction === 'close') {
      router.back();
    }
  };

  return (
    <View className="flex-row items-center px-5 pt-4 pb-3">
      {/* Action gauche */}
      <View style={{ width: 40 }}>
        {(leftAction === 'back' || leftAction === 'close') && (
          <Pressable
            onPress={handleLeftPress}
            className="w-10 h-10 items-center justify-center"
            accessibilityRole="button"
            accessibilityLabel={leftAction === 'back' ? 'Retour' : 'Fermer'}
          >
            <Ionicons
              name={leftAction === 'close' ? 'close' : 'chevron-back'}
              size={24}
              color="#171717"
            />
          </Pressable>
        )}
      </View>

      {/* Titre */}
      <Text
        className="flex-1 text-neutral-900"
        style={{
          fontSize: styles.fontSize,
          fontWeight: styles.fontWeight,
          textAlign: align,
        }}
        numberOfLines={1}
        accessibilityRole="header"
      >
        {title}
      </Text>

      {/* Action droite */}
      <View style={{ width: 40, alignItems: 'flex-end' }}>
        {rightAction && (
          <Pressable
            onPress={rightAction.onPress}
            className="w-10 h-10 items-center justify-center"
            accessibilityRole="button"
            accessibilityLabel={rightAction.label}
          >
            <Ionicons name={rightAction.icon} size={24} color="#166534" />
          </Pressable>
        )}
      </View>
    </View>
  );
}
