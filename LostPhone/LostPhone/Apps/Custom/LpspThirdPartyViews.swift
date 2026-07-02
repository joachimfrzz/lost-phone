import SwiftUI

struct LpspUberView: View {
    let rides: [LpspRide]
    @State private var selected: LpspRide?

    private let uberBlack = Color.black

    var body: some View {
        NavigationStack {
            Group {
                if rides.isEmpty {
                    emptyState
                } else {
                    List(rides) { ride in
                        Button { selected = ride } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(formatRideDate(ride))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(ride.dropoff)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .lineLimit(2)
                                HStack {
                                    Text(ride.price)
                                        .font(.subheadline.weight(.semibold))
                                    Spacer()
                                    Text(ride.status.capitalized)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Uber"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(item: $selected) { ride in
                rideDetail(ride)
            }
        }
    }

    private var emptyState: some View {
        ContentUnavailableView(
            "Uber",
            systemImage: "car.fill",
            description: Text("Ajoutez des courses dans lpsp.json → content.apps.Uber")
        )
    }

    private func rideDetail(_ ride: LpspRide) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                mapPlaceholder
                VStack(alignment: .leading, spacing: 12) {
                    routeRow(icon: "circle.fill", color: .green, text: ride.pickup)
                    routeRow(icon: "square.fill", color: uberBlack, text: ride.dropoff)
                }
                Divider()
                detailRow("Chauffeur", ride.driver)
                detailRow("Véhicule", ride.vehicle)
                detailRow("Durée", ride.duration)
                detailRow("Prix", ride.price)
                detailRow("Statut", ride.status.capitalized)
            }
            .padding()
        }
        .navigationTitle(formatRideDate(ride))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var mapPlaceholder: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(Color(uiColor: .secondarySystemBackground))
            .frame(height: 160)
            .overlay {
                Image(systemName: "map")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }

    private func routeRow(icon: String, color: Color, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(color)
                .padding(.top, 4)
            Text(text)
                .font(.body)
        }
    }

    private func detailRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }

    private func formatRideDate(_ ride: LpspRide) -> String {
        if let d = ride.date {
            let f = DateFormatter()
            f.locale = Locale(identifier: "fr_FR")
            f.dateStyle = .medium
            f.timeStyle = .short
            return f.string(from: d)
        }
        return ride.dateRaw
    }
}

struct LpspBanqueView: View {
    let data: LpspBankData?
    @State private var selectedOp: LpspBankOperation?

    private let brandGreen = Color(red: 0.0, green: 0.45, blue: 0.25)

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    List {
                        Section {
                            ForEach(data.accounts) { account in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(account.type)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text(formatMoney(account.balance, currency: account.currency))
                                        .font(.title2.weight(.bold))
                                        .foregroundStyle(account.balance < 0 ? .red : .primary)
                                    Text(account.partialNumber)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        } header: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(data.holderName)
                                    .font(.headline)
                                if !data.branch.isEmpty {
                                    Text(data.branch)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }

                        Section("Opérations") {
                            ForEach(data.operations) { op in
                                Button { selectedOp = op } label: {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(op.label)
                                                .font(.subheadline)
                                                .foregroundStyle(.primary)
                                                .lineLimit(2)
                                            Text(formatOpDate(op))
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        Text(formatMoney(op.amount))
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundStyle(op.amount >= 0 ? .green : .primary)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                } else {
                    ContentUnavailableView(
                        "Banque",
                        systemImage: "building.columns.fill",
                        description: Text("Ajoutez content.apps.Banque dans lpsp.json")
                    )
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Banque"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(brandGreen, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(item: $selectedOp) { op in
                NavigationStack {
                    List {
                        LabeledContent("Libellé", value: op.label)
                        LabeledContent("Montant", value: formatMoney(op.amount))
                        LabeledContent("Catégorie", value: op.category)
                        LabeledContent("Date", value: formatOpDate(op))
                    }
                    .navigationTitle("Détail")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.medium])
            }
        }
    }

    private func formatMoney(_ value: Double, currency: String = "EUR") -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = currency
        f.locale = Locale(identifier: "fr_FR")
        return f.string(from: NSNumber(value: value)) ?? "\(value) €"
    }

    private func formatOpDate(_ op: LpspBankOperation) -> String {
        if let d = op.date {
            let f = DateFormatter()
            f.locale = Locale(identifier: "fr_FR")
            f.dateStyle = .short
            f.timeStyle = .short
            return f.string(from: d)
        }
        return op.dateRaw
    }
}

struct LpspPlansView: View {
    let data: LpspMapsData?
    @State private var segment = 0

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    VStack(spacing: 0) {
                        Picker("", selection: $segment) {
                            Text("Récents").tag(0)
                            Text("Enregistrés").tag(1)
                            Text("Itinéraires").tag(2)
                        }
                        .pickerStyle(.segmented)
                        .padding()

                        List {
                            switch segment {
                            case 0:
                                ForEach(data.trips) { trip in
                                    tripRow(trip)
                                }
                            case 1:
                                ForEach(data.places) { place in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(place.label)
                                            .font(.headline)
                                        Text(place.address)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 2)
                                }
                            default:
                                ForEach(data.routes) { route in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(route.name)
                                            .font(.headline)
                                        Text("\(route.origin) → \(route.destination)")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Text(route.duration)
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                } else {
                    ContentUnavailableView(
                        "Plans",
                        systemImage: "map.fill",
                        description: Text("Ajoutez content.apps.Plans dans lpsp.json")
                    )
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Plans"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func tripRow(_ trip: LpspMapTrip) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(trip.origin) → \(trip.destination)")
                .font(.subheadline.weight(.medium))
                .lineLimit(2)
            HStack {
                Text(trip.mode.capitalized)
                Text("·")
                Text(trip.duration)
                Spacer()
                Text(formatTripDate(trip))
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }

    private func formatTripDate(_ trip: LpspMapTrip) -> String {
        if let d = trip.date {
            let f = DateFormatter()
            f.locale = Locale(identifier: "fr_FR")
            f.dateStyle = .short
            return f.string(from: d)
        }
        return trip.dateRaw
    }
}

struct LpspFichiersView: View {
    let files: [LpspFileItem]
    @State private var selected: LpspFileItem?

    var body: some View {
        NavigationStack {
            Group {
                if files.isEmpty {
                    ContentUnavailableView("Fichiers", systemImage: "folder.fill")
                } else {
                    List(files) { file in
                        Button { selected = file } label: {
                            HStack(spacing: 12) {
                                Image(systemName: icon(for: file.type))
                                    .foregroundStyle(.blue)
                                    .frame(width: 28)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(file.name)
                                        .font(.body)
                                        .foregroundStyle(.primary)
                                    Text(file.path)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                                Spacer()
                                if !file.size.isEmpty {
                                    Text(file.size)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Fichiers"))
            .navigationDestination(item: $selected) { file in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Label(file.name, systemImage: icon(for: file.type))
                            .font(.title3.weight(.semibold))
                        Text(file.path)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        if !file.modifiedRaw.isEmpty {
                            Text("Modifié : \(file.modifiedRaw)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Divider()
                        Text(file.description)
                            .font(.body)
                    }
                    .padding()
                }
            }
        }
    }

    private func icon(for type: String) -> String {
        switch type.uppercased() {
        case "PDF": return "doc.fill"
        case "JPG", "JPEG", "PNG": return "photo.fill"
        default: return "doc.text.fill"
        }
    }
}

struct LpspRappelsView: View {
    let lists: [LpspReminderList]
    @State private var selected: LpspReminderList?

    var body: some View {
        NavigationStack {
            Group {
                if lists.isEmpty {
                    ContentUnavailableView("Rappels", systemImage: "checklist")
                } else {
                    List(lists) { list in
                        Button { selected = list } label: {
                            HStack {
                                Text(list.emoji)
                                    .font(.title2)
                                VStack(alignment: .leading) {
                                    Text(list.name)
                                        .font(.headline)
                                    Text("\(list.items.filter { !$0.completed }.count) en cours")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.tertiary)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Rappels"))
            .navigationDestination(item: $selected) { list in
                List(list.items) { item in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: item.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(item.completed ? .secondary : Color(red: 0.98, green: 0.73, blue: 0.08))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .strikethrough(item.completed)
                                .foregroundStyle(item.completed ? .secondary : .primary)
                            if !item.notes.isEmpty {
                                Text(item.notes)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .navigationTitle("\(list.emoji) \(list.name)")
            }
        }
    }
}

struct LpspInstagramView: View {
    let profile: LpspInstagramProfile?
    @State private var selected: LpspInstagramPost?

    var body: some View {
        NavigationStack {
            Group {
                if let profile {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 16) {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.purple, .orange, .pink],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 72, height: 72)
                                    .overlay {
                                        Image(systemName: "person.fill")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                    }
                                VStack(alignment: .leading) {
                                    Text(profile.username)
                                        .font(.headline)
                                    Text("\(profile.posts.count) publications")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Text(profile.bio)
                                .font(.subheadline)

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 2) {
                                ForEach(profile.posts) { post in
                                    Button { selected = post } label: {
                                        Rectangle()
                                            .fill(Color(uiColor: .secondarySystemBackground))
                                            .aspectRatio(1, contentMode: .fit)
                                            .overlay {
                                                Image(systemName: "photo")
                                                    .foregroundStyle(.secondary)
                                            }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    ContentUnavailableView("Instagram", systemImage: "camera.fill")
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Instagram"))
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selected) { post in
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(post.caption)
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.red)
                                Text("\(post.likes)")
                                Spacer()
                                Text(post.date)
                                    .foregroundStyle(.secondary)
                            }
                            .font(.subheadline)
                        }
                        .padding()
                    }
                    .navigationTitle("Publication")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.medium, .large])
            }
        }
    }
}

struct LpspSpotifyView: View {
    let data: LpspSpotifyData?
    @State private var selected: LpspSpotifyPlaylist?

    private let spotifyGreen = Color(red: 0.11, green: 0.73, blue: 0.33)

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    List {
                        Section {
                            Text(data.username)
                                .font(.title2.weight(.bold))
                            Text(data.plan)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Section("Playlists") {
                            ForEach(data.playlists) { pl in
                                Button { selected = pl } label: {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(spotifyGreen.opacity(0.3))
                                            .frame(width: 48, height: 48)
                                            .overlay {
                                                Image(systemName: "music.note.list")
                                            }
                                        VStack(alignment: .leading) {
                                            Text(pl.title)
                                                .font(.headline)
                                                .foregroundStyle(.primary)
                                            Text("\(pl.trackCount) titres")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        if !data.recentTracks.isEmpty {
                            Section("Écoutes récentes") {
                                ForEach(data.recentTracks) { track in
                                    VStack(alignment: .leading) {
                                        Text(track.title)
                                            .font(.subheadline)
                                        Text(track.artist)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ContentUnavailableView("Spotify", systemImage: "music.note")
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Spotify"))
            .navigationDestination(item: $selected) { pl in
                List(pl.tracks) { track in
                    VStack(alignment: .leading) {
                        Text(track.title)
                        Text(track.artist)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .navigationTitle(pl.title)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct LpspNetflixView: View {
    let data: LpspNetflixData?

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(data.profiles) { profile in
                                        VStack {
                                            Text(profile.avatar)
                                                .font(.system(size: 44))
                                                .frame(width: 72, height: 72)
                                                .background(Circle().fill(Color(uiColor: .secondarySystemBackground)))
                                            Text(profile.name)
                                                .font(.caption)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }

                            Text("Reprendre")
                                .font(.headline)
                                .padding(.horizontal)

                            ForEach(data.continueWatching) { item in
                                HStack(spacing: 12) {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.red.opacity(0.85))
                                        .frame(width: 100, height: 56)
                                        .overlay {
                                            Image(systemName: "play.fill")
                                                .foregroundStyle(.white)
                                        }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.title)
                                            .font(.subheadline.weight(.semibold))
                                        Text("\(item.kind) · \(item.profileName)")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Text(item.progress)
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                } else {
                    ContentUnavailableView("Netflix", systemImage: "play.tv.fill")
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Netflix"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
    }
}
