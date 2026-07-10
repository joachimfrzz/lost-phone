import SwiftUI

struct SettingsView: View {
    @Environment(\.deviceOwner) private var owner
    @Environment(\.lpspReadOnly) private var readOnly
    // Global Connectivity State
    @State private var airplaneMode = false
    @State private var wifiEnabled = true
    @State private var bluetoothEnabled = true
    @State private var cellularData = true
    @State private var personalHotspot = false
    
    // UI State
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: - Header / Search
                Section {
                    NavigationLink(destination: AppleIDView()) {
                        HStack(spacing: 15) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .foregroundStyle(Color(uiColor: .systemGray4))
                                .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(owner.name)
                                    .font(.title2)
                                    .fontWeight(.regular)
                                Text(Fr.appleIDSubtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.family, rows: [
                        .init("Set Up Family Sharing"),
                        .init("Add Member"),
                        .init("Family Checklist"),
                    ])) {
                        HStack(spacing: 15) {
                            HStack(spacing: -8) {
                                ForEach(0..<3) { _ in
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 24, height: 24)
                                        .overlay(Image(systemName: "person.fill").font(.caption2).foregroundStyle(.gray))
                                        .overlay(Circle().stroke(Color(uiColor: .systemBackground), lineWidth: 2))
                                }
                            }
                            Text(Fr.family)
                        }
                    }
                }
                
                // MARK: - Connectivity Section
                Section {
                    // Airplane Mode Logic
                    Toggle(isOn: $airplaneMode) {
                        SettingsIcon(icon: "airplane", color: .orange, title: Fr.airplaneMode)
                    }
                    .disabled(readOnly)
                    .onChange(of: airplaneMode) { isActive in
                        if isActive {
                            withAnimation {
                                wifiEnabled = false
                                bluetoothEnabled = false
                                cellularData = false
                                personalHotspot = false
                            }
                        } else {
                            // Restore defaults when turning off
                            wifiEnabled = true
                            bluetoothEnabled = true
                            cellularData = true
                        }
                    }
                    
                    // Wi-Fi
                    NavigationLink(destination: WifiView(isEnabled: $wifiEnabled, airplaneMode: airplaneMode)) {
                        HStack {
                            SettingsIcon(icon: "wifi", color: .blue, title: Fr.wifi)
                            Spacer()
                            Text(getStatusText(enabled: wifiEnabled, active: Fr.homeNetwork))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    // Bluetooth
                    NavigationLink(destination: BluetoothView(isEnabled: $bluetoothEnabled, airplaneMode: airplaneMode)) {
                        HStack {
                            SettingsIcon(icon: "dot.radiowaves.left.and.right", color: .blue, title: Fr.bluetooth)
                            Spacer()
                            Text(getStatusText(enabled: bluetoothEnabled, active: Fr.on))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    // Cellular
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.cellular, rows: [
                        .init("Cellular Data", detail: Fr.on),
                        .init("Data Mode", detail: "Standard"),
                        .init("Voice & Data", detail: "5G Auto"),
                    ])) {
                        HStack {
                            SettingsIcon(icon: "antenna.radiowaves.left.and.right", color: .green, title: Fr.cellular)
                            Spacer()
                            if airplaneMode { Text(Fr.off).foregroundStyle(.secondary) }
                        }
                    }
                    
                    // Hotspot
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.personalHotspot, rows: [
                        .init("Allow Others to Join", detail: Fr.off),
                        .init("Wi-Fi Password", detail: "••••••••"),
                    ])) {
                        HStack {
                            SettingsIcon(icon: "personalhotspot", color: .green, title: Fr.personalHotspot)
                            Spacer()
                            Text(airplaneMode ? Fr.off : Fr.off).foregroundStyle(.secondary)
                        }
                    }
                }
                
                // MARK: - Notifications Section
                Section {
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.notifications, rows: [
                        .init("Show Previews", detail: "Always"),
                        .init("Siri Suggestions", detail: "On"),
                        .init("Scheduled Summary", detail: "Off"),
                    ])) {
                        SettingsIcon(icon: "bell.badge.fill", color: .red, title: Fr.notifications)
                    }
                    NavigationLink(destination: SoundsView()) {
                        SettingsIcon(icon: "speaker.wave.2.fill", color: .pink, title: Fr.soundsAndHaptics)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.focus, rows: [
                        .init("Do Not Disturb"),
                        .init("Sleep"),
                        .init("Work"),
                        .init("Personal"),
                    ])) {
                        SettingsIcon(icon: "moon.fill", color: .indigo, title: Fr.focus)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.screenTime, rows: [
                        .init("App Limits"),
                        .init("Communication Limits"),
                        .init("Always Allowed"),
                    ])) {
                        SettingsIcon(icon: "hourglass", color: .indigo, title: Fr.screenTime)
                    }
                }
                
                // MARK: - General Section
                Section {
                    NavigationLink(destination: GeneralView()) {
                        SettingsIcon(icon: "gear", color: .gray, title: Fr.general)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.controlCenter, rows: [
                        .init("Access Within Apps", detail: Fr.on),
                        .init("Show Home Controls"),
                        .init("Customize Controls"),
                    ])) {
                        SettingsIcon(icon: "switch.2", color: .gray, title: Fr.controlCenter)
                    }
                    NavigationLink(destination: DisplayView()) {
                        SettingsIcon(icon: "textformat.size", color: .blue, title: Fr.displayAndBrightness)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.homeScreen, rows: [
                        .init("Newly Downloaded Apps", detail: "App Library Only"),
                        .init("Show in App Library", detail: Fr.on),
                        .init("Notification Badges", detail: Fr.on),
                    ])) {
                        SettingsIcon(icon: "apps.iphone", color: .indigo, title: Fr.homeScreen)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.accessibility, rows: [
                        .init("Vision"),
                        .init("Mobility"),
                        .init("Hearing"),
                        .init("Speech"),
                    ])) {
                        SettingsIcon(icon: "accessibility", color: .blue, title: Fr.accessibility)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.wallpaper, rows: [
                        .init("Choose a New Wallpaper"),
                        .init("Add New Wallpaper"),
                    ])) {
                        SettingsIcon(icon: "photo.on.rectangle", color: .cyan, title: Fr.wallpaper)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.standby, rows: [
                        .init("Show When Charging", detail: Fr.on),
                        .init("Night Mode", detail: Fr.on),
                    ])) {
                        SettingsIcon(icon: "clock.fill", color: .black, title: Fr.standby)
                    }
                    NavigationLink(destination: BatteryView()) {
                        SettingsIcon(icon: "battery.100", color: .green, title: Fr.battery)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.privacy, rows: [
                        .init("Location Services", detail: Fr.on),
                        .init("Tracking", detail: "Ask App Not to Track"),
                        .init("Analytics & Improvements"),
                    ])) {
                        SettingsIcon(icon: "hand.raised.fill", color: .blue, title: Fr.privacy)
                    }
                }
                
                // MARK: - Stores
                Section {
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.appStore, rows: [
                        .init("App Downloads", detail: "Always Ask"),
                        .init("Cellular Data", detail: "Off"),
                        .init("Video Autoplay", detail: "Wi-Fi Only"),
                    ])) {
                        SettingsIcon(icon: "apple.logo", color: .blue, title: Fr.appStore)
                    }
                    NavigationLink(destination: SettingsPlaceholderView(title: Fr.wallet, rows: [
                        .init("Default Card"),
                        .init("Transaction Notifications", detail: Fr.on),
                        .init("Double-Click Side Button", detail: Fr.on),
                    ])) {
                        SettingsIcon(icon: "creditcard.fill", color: .black, title: Fr.wallet)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(Fr.settings)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
    
    func getStatusText(enabled: Bool, active: String) -> String {
        if airplaneMode { return Fr.off }
        if !enabled { return Fr.off }
        return active
    }
}

// MARK: - 2. Helper Components

struct SettingsIcon: View {
    let icon: String
    let color: Color
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
                .padding(6)
                .background(color)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Text(title)
                .font(.body)
        }
    }
}

// MARK: - 3. Connectivity Detail Views

struct WifiView: View {
    @Binding var isEnabled: Bool
    let airplaneMode: Bool
    @State private var currentNetwork: String? = "Home Network"
    
    let networks = ["Starbucks WiFi", "Office 5G", "xfinitywifi", "Linksys-0482"]
    
    var body: some View {
        List {
            Section {
                Toggle("Wi-Fi", isOn: $isEnabled)
                    .disabled(airplaneMode)
            }
            
            if airplaneMode {
                Section {
                    Text("Wi-Fi needs to be enabled in Control Center or Settings to connect to Wi-Fi networks.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .listRowBackground(Color.clear)
                }
            } else if isEnabled {
                // Current Network
                if let current = currentNetwork {
                    Section(header: Text("Current Network")) {
                        HStack {
                            Text(current)
                                .foregroundStyle(.blue)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundStyle(.blue)
                            Image(systemName: "info.circle")
                                .foregroundStyle(.blue)
                        }
                    }
                }
                
                // Available Networks
                Section(header: Text("Networks")) {
                    ForEach(networks, id: \.self) { network in
                        Button(action: {
                            withAnimation { currentNetwork = network }
                        }) {
                            HStack {
                                Text(network)
                                    .foregroundStyle(.primary)
                                Spacer()
                                Image(systemName: "lock.fill")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Image(systemName: "wifi")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Image(systemName: "info.circle")
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink("Ask to Join Networks") { }
                    NavigationLink("Auto-Join Hotspot") { }
                }
            }
        }
        .navigationTitle("Wi-Fi")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BluetoothView: View {
    @Binding var isEnabled: Bool
    let airplaneMode: Bool
    
    var body: some View {
        List {
            Section {
                Toggle("Bluetooth", isOn: $isEnabled)
                    .disabled(airplaneMode)
            }
            
            if isEnabled && !airplaneMode {
                Section(header: Text("My Devices")) {
                    DeviceRow(name: "AirPods Pro", status: "Connected")
                    DeviceRow(name: "Apple Watch", status: "Connected")
                    DeviceRow(name: "Tesla Model 3", status: "Not Connected")
                    DeviceRow(name: "MX Master 3S", status: "Not Connected")
                }
            } else {
                Section {
                    Text("AirDrop, AirPlay, Find My, and location services use Bluetooth.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .listRowBackground(Color.clear)
                }
            }
        }
        .navigationTitle("Bluetooth")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeviceRow: View {
    let name: String
    let status: String
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(status).foregroundStyle(.secondary)
            Image(systemName: "info.circle")
                .foregroundStyle(.blue)
                .padding(.leading, 8)
        }
    }
}

// MARK: - 4. General Detail Views

struct GeneralView: View {
    var body: some View {
        List {
            Section {
                NavigationLink("About", destination: AboutView())
                NavigationLink("Software Update", destination: SoftwareUpdateView())
            }
            Section {
                NavigationLink("AirDrop", destination: SettingsPlaceholderView(title: "AirDrop", rows: [
                    .init("Receiving Off"),
                    .init("Contacts Only"),
                    .init("Everyone for 10 Minutes"),
                ]))
                NavigationLink("AirPlay & Handoff", destination: SettingsPlaceholderView(title: "AirPlay & Handoff", rows: [
                    .init("Automatically AirPlay", detail: "Never"),
                    .init("Transfer to HomePod", detail: "On"),
                    .init("Handoff", detail: "On"),
                ]))
                NavigationLink("Picture in Picture", destination: SettingsPlaceholderView(title: "Picture in Picture", rows: [
                    .init("Start PiP Automatically", detail: "On"),
                ]))
            }
            Section {
                NavigationLink("iPhone Storage", destination: StorageView())
                NavigationLink("Background App Refresh", destination: SettingsPlaceholderView(title: "Background App Refresh", rows: [
                    .init("Background App Refresh", detail: "Wi-Fi & Cellular Data"),
                    .init("Messages", detail: "Wi-Fi"),
                    .init("Mail", detail: "Off"),
                ]))
            }
            Section {
                NavigationLink("Date & Time", destination: SettingsPlaceholderView(title: "Date & Time", rows: [
                    .init("Set Automatically", detail: "On"),
                    .init("Time Zone", detail: "Paris"),
                    .init("24-Hour Time", detail: "On"),
                ]))
                NavigationLink("Keyboard", destination: SettingsPlaceholderView(title: "Keyboard", rows: [
                    .init("Auto-Capitalization", detail: "On"),
                    .init("Check Spelling", detail: "On"),
                    .init("Predictive Text", detail: "On"),
                ]))
                NavigationLink("Fonts", destination: SettingsPlaceholderView(title: "Fonts", rows: [
                    .init("System Font", detail: "San Francisco"),
                ]))
                NavigationLink("Language & Region", destination: SettingsPlaceholderView(title: "Language & Region", rows: [
                    .init("iPhone Language", detail: "Français"),
                    .init("Region", detail: "France"),
                    .init("Calendar", detail: "Gregorian"),
                ]))
            }
            Section {
                NavigationLink("Transfer or Reset iPhone", destination: SettingsPlaceholderView(title: "Transfer or Reset iPhone", rows: [
                    .init("Prepare for New iPhone"),
                    .init("Erase All Content and Settings"),
                ]))
            }
            Section {
                NavigationLink("Shut Down", destination: SettingsPlaceholderView(title: "Shut Down", rows: [
                    .init("Slide to power off your iPhone."),
                ]))
            }
        }
        .navigationTitle("Général")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView: View {
    @Environment(\.deviceOwner) private var owner

    var body: some View {
        List {
            Section {
                InfoRow(label: "Name", value: "\(owner.name)'s iPhone")
            }
            Section {
                InfoRow(label: "iOS Version", value: "17.2.1")
                InfoRow(label: "Model Name", value: "iPhone 15 Pro")
                InfoRow(label: "Model Number", value: "A2848")
                InfoRow(label: "Serial Number", value: "H4X0R1337")
            }
            Section {
                HStack { Text("Coverage"); Spacer(); Text("Expired").foregroundStyle(.secondary); Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary) }
            }
            Section {
                InfoRow(label: "Songs", value: "1,024")
                InfoRow(label: "Videos", value: "45")
                InfoRow(label: "Photos", value: "12,049")
                InfoRow(label: "Applications", value: "92")
                InfoRow(label: "Available", value: "120 GB")
            }
        }
        .navigationTitle("Informations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value).foregroundStyle(.secondary)
        }
    }
}

struct SoftwareUpdateView: View {
    @State private var loading = true
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground).ignoresSafeArea()
            
            if loading {
                VStack(spacing: 15) {
                    ProgressView()
                    Text("Checking for Update...")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            } else {
                VStack(spacing: 20) {
                    Spacer().frame(height: 40)
                    Image(systemName: "cube.box.fill") // Abstract icon for OS
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.gray)
                    
                    VStack(spacing: 5) {
                        Text("iOS 17.2.1")
                            .font(.title3).bold()
                        Text("iOS is up to date")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Mise à jour logicielle")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { loading = false }
            }
        }
    }
}

struct StorageView: View {
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("iPhone")
                            .font(.headline)
                        Spacer()
                        Text("128 GB Total")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    // Custom Storage Bar
                    GeometryReader { geo in
                        HStack(spacing: 2) {
                            Rectangle().fill(Color.red).frame(width: geo.size.width * 0.4)
                            Rectangle().fill(Color.yellow).frame(width: geo.size.width * 0.15)
                            Rectangle().fill(Color.gray).frame(width: geo.size.width * 0.15)
                            Rectangle().fill(Color(uiColor: .systemGray5))
                        }
                    }
                    .frame(height: 12)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    HStack(spacing: 15) {
                        LegendItem(color: .red, label: "Apps")
                        LegendItem(color: .yellow, label: "Photos")
                        LegendItem(color: .gray, label: "System")
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Recommendations")) {
                HStack {
                    Text("Review Large Attachments")
                    Spacer()
                    Text("3.2 GB").foregroundStyle(.secondary)
                    Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary)
                }
            }
            
            Section(header: Text("Last Used")) {
                StorageAppRow(name: "Photos", size: "12.4 GB", icon: "photo.fill", color: .blue)
                StorageAppRow(name: "Messages", size: "5.1 GB", icon: "message.fill", color: .green)
                StorageAppRow(name: "Instagram", size: "2.2 GB", icon: "camera.fill", color: .purple)
            }
        }
        .navigationTitle("Stockage iPhone")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LegendItem: View {
    let color: Color
    let label: String
    var body: some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
    }
}

struct StorageAppRow: View {
    let name: String
    let size: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(8)
                .background(color)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 7))
            
            VStack(alignment: .leading) {
                Text(name)
                Text("Last used: Yesterday").font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            Text(size).foregroundStyle(.secondary)
            Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary)
        }
    }
}

// MARK: - 5. Display & Battery

struct DisplayView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    @State private var brightness: Double = 0.7
    @State private var trueTone = true
    
    var body: some View {
        List {
            Section(header: Text("Appearance")) {
                HStack(spacing: 20) {
                    // Light Option
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(uiColor: .systemGray6))
                            .frame(height: 60)
                            .overlay(Image(systemName: "sun.max.fill").font(.largeTitle).foregroundStyle(.black))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isDarkMode ? Color.clear : Color.blue, lineWidth: 2))
                            .onTapGesture { isDarkMode = false }
                        
                        Text("Light").font(.caption)
                        Image(systemName: !isDarkMode ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(!isDarkMode ? .blue : .gray)
                    }
                    
                    // Dark Option
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                            .frame(height: 60)
                            .overlay(Image(systemName: "moon.fill").font(.largeTitle).foregroundStyle(.white))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isDarkMode ? Color.blue : Color.clear, lineWidth: 2))
                            .onTapGesture { isDarkMode = true }
                        
                        Text("Dark").font(.caption)
                        Image(systemName: isDarkMode ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(isDarkMode ? .blue : .gray)
                    }
                }
                .padding(.vertical, 8)
                
                Toggle("Automatic", isOn: .constant(true))
            }
            
            Section(header: Text("Brightness")) {
                HStack {
                    Image(systemName: "sun.min.fill").foregroundStyle(.secondary)
                    Slider(value: $brightness)
                    Image(systemName: "sun.max.fill").foregroundStyle(.secondary)
                }
                Toggle("True Tone", isOn: $trueTone)
            }
            
            Section {
                NavigationLink("Auto-Lock") {
                    List {
                        HStack { Text("30 Seconds"); Spacer() }
                        HStack { Text("1 Minute"); Spacer(); Image(systemName: "checkmark").foregroundStyle(.blue) }
                        HStack { Text("Never"); Spacer() }
                    }.navigationTitle("Auto-Lock")
                }
                NavigationLink("Raise to Wake") { }
            }
            
            Section {
                NavigationLink("Text Size") { }
                NavigationLink("Bold Text") { }
            }
        }
        .navigationTitle("Écran et luminosité")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BatteryView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Battery Percentage")
                    Spacer()
                    Toggle("", isOn: .constant(true))
                }
                HStack {
                    Text("Low Power Mode")
                    Spacer()
                    Toggle("", isOn: .constant(false))
                }
            }
            
            Section(header: Text("Health")) {
                HStack {
                    Text("Battery Health & Charging")
                    Spacer()
                    Text("98%")
                        .foregroundStyle(.secondary)
                    Image(systemName: "chevron.right").font(.caption).foregroundStyle(.tertiary)
                }
            }
            
            Section(header: Text("Last 24 Hours")) {
                VStack(alignment: .leading, spacing: 10) {
                    // Visual Mock of a Chart
                    HStack(alignment: .bottom, spacing: 8) {
                        ForEach(0..<12) { i in
                            VStack {
                                Spacer()
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(i == 8 ? Color.blue : (i > 8 ? Color(uiColor: .systemGray4) : Color.green))
                                    .frame(height: CGFloat.random(in: 20...80))
                            }
                        }
                    }
                    .frame(height: 120)
                    
                    HStack {
                        Text("12 AM").font(.caption2).foregroundStyle(.secondary)
                        Spacer()
                        Text("6 AM").font(.caption2).foregroundStyle(.secondary)
                        Spacer()
                        Text("12 PM").font(.caption2).foregroundStyle(.secondary)
                        Spacer()
                        Text("6 PM").font(.caption2).foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical)
            }
            
            Section(header: Text("Activity By App")) {
                StorageAppRow(name: "Instagram", size: "34%", icon: "camera.fill", color: .purple)
                StorageAppRow(name: "TikTok", size: "22%", icon: "music.note", color: .black)
                StorageAppRow(name: "Messages", size: "12%", icon: "message.fill", color: .green)
                StorageAppRow(name: "Safari", size: "8%", icon: "safari", color: .blue)
            }
        }
        .navigationTitle("Batterie")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SoundsView: View {
    @State private var volume: Double = 0.5
    @State private var silentMode = false
    
    var body: some View {
        List {
            Section {
                Toggle("Silent Mode", isOn: $silentMode)
            }
            
            Section(header: Text("Ringer and Alerts")) {
                HStack {
                    Image(systemName: "speaker.fill").foregroundStyle(.secondary)
                    Slider(value: $volume)
                    Image(systemName: "speaker.wave.3.fill").foregroundStyle(.secondary)
                }
                Toggle("Change with Buttons", isOn: .constant(true))
            }
            
            Section {
                NavigationLink("Ringtone") {
                    List {
                        HStack { Text("Reflection"); Spacer(); Image(systemName: "checkmark").foregroundStyle(.blue) }
                        Text("Apex")
                        Text("Beacon")
                    }
                    .navigationTitle("Ringtone")
                }
                NavigationLink("Text Tone") {
                    List {
                        HStack { Text("Note"); Spacer(); Image(systemName: "checkmark").foregroundStyle(.blue) }
                        Text("Popcorn")
                    }.navigationTitle("Text Tone")
                }
            }
        }
        .navigationTitle("Sons et vibrations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AppleIDView: View {
    @Environment(\.deviceOwner) private var owner

    var body: some View {
        List {
            Section {
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundStyle(Color(uiColor: .systemGray4))
                        .frame(width: 80, height: 80)
                    
                    Text(owner.name)
                        .font(.title)
                    Text("\(owner.initials.lowercased())@icloud.com")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .listRowBackground(Color.clear)
            }
            
            Section {
                NavigationLink("Name, Phone Numbers, Email") {}
                NavigationLink("Password & Security") {}
                NavigationLink("Payment & Shipping") {}
                NavigationLink("Subscriptions") {}
            }
            
            Section {
                NavigationLink { } label: {
                    HStack {
                        SettingsIcon(icon: "icloud.fill", color: .blue, title: "iCloud")
                        Spacer()
                        Text("200 GB").foregroundStyle(.secondary)
                    }
                }
                SettingsIcon(icon: "film.fill", color: .pink, title: "Media & Purchases")
                SettingsIcon(icon: "mappin.and.ellipse", color: .green, title: "Find My")
                SettingsIcon(icon: "person.2.fill", color: .gray, title: "Family Sharing")
            }
            
            Section {
                Text("iPhone 15 Pro")
                Text("MacBook Pro 14\"")
                Text("John's iPad Air")
            }
            
            Section {
                Text("Se déconnecter")
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Identifiant Apple")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Placeholder detail screens

struct SettingsPlaceholderRow: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var detail: String?

    init(_ title: String, detail: String? = nil) {
        self.title = title
        self.detail = detail
    }
}

struct SettingsPlaceholderView: View {
    let title: String
    let rows: [SettingsPlaceholderRow]
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        List {
            ForEach(rows) { row in
                HStack {
                    Text(row.title)
                    Spacer()
                    if let detail = row.detail {
                        Text(detail)
                            .foregroundStyle(.secondary)
                    }
                    if row.detail != nil || readOnly {
                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Preview
#Preview {
    SettingsView()
}
