import { AppIcon } from "../components/ios/AppIcon";
import { usePhone } from "../runtime/PhoneProvider";

export function HomeScreen() {
  const { appNames, dock, openApp } = usePhone();
  const gridApps = appNames.filter((a) => !dock.includes(a));

  return (
    <div className="os-home">
      <div className="os-home__pages">
        <div className="os-home__grid">
          {gridApps.map((name) => (
            <button key={name} type="button" className="os-app-icon" onClick={() => openApp(name)}>
              <AppIcon app={name} size={60} />
              <span className="os-app-icon__label">{name}</span>
            </button>
          ))}
        </div>
      </div>
      <div className="os-dock">
        <div className="os-dock__inner">
          {dock.map((name) => (
            <button key={name} type="button" className="os-app-icon os-app-icon--dock" onClick={() => openApp(name)}>
              <AppIcon app={name} size={54} />
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}
