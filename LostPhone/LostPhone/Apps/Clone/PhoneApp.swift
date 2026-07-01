import SwiftUI

struct PhoneContact: Identifiable, Hashable {
    let id: UUID
    let displayName: String
    let relation: String
    let note: String

    init(stableId: String, displayName: String, relation: String, note: String) {
        self.id = LpspStableId.uuid(stableId)
        self.displayName = displayName
        self.relation = relation
        self.note = note
    }

    var initials: String {
        let parts = displayName.split(separator: " ")
        let letters = parts.prefix(2).compactMap { $0.first.map(String.init) }
        return letters.joined().uppercased()
    }
}

// MARK: - Main Tab View
struct PhoneView: View {
    let recentCalls: [RecentItem]
    let contacts: [PhoneContact]

    init(recentCalls: [RecentItem] = [], contacts: [PhoneContact] = []) {
        self.recentCalls = recentCalls
        self.contacts = contacts
    }

    var body: some View {
        TabView {
            FavoritesView()
                .tabItem { Label("Favoris", systemImage: "star.fill") }

            RecentsView(recentCalls: recentCalls)
                .tabItem { Label("Récents", systemImage: "clock.fill") }
            
            ContactsView(contacts: contacts)
                .tabItem { Label("Contacts", systemImage: "person.circle.fill") }
            
            KeypadView()
                .tabItem { Label("Clavier", systemImage: "circle.grid.3x3.fill") }
            
            VoicemailView()
                .tabItem { Label("Messagerie vocale", systemImage: "recordingtape") }
        }
        .accentColor(.blue)
    }
}

// MARK: - 1. Keypad View (Highly Accurate)
struct KeypadView: View {
    @State private var number = ""
    @Environment(\.lpspReadOnly) private var readOnly
    
    // Grid Layout: 3 Columns, specifically spaced
    let columns = Array(repeating: GridItem(.fixed(78), spacing: 24), count: 3)
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Number Display Area
            VStack(spacing: 8) {
                Text(number)
                    .font(.system(size: 40, weight: .regular))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .frame(height: 50)
                    .padding(.horizontal, 40)
                
                Button("Ajouter un numéro") { }
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                    .opacity(number.isEmpty || readOnly ? 0 : 1)
                    .disabled(readOnly)
                    .frame(height: 20)
            }
            .padding(.bottom, 20)
            
            // The Keypad Grid
            LazyVGrid(columns: columns, spacing: 16) {
                // Row 1
                KeypadButton(main: "1", sub: "") { append("1") }
                KeypadButton(main: "2", sub: "A B C") { append("2") }
                KeypadButton(main: "3", sub: "D E F") { append("3") }
                
                // Row 2
                KeypadButton(main: "4", sub: "G H I") { append("4") }
                KeypadButton(main: "5", sub: "J K L") { append("5") }
                KeypadButton(main: "6", sub: "M N O") { append("6") }
                
                // Row 3
                KeypadButton(main: "7", sub: "P Q R S") { append("7") }
                KeypadButton(main: "8", sub: "T U V") { append("8") }
                KeypadButton(main: "9", sub: "W X Y Z") { append("9") }
                
                // Row 4
                KeypadButton(main: "*", sub: "", isSymbol: true) { append("*") }
                KeypadButton(main: "0", sub: "+") { append("0") }
                KeypadButton(main: "#", sub: "", isSymbol: true) { append("#") }
            }
            .padding(.bottom, 20)
            
            // Bottom Controls (Call / Delete)
            HStack {
                // Spacer to balance the delete button
                Color.clear
                    .frame(width: 78, height: 78)
                
                Spacer()
                
                // Call Button
                Button(action: {}) {
                    Circle()
                        .fill(readOnly ? Color.green.opacity(0.35) : Color.green)
                        .frame(width: 78, height: 78)
                        .overlay(
                            Image(systemName: "phone.fill")
                                .font(.title)
                                .foregroundStyle(.white)
                        )
                }
                .buttonStyle(IOSButtonStyle())
                .disabled(readOnly)
                
                Spacer()
                
                // Backspace Button
                Button(action: {
                    if !number.isEmpty { number.removeLast() }
                }) {
                    Image(systemName: "delete.left.fill")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .frame(width: 78, height: 78)
                }
                .opacity(number.isEmpty ? 0 : 1)
                .disabled(number.isEmpty)
            }
            .padding(.horizontal, 45) // Aligns with the outer grid edges
            .padding(.bottom, 80) // Tab bar clearance
        }
    }
    
    func append(_ val: String) {
        if number.count < 15 { number += val }
    }
}

// Custom Button Style to replicate iOS Tap Dimming
struct IOSButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.3 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct KeypadButton: View {
    let main: String
    let sub: String
    var isSymbol: Bool = false
    let action: () -> Void
    
    // Exact iOS Colors
    let lightGray = Color(red: 229/255, green: 229/255, blue: 229/255)
    let darkGray = Color(red: 50/255, green: 50/255, blue: 50/255)
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(colorScheme == .dark ? darkGray : lightGray)
                    .frame(width: 78, height: 78)
                
                VStack(spacing: 0) {
                    Text(main)
                        .font(.system(size: 34, weight: .regular))
                        .foregroundStyle(.primary)
                        .padding(.top, (sub.isEmpty && !isSymbol) ? 0 : (isSymbol ? 6 : 2))
                    
                    if !sub.isEmpty {
                        Text(sub)
                            .font(.system(size: 9, weight: .bold))
                            .tracking(1.5) // Spacing between letters
                            .foregroundStyle(.primary)
                            .padding(.bottom, 4)
                    }
                }
                // This offset corrects the visual center for numbers with letters
                .offset(y: sub.isEmpty ? 0 : -2)
            }
        }
        .buttonStyle(IOSButtonStyle())
    }
}

// MARK: - 2. Recents View (Accurate Navigation)
struct RecentsView: View {
    @State private var filter = 0
    let recentCalls: [RecentItem]

    init(recentCalls: [RecentItem] = []) {
        self.recentCalls = recentCalls
    }
    
    var filteredCalls: [RecentItem] {
        filter == 1 ? recentCalls.filter { $0.type == .missed } : recentCalls
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCalls) { call in
                    HStack(spacing: 12) {
                        // Call Type Icon
                        if call.type == .outgoing {
                            Image(systemName: "phone.arrow.up.right.fill")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .frame(width: 12)
                        } else {
                            Spacer().frame(width: 12)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(call.name)
                                .font(.headline)
                                .foregroundStyle(call.type == .missed ? .red : .primary)
                            
                            Text(call.label)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 8) {
                            Text(call.date)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Button(action: {}) {
                                Image(systemName: "info.circle")
                                    .font(.title2)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Récents")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Filter", selection: $filter) {
                        Text("Tous").tag(0)
                        Text("Manqués").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 180)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Modifier") {}
                }
            }
        }
    }
}

struct RecentItem: Identifiable {
    let id: UUID
    let name: String
    let label: String
    let date: String
    let type: CallType

    init(stableId: String, name: String, label: String, date: String, type: CallType) {
        self.id = LpspStableId.uuid(stableId)
        self.name = name
        self.label = label
        self.date = date
        self.type = type
    }

    enum CallType { case incoming, outgoing, missed }
}

// MARK: - 3. Contacts View
struct ContactsView: View {
    @State private var searchText = ""
    @Environment(\.deviceOwner) private var owner
    @Environment(\.lpspReadOnly) private var readOnly
    let contacts: [PhoneContact]

    private static let demoContacts = ["Aaron", "Adam", "Brian", "Bob", "Charlie", "Craig Federighi", "David", "Emily", "Frank", "Greg", "Harry", "Ian", "John Appleseed", "Jony Ive", "Kate", "Larry", "Mike", "Nancy", "Oscar", "Pallav Agarwal", "Paul", "Quincy", "Rachel", "Steve Jobs", "Tim Cook", "Ursula", "Victor", "Wendy", "Xavier", "Yvonne", "Zach"]

    init(contacts: [PhoneContact] = []) {
        self.contacts = contacts
    }

    private var displayContacts: [PhoneContact] {
        if !contacts.isEmpty {
            return contacts.sorted { $0.displayName.localizedCaseInsensitiveCompare($1.displayName) == .orderedAscending }
        }
        guard !readOnly else { return [] }
        return Self.demoContacts.map {
            PhoneContact(stableId: "demo-\($0)", displayName: $0, relation: "", note: "")
        }
    }

    var groupedContacts: [String: [PhoneContact]] {
        Dictionary(grouping: displayContacts) { contact in
            String(contact.displayName.prefix(1)).uppercased()
        }
    }
    
    var sortedKeys: [String] {
        groupedContacts.keys.sorted()
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if displayContacts.isEmpty {
                    ContentUnavailableView(
                        "Contacts",
                        systemImage: "person.crop.circle",
                        description: Text(readOnly ? "Aucun contact LPSP" : "Aucun contact")
                    )
                } else {
                    contactsList
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Groupes") {}
                        .disabled(readOnly)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) { Image(systemName: "plus") }
                        .disabled(readOnly)
                }
            }
        }
    }

    private var contactsList: some View {
        List {
            Section {
                HStack(spacing: 15) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .overlay(Text(owner.initials).font(.title2).bold().foregroundStyle(.white))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(owner.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("Ma carte")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
            
            ForEach(sortedKeys, id: \.self) { key in
                Section(header: Text(key).fontWeight(.bold)) {
                    ForEach(groupedContacts[key] ?? []) { contact in
                        NavigationLink {
                            ContactDetailView(contact: contact)
                        } label: {
                            Text(contact.displayName)
                                .fontWeight(.medium)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ContactDetailView: View {
    let contact: PhoneContact

    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 12) {
                        Circle()
                            .fill(Color.gray.opacity(0.25))
                            .frame(width: 96, height: 96)
                            .overlay(Text(contact.initials).font(.largeTitle.bold()))
                        Text(contact.displayName)
                            .font(.title2.weight(.semibold))
                        if !contact.relation.isEmpty {
                            Text(contact.relation)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }

            if !contact.note.isEmpty {
                Section("Notes") {
                    Text(contact.note)
                }
            }
        }
        .navigationTitle(contact.displayName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 4. Voicemail
struct VoicemailView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Spacer()
                
                Text("Appeler la messagerie")
                    .font(.headline)
                    .foregroundStyle(.blue)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(uiColor: .systemGray6))
                    )
                
                Spacer()
            }
            .navigationTitle("Messagerie vocale")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Message d'accueil") {}
                }
            }
        }
    }
}

// MARK: - 5. Favorites
struct FavoritesView: View {
    @Environment(\.lpspReadOnly) private var readOnly

    var body: some View {
        NavigationStack {
            Group {
                if readOnly {
                    ContentUnavailableView(
                        "Favorites",
                        systemImage: "star.fill",
                        description: Text("Aucun favori")
                    )
                } else {
                    favoritesDemoList
                }
            }
            .navigationTitle("Favoris")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) { Image(systemName: "plus") }
                        .disabled(readOnly)
                }
            }
        }
    }

    private var favoritesDemoList: some View {
        List {
            ForEach(0..<3) { _ in
                HStack(spacing: 15) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 35, height: 35)
                        .overlay(Text("TC").font(.caption).bold())
                    
                    VStack(alignment: .leading) {
                        Text("Tim Cook")
                            .fontWeight(.bold)
                        HStack {
                            Image(systemName: "iphone")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("mobile")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                        .font(.title2)
                }
                .padding(.vertical, 4)
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    PhoneView()
}
