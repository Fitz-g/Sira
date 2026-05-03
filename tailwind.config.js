/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
  ],
  presets: [require('nativewind/preset')],
  theme: {
    extend: {
      colors: {
        // Couleur principale — Vert profond UEMOA
        primary: {
          DEFAULT: '#166534', // green-800 — boutons CTA, chips actifs, focus
          light:   '#f0fdf4', // green-50  — fonds tintés (cards insight, chips selected)
          dark:    '#14532d', // green-900 — pressed state
        },
        // Statuts sémantiques
        success: '#16a34a', // green-600 — champs valides, budget OK, solde positif
        warning: '#d97706', // amber-600 — budget 80-100%, score moyen
        error:   '#dc2626', // red-600   — erreurs, suppressions, solde négatif
        // Neutres (surface, textes, bordures)
        surface: {
          DEFAULT: '#ffffff',
          card:    '#ffffff',
        },
        neutral: {
          100: '#f5f5f5',
          300: '#d4d4d4',
          500: '#737373',
          700: '#404040',
          900: '#171717',
        },
      },
      fontFamily: {
        // Sera configuré quand la police sera chargée via expo-font
        sans: ['System'],
      },
      fontSize: {
        // Tokens typographiques du Design System
        'heading-4xl': ['56px', { lineHeight: '67px' }],
        'heading-3xl': ['44px', { lineHeight: '53px' }],
        'heading-2xl': ['36px', { lineHeight: '43px' }],
        'heading-xl':  ['30px', { lineHeight: '36px' }],
        'heading-lg':  ['24px', { lineHeight: '29px' }],
        'heading-md':  ['20px', { lineHeight: '24px' }],
        'heading-sm':  ['18px', { lineHeight: '22px' }],
        'heading-xs':  ['16px', { lineHeight: '19px' }],
        'heading-xxs': ['14px', { lineHeight: '17px' }],
      },
      spacing: {
        // Tokens d'espacement du Design System
        'space-sm': '8px',
        'space-md': '16px',
        'space-lg': '24px',
        'space-xl': '32px',
        // Conteneurs
        'page':     '20px',
        'card':     '16px',
      },
      borderRadius: {
        'card':  '12px',
        'chip':  '20px',
        'input': '8px',
      },
    },
  },
  plugins: [],
};
