import React from 'react';
import { View, Text } from 'react-native';
import { PrimaryButton } from './PrimaryButton';
import { SecondaryButton } from './SecondaryButton';

type EmptyStateProps = {
  title: string;
  subtitle: string;
  ctaLabel: string;
  onCtaPress: () => void;
  ctaVariant?: 'primary' | 'secondary';
  icon?: React.ReactNode;
};

/**
 * État vide — illustration + message encourageant + CTA.
 * Jamais une page blanche. Toujours une invitation à démarrer.
 * DS: empty-state.component.md
 */
export function EmptyState({
  title,
  subtitle,
  ctaLabel,
  onCtaPress,
  ctaVariant = 'primary',
  icon,
}: EmptyStateProps) {
  return (
    <View className="flex-1 items-center justify-center px-8 py-12">
      {/* Illustration / icône */}
      {icon && (
        <View className="mb-4" style={{ width: 120, height: 120, alignItems: 'center', justifyContent: 'center' }}>
          {icon}
        </View>
      )}

      {/* Titre */}
      <Text
        className="text-neutral-900 font-bold text-center mb-2"
        style={{ fontSize: 18 }}
      >
        {title}
      </Text>

      {/* Sous-titre */}
      <Text
        className="text-neutral-500 text-[14px] text-center"
        style={{ lineHeight: 20, marginBottom: 32 }}
      >
        {subtitle}
      </Text>

      {/* CTA */}
      <View style={{ width: '100%' }}>
        {ctaVariant === 'primary' ? (
          <PrimaryButton label={ctaLabel} onPress={onCtaPress} />
        ) : (
          <SecondaryButton label={ctaLabel} onPress={onCtaPress} />
        )}
      </View>
    </View>
  );
}
