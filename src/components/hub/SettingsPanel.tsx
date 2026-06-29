interface SettingsPanelProps {
  open: boolean;
  onClose: () => void;
  soundEnabled: boolean;
  onSoundChange: (v: boolean) => void;
}

export function SettingsPanel({
  open,
  onClose,
  soundEnabled,
  onSoundChange,
}: SettingsPanelProps) {
  if (!open) return null;

  return (
    <div className="settings-overlay" role="dialog" aria-modal="true" aria-label="Paramètres">
      <button type="button" className="settings-overlay__backdrop" onClick={onClose} aria-label="Fermer" />
      <div className="settings-panel">
        <header className="settings-panel__header">
          <h2>Paramètres</h2>
          <button type="button" className="settings-panel__close" onClick={onClose}>
            ✕
          </button>
        </header>
        <label className="settings-row">
          <span>Sons</span>
          <input
            type="checkbox"
            checked={soundEnabled}
            onChange={(e) => onSoundChange(e.target.checked)}
          />
        </label>
        <p className="settings-panel__note">Lost Phone · v0.1</p>
      </div>
    </div>
  );
}
