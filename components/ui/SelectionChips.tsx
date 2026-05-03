import React from 'react';
import { View, Text, Pressable, ScrollView } from 'react-native';

type ChipOption = {
  id: string;
  label: string;
  icon?: string;
};

type SelectionChipsProps = {
  options: ChipOption[];
  selected: string | null;
  onChange: (id: string) => void;
  layout?: 'grid-2col' | 'scroll-h';
};

/**
 * Chips de sélection exclusive — grille 2 colonnes ou scroll horizontal.
 * DS: selection-chips.component.md
 */
export function SelectionChips({
  options,
  selected,
  onChange,
  layout = 'grid-2col',
}: SelectionChipsProps) {
  if (layout === 'scroll-h') {
    return (
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={{ gap: 8, paddingVertical: 4 }}
      >
        {options.map((option) => (
          <Chip
            key={option.id}
            option={option}
            isSelected={selected === option.id}
            onPress={() => onChange(option.id)}
          />
        ))}
      </ScrollView>
    );
  }

  // Grid 2 colonnes
  return (
    <View className="flex-row flex-wrap" style={{ gap: 8 }}>
      {options.map((option) => (
        <View key={option.id} style={{ width: '48%' }}>
          <Chip
            option={option}
            isSelected={selected === option.id}
            onPress={() => onChange(option.id)}
            fullWidth
          />
        </View>
      ))}
    </View>
  );
}

// ---

type ChipProps = {
  option: ChipOption;
  isSelected: boolean;
  onPress: () => void;
  fullWidth?: boolean;
};

function Chip({ option, isSelected, onPress, fullWidth = false }: ChipProps) {
  return (
    <Pressable
      onPress={onPress}
      style={[
        {
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'center',
          paddingHorizontal: 16,
          paddingVertical: 8,
          borderRadius: 20,
          height: 40,
          borderWidth: isSelected ? 1.5 : 1,
          backgroundColor: isSelected ? '#f0fdf4' : '#f5f5f5',
          borderColor: isSelected ? '#166534' : '#d4d4d4',
        },
        fullWidth && { width: '100%' },
      ]}
      accessibilityRole="radio"
      accessibilityState={{ checked: isSelected }}
      accessibilityLabel={option.label}
    >
      {option.icon && (
        <Text style={{ marginRight: 6, fontSize: 16 }}>{option.icon}</Text>
      )}
      <Text
        style={{
          fontSize: 14,
          fontWeight: '500',
          color: isSelected ? '#166534' : '#404040',
        }}
        numberOfLines={1}
      >
        {option.label}
      </Text>
    </Pressable>
  );
}
