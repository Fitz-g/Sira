import React, { useState } from 'react';
import { View, Text, TextInput, Pressable } from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { parseCurrency, formatAmount } from '@/utils/currency';

type InputVariant = 'text' | 'email' | 'password' | 'number';

type InputProps = {
  label: string;
  value: string;
  onChangeText: (value: string) => void;
  variant?: InputVariant;
  placeholder?: string;
  error?: string;
  isValid?: boolean;
  optional?: boolean;
  suffix?: string;
  maxLength?: number;
  autoFocus?: boolean;
  onBlur?: () => void;
};

/**
 * Champ de saisie — 4 variantes : text, email, password, number.
 * 5 états visuels : default, focus, filled, error, valid.
 * DS: input.component.md
 */
export function Input({
  label,
  value,
  onChangeText,
  variant = 'text',
  placeholder,
  error,
  isValid = false,
  optional = false,
  suffix,
  maxLength,
  autoFocus = false,
  onBlur,
}: InputProps) {
  const [isFocused, setIsFocused] = useState(false);
  const [isPasswordVisible, setPasswordVisible] = useState(false);

  // Couleur de bordure selon l'état
  const borderColor = () => {
    if (error) return '#dc2626';     // color-error
    if (isValid) return '#16a34a';   // color-success
    if (isFocused) return '#166534'; // color-primary
    return '#d4d4d4';                // color-neutral-300
  };

  const borderWidth = isFocused || error || isValid ? 2 : 1;

  // Clavier selon la variante
  const keyboardType = () => {
    if (variant === 'email') return 'email-address' as const;
    if (variant === 'number') return 'number-pad' as const;
    return 'default' as const;
  };

  // Gestion de la valeur pour le type number (affichage formaté)
  const handleChangeText = (text: string) => {
    if (variant === 'number') {
      const num = parseCurrency(text);
      onChangeText(String(num));
    } else {
      onChangeText(text);
    }
  };

  const displayValue = () => {
    if (variant === 'number' && value) {
      const num = parseInt(value, 10);
      return isNaN(num) || num === 0 ? '' : formatAmount(num);
    }
    return value;
  };

  return (
    <View>
      {/* Label */}
      <Text className="text-neutral-700 text-[14px] font-medium mb-2">
        {label}
        {optional && (
          <Text className="text-neutral-500 font-normal"> (optionnel)</Text>
        )}
      </Text>

      {/* Champ */}
      <View
        className="flex-row items-center bg-neutral-100 rounded-input px-4"
        style={{ height: 52, borderWidth, borderColor: borderColor() }}
      >
        <TextInput
          value={displayValue()}
          onChangeText={handleChangeText}
          placeholder={placeholder}
          placeholderTextColor="#737373"
          keyboardType={keyboardType()}
          autoCapitalize={variant === 'email' ? 'none' : 'sentences'}
          autoCorrect={variant === 'text' ? true : false}
          secureTextEntry={variant === 'password' && !isPasswordVisible}
          autoFocus={autoFocus}
          maxLength={maxLength}
          onFocus={() => setIsFocused(true)}
          onBlur={() => {
            setIsFocused(false);
            onBlur?.();
          }}
          className="flex-1 text-neutral-900 text-[16px]"
          accessibilityLabel={label}
        />

        {/* Suffix FCFA pour les inputs numériques */}
        {variant === 'number' && value && parseInt(value, 10) > 0 && (
          <Text className="text-neutral-500 text-[14px] ml-1">FCFA</Text>
        )}

        {/* Toggle visibilité mot de passe */}
        {variant === 'password' && (
          <Pressable
            onPress={() => setPasswordVisible(!isPasswordVisible)}
            accessibilityLabel={isPasswordVisible ? 'Masquer le mot de passe' : 'Afficher le mot de passe'}
          >
            <Ionicons
              name={isPasswordVisible ? 'eye-off-outline' : 'eye-outline'}
              size={20}
              color="#737373"
            />
          </Pressable>
        )}

        {/* Icône de validation */}
        {isValid && !error && (
          <Ionicons name="checkmark-circle" size={20} color="#16a34a" />
        )}
      </View>

      {/* Message d'erreur */}
      {error && (
        <Text className="text-[#dc2626] text-[14px] mt-1">{error}</Text>
      )}
    </View>
  );
}
