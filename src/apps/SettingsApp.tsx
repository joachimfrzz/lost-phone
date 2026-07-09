import type { ReactNode } from "react";
import type { AppPluginProps } from "./registry";
import { usePhone } from "../runtime/PhoneProvider";
import { AppShell } from "../ios/ui/AppShell";
import { Cell, Group } from "../ios/ui/List";
import { SFSearch } from "../ios/ui/SFSymbols";

function SettingIcon({ color, children }: { color: string; children: ReactNode }) {
  return (
    <span className="ui-settings-icon" style={{ background: color }}>
      {children}
    </span>
  );
}

/** Réglages iOS 17 — adaptés au propriétaire du téléphone (LPSP). */
export function SettingsApp(_props: AppPluginProps) {
  const { lpsp, getAppData } = usePhone();
  const contactsData = getAppData("Contacts") as { proprietaire?: { nom?: string } } | null;
  const bankingData = getAppData("Crédit Agricole") as { titulaire?: string | { nom?: string } } | null;
  const titulaire = bankingData?.titulaire;
  const displayName =
    contactsData?.proprietaire?.nom
    ?? (typeof titulaire === "string" ? titulaire : titulaire?.nom)
    ?? "Mathieu Garnier";
  const initials = displayName.split(" ").map((w) => w[0]).join("").slice(0, 2).toUpperCase();

  return (
    <AppShell theme="light">
      <header className="ui-nav ui-nav--settings">
        <div className="ui-nav__side" />
        <h1 className="ui-nav__title">Réglages</h1>
        <div className="ui-nav__side ui-nav__side--right" />
      </header>
      <div className="ui-settings-search">
        <SFSearch />
        <span>Rechercher</span>
      </div>
      <div className="ui-scroll">
        <Group>
          <Cell
            icon={<span className="ui-settings-avatar">{initials}</span>}
            label={displayName}
            subtitle="Apple ID, iCloud, Médias et achats"
            chevron
          />
        </Group>

        <Group>
          <Cell icon={<SettingIcon color="#FF9500"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><path d="M10.5 2h3l1 4h4l-3 3 1 4-4-2-4 2 1-4-3-3h4l1-4z"/></svg></SettingIcon>} label="Mode Avion" detail={<span className="ui-toggle" />} />
          <Cell icon={<SettingIcon color="#007AFF"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><path d="M2 8.5a12 12 0 0 1 20 0M5 12.5a8 8 0 0 1 14 0M8.5 16a4 4 0 0 1 7 0M12 20h.01"/></svg></SettingIcon>} label="Wi‑Fi" subtitle="Freebox-XXXX" chevron />
          <Cell icon={<SettingIcon color="#007AFF"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><path d="M7 12l5-5 5 5M12 7v10"/></svg></SettingIcon>} label="Bluetooth" subtitle="Activé" chevron />
          <Cell icon={<SettingIcon color="#34C759"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><rect x="7" y="2" width="10" height="20" rx="2"/></svg></SettingIcon>} label="Données cellulaires" chevron />
          <Cell icon={<SettingIcon color="#34C759"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><path d="M4 12h16M12 4v16"/></svg></SettingIcon>} label="Partage de connexion" chevron />
        </Group>

        <Group>
          <Cell icon={<SettingIcon color="#FF3B30"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><path d="M12 3a7 7 0 0 0-7 7v3l-2 2h18l-2-2v-3a7 7 0 0 0-7-7z"/></svg></SettingIcon>} label="Notifications" chevron />
          <Cell icon={<SettingIcon color="#FF2D55"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><path d="M12 3v18M5 8h14"/></svg></SettingIcon>} label="Sons et vibrations" chevron />
          <Cell icon={<SettingIcon color="#5856D6"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><circle cx="12" cy="12" r="8"/></svg></SettingIcon>} label="Focus" chevron />
          <Cell icon={<SettingIcon color="#5856D6"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><circle cx="12" cy="12" r="9" fill="none" stroke="#fff" stroke-width="2"/></svg></SettingIcon>} label="Temps d'écran" chevron />
        </Group>

        <Group>
          <Cell icon={<SettingIcon color="#8E8E93"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><circle cx="12" cy="12" r="3"/></svg></SettingIcon>} label="Général" chevron />
          <Cell icon={<SettingIcon color="#007AFF"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><circle cx="12" cy="6" r="2"/><path d="M8 20v-2a4 4 0 0 1 8 0v2"/></svg></SettingIcon>} label="Accessibilité" chevron />
          <Cell icon={<SettingIcon color="#007AFF"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><rect x="5" y="11" width="14" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg></SettingIcon>} label="Confidentialité et sécurité" chevron />
        </Group>

        <Group footer={`iOS 17.5.1 · ${lpsp.content.envelope.date_verrou ?? ""}`}>
          <Cell icon={<SettingIcon color="#8E8E93"><svg width="18" height="18" viewBox="0 0 24 24" fill="#fff"><rect x="7" y="2" width="10" height="20" rx="2"/></svg></SettingIcon>} label="Infos" subtitle={displayName} chevron />
        </Group>
      </div>
    </AppShell>
  );
}
