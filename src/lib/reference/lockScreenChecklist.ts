/** Checklist élément par élément — verrou vide (system.lock-vide). */
export const LOCK_VIDE_CHECKLIST = [
  { group: "Assets", items: ["Fond d'écran exact (PNG, pas dégradé CSS)", "Grain / texture wallpaper", "Effet profondeur horloge (si activé)"] },
  {
    group: "Status bar",
    items: [
      "Opérateur Free",
      "Icône mode silencieux",
      "Barres cellulaires",
      "Wi‑Fi",
      "Batterie 40 % dans l'icône",
      "Hauteur 55 px",
    ],
  },
  {
    group: "Horloge",
    items: [
      "Date au-dessus de l'heure",
      "Typo SF (~98 px, weight 200)",
      "Position top ~68 px",
      "Couleur / vibrancy",
    ],
  },
  {
    group: "Bas d'écran",
    items: ["Bouton torche (verre + blur)", "Bouton appareil photo", "Home indicator"],
  },
  { group: "Comportement", items: ["Swipe unlock + rubber band", "Hint fade au drag"] },
] as const;
