import type { ComponentType } from "react";
import { BankingApp } from "./BankingApp";
import { CalendrierApp } from "./CalendrierApp";
import { ContactsApp } from "./ContactsApp";
import { DisneyApp } from "./DisneyApp";
import { FilesApp } from "./FilesApp";
import { GenericApp } from "./GenericApp";
import { InstagramApp } from "./InstagramApp";
import { MailApp } from "./MailApp";
import { MapsApp } from "./MapsApp";
import { MessagesApp } from "./MessagesApp";
import { NotesApp } from "./NotesApp";
import { PhotosApp } from "./PhotosApp";
import { RemindersApp } from "./RemindersApp";
import { SafariApp } from "./SafariApp";
import { SettingsApp } from "./SettingsApp";
import { SignalApp } from "./SignalApp";
import { SpotifyApp } from "./SpotifyApp";
import { TelephoneApp } from "./TelephoneApp";
import { UberApp } from "./UberApp";
import { WhatsAppApp } from "./WhatsAppApp";

export interface AppPluginProps {
  data: unknown;
}

const REGISTRY: Record<string, ComponentType<AppPluginProps>> = {
  Messages: MessagesApp,
  Notes: NotesApp,
  Contacts: ContactsApp,
  Photos: PhotosApp,
  Safari: SafariApp,
  Signal: SignalApp,
  WhatsApp: WhatsAppApp,
  Calendrier: CalendrierApp,
  Mail: MailApp,
  Instagram: InstagramApp,
  Telephone: TelephoneApp,
  "Crédit Agricole": BankingApp,
  Uber: UberApp,
  "Google Maps": MapsApp,
  Fichiers: FilesApp,
  Rappels: RemindersApp,
  Spotify: SpotifyApp,
  Netflix: DisneyApp,
  Réglages: SettingsApp,
};

export function resolveAppComponent(appName: string): ComponentType<AppPluginProps> {
  return REGISTRY[appName] ?? GenericApp;
}
