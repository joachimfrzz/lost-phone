import SwiftUI

// MARK: - Uber

struct LpspUberView: View {
    let rides: [LpspRide]
    @State private var selected: LpspRide?

    private let tabs: [LpspThirdPartyTabBar.Tab] = [
        .init(id: "home", icon: "house", label: "Accueil"),
        .init(id: "services", icon: "square.grid.2x2", label: "Services"),
        .init(id: "activity", icon: "clock", label: "Activité"),
        .init(id: "account", icon: "person", label: "Compte")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Group {
                    if rides.isEmpty {
                        ContentUnavailableView(
                            "Uber",
                            systemImage: "car.fill",
                            description: Text("Ajoutez des courses dans lpsp.json → content.apps.Uber")
                        )
                    } else {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                                ForEach(groupedRides, id: \.0) { section, sectionRides in
                                    Section {
                                        ForEach(sectionRides) { ride in
                                            Button { selected = ride } label: {
                                                LpspUberActivityRow(ride: ride)
                                            }
                                            .buttonStyle(.plain)
                                            Divider().padding(.leading, 76)
                                        }
                                    } header: {
                                        Text(section)
                                            .font(.footnote.weight(.semibold))
                                            .foregroundStyle(.secondary)
                                            .textCase(.uppercase)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color(uiColor: .systemBackground))
                                    }
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                }
                .frame(maxHeight: .infinity)

                LpspThirdPartyTabBar(tabs: tabs, selected: "activity", accent: LpspThirdPartyBrand.uberBlack)
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Activité")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "questionmark.circle")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationDestination(item: $selected) { ride in
                LpspUberRideDetailView(ride: ride)
            }
        }
    }

    private var groupedRides: [(String, [LpspRide])] {
        LpspThirdPartyGrouping.byDay(rides) { $0.date }
    }
}

private struct LpspUberActivityRow: View {
    let ride: LpspRide

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(LpspThirdPartyBrand.uberGray)
                .frame(width: 52, height: 52)
                .overlay {
                    Image(systemName: "car.side.fill")
                        .font(.title3)
                        .foregroundStyle(LpspThirdPartyBrand.uberBlack)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(ride.dropoff)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                Text(rideSubtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 4) {
                Text(ride.price)
                    .font(.subheadline.weight(.semibold))
                if !ride.status.isEmpty {
                    Text(ride.status.capitalized)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }

    private var rideSubtitle: String {
        let date = ride.date.map { LpspThirdPartyFormat.frenchDate($0, style: .medium, time: .short) } ?? ride.dateRaw
        if ride.driver.isEmpty { return date }
        return "\(date) · \(ride.driver)"
    }
}

private struct LpspUberRideDetailView: View {
    let ride: LpspRide

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LpspFakeMapView(accent: Color(red: 0.75, green: 0.82, blue: 0.70), height: 220)

                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(ride.price)
                                .font(.title2.weight(.bold))
                            Text(ride.status.capitalized)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if !ride.vehicle.isEmpty {
                            Text(ride.vehicle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }

                    LpspRouteTimeline(
                        origin: ride.pickup,
                        destination: ride.dropoff,
                        dropoffColor: LpspThirdPartyBrand.uberBlack
                    )

                    Divider()

                    if !ride.driver.isEmpty {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(LpspThirdPartyBrand.uberGray)
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Text(String(ride.driver.prefix(1)))
                                        .font(.headline)
                                }
                            VStack(alignment: .leading, spacing: 2) {
                                Text(ride.driver)
                                    .font(.subheadline.weight(.semibold))
                                Text("Chauffeur")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            HStack(spacing: 2) {
                                ForEach(0..<5, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .font(.caption2)
                                        .foregroundStyle(.yellow)
                                }
                            }
                        }
                    }

                    VStack(spacing: 10) {
                        LpspDetailRow(title: "Durée", value: ride.duration)
                        LpspDetailRow(title: "Date", value: detailDate)
                    }
                    .padding(16)
                    .background(LpspThirdPartyBrand.uberGray)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(20)
            }
        }
        .navigationTitle(detailDate)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var detailDate: String {
        ride.date.map { LpspThirdPartyFormat.frenchDate($0, style: .long, time: .short) } ?? ride.dateRaw
    }
}

// MARK: - Banque

struct LpspBanqueView: View {
    let data: LpspBankData?
    @State private var selectedOp: LpspBankOperation?

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ScrollView {
                        VStack(spacing: 0) {
                            banqueHeader(data)

                            VStack(alignment: .leading, spacing: 0) {
                                Text("Opérations")
                                    .font(.title3.weight(.bold))
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    .padding(.bottom, 12)

                                ForEach(groupedOperations(data.operations), id: \.0) { section, ops in
                                    Text(section)
                                        .font(.footnote.weight(.semibold))
                                        .foregroundStyle(.secondary)
                                        .textCase(.uppercase)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)

                                    ForEach(ops) { op in
                                        Button { selectedOp = op } label: {
                                            LpspBanqueOperationRow(operation: op)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .padding(.bottom, 24)
                        }
                    }
                    .background(Color(uiColor: .systemGroupedBackground))
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
            .toolbarBackground(LpspThirdPartyBrand.banqueGreen, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "bell")
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .sheet(item: $selectedOp) { op in
                LpspBanqueOperationSheet(operation: op)
            }
        }
        .tint(.white)
    }

    @ViewBuilder
    private func banqueHeader(_ data: LpspBankData) -> some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [LpspThirdPartyBrand.banqueGreen, LpspThirdPartyBrand.banqueGreenLight],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 280)

            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(data.holderName)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                    if !data.branch.isEmpty {
                        Text(data.branch)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.65))
                            .lineLimit(2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(data.accounts) { account in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(account.type)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(LpspThirdPartyFormat.money(account.balance, currency: account.currency))
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(account.balance < 0 ? .red : .primary)
                        Text(account.partialNumber)
                            .font(.caption.monospaced())
                            .foregroundStyle(.secondary)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.08), radius: 12, y: 4)
                }

                if !data.cardPartial.isEmpty {
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(
                                LinearGradient(
                                    colors: [LpspThirdPartyBrand.banqueGreen, Color(red: 0.1, green: 0.3, blue: 0.2)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 48, height: 32)
                            .overlay {
                                Image(systemName: "wave.3.right")
                                    .font(.caption2)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Visa")
                                .font(.caption.weight(.semibold))
                            Text(data.cardPartial)
                                .font(.caption.monospaced())
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("Active")
                            .font(.caption)
                            .foregroundStyle(.green)
                    }
                    .padding(16)
                    .background(.white.opacity(0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
    }

    private func groupedOperations(_ ops: [LpspBankOperation]) -> [(String, [LpspBankOperation])] {
        LpspThirdPartyGrouping.byDay(ops) { $0.date }
    }
}

private struct LpspBanqueOperationRow: View {
    let operation: LpspBankOperation

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(categoryColor.opacity(0.15))
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: categoryIcon)
                        .font(.subheadline)
                        .foregroundStyle(categoryColor)
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(operation.label)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                HStack(spacing: 6) {
                    if !operation.category.isEmpty {
                        Text(operation.category)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Text(opTime)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }

            Spacer(minLength: 8)

            Text(LpspThirdPartyFormat.money(operation.amount))
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(operation.amount >= 0 ? Color.green : .primary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(uiColor: .systemBackground))
    }

    private var opTime: String {
        operation.date.map { LpspThirdPartyFormat.frenchDate($0, style: .none, time: .short) } ?? ""
    }

    private var categoryIcon: String {
        switch operation.category.lowercased() {
        case let c where c.contains("restauration"): return "fork.knife"
        case let c where c.contains("transport"): return "car.fill"
        case let c where c.contains("abonnement"): return "repeat"
        case let c where c.contains("alimentation"): return "cart.fill"
        default: return "creditcard.fill"
        }
    }

    private var categoryColor: Color {
        switch operation.category.lowercased() {
        case let c where c.contains("restauration"): return .orange
        case let c where c.contains("transport"): return .blue
        default: return LpspThirdPartyBrand.banqueGreen
        }
    }
}

private struct LpspBanqueOperationSheet: View {
    let operation: LpspBankOperation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(LpspThirdPartyFormat.money(operation.amount))
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(operation.amount >= 0 ? .green : .primary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowBackground(Color.clear)
                }
                Section {
                    LabeledContent("Libellé", value: operation.label)
                    LabeledContent("Catégorie", value: operation.category.isEmpty ? "—" : operation.category)
                    LabeledContent("Date", value: LpspThirdPartyFormat.frenchDateRaw(operation.dateRaw))
                }
            }
            .navigationTitle("Détail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Plans (Apple Maps FR)

struct LpspPlansView: View {
    let data: LpspMapsData?
    @State private var selectedTrip: LpspMapTrip?
    @State private var segment = 0

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ZStack(alignment: .top) {
                        LpspFakeMapView(height: UIScreen.main.bounds.height * 0.42, showRoute: false)
                            .ignoresSafeArea(edges: .top)

                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: UIScreen.main.bounds.height * 0.30)

                            VStack(spacing: 0) {
                                Capsule()
                                    .fill(Color(uiColor: .systemGray3))
                                    .frame(width: 36, height: 5)
                                    .padding(.top, 8)
                                    .padding(.bottom, 12)

                                LpspSearchBar(placeholder: "Rechercher dans Plans")
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 12)

                                Picker("", selection: $segment) {
                                    Text("Récents").tag(0)
                                    Text("Enregistrés").tag(1)
                                    Text("Itinéraires").tag(2)
                                }
                                .pickerStyle(.segmented)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 8)

                                List {
                                    switch segment {
                                    case 0:
                                        ForEach(data.trips) { trip in
                                            Button { selectedTrip = trip } label: {
                                                LpspPlansTripRow(trip: trip)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    case 1:
                                        ForEach(data.places) { place in
                                            LpspPlansPlaceRow(place: place)
                                        }
                                    default:
                                        ForEach(data.routes) { route in
                                            LpspPlansRouteRow(route: route)
                                        }
                                    }
                                }
                                .listStyle(.plain)
                                .scrollContentBackground(.hidden)
                            }
                            .background(Color(uiColor: .systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.12), radius: 16, y: -4)
                        }
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
            .navigationDestination(item: $selectedTrip) { trip in
                LpspPlansTripDetailView(trip: trip)
            }
        }
    }
}

private struct LpspPlansTripRow: View {
    let trip: LpspMapTrip

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: modeIcon)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 4) {
                Text(trip.destination)
                    .font(.subheadline.weight(.medium))
                    .lineLimit(1)
                Text("\(trip.origin) · \(trip.duration)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            Text(trip.date.map { LpspThirdPartyFormat.frenchDate($0, style: .short) } ?? "")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }

    private var modeIcon: String {
        switch trip.mode.lowercased() {
        case let m where m.contains("pied"): return "figure.walk"
        case let m where m.contains("voiture"): return "car.fill"
        case let m where m.contains("transit"): return "tram.fill"
        default: return "location.fill"
        }
    }
}

private struct LpspPlansPlaceRow: View {
    let place: LpspMapPlace

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "mappin.circle.fill")
                .font(.title2)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, LpspThirdPartyBrand.plansPin)
            VStack(alignment: .leading, spacing: 3) {
                Text(place.label)
                    .font(.subheadline.weight(.semibold))
                Text(place.address)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

private struct LpspPlansRouteRow: View {
    let route: LpspSavedRoute

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(route.name.isEmpty ? "Itinéraire enregistré" : route.name)
                .font(.subheadline.weight(.semibold))
            Text("\(route.origin) → \(route.destination)")
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            Text(route.duration)
                .font(.caption2)
                .foregroundStyle(.blue)
        }
        .padding(.vertical, 4)
    }
}

private struct LpspPlansTripDetailView: View {
    let trip: LpspMapTrip

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                LpspFakeMapView(height: 240)
                VStack(alignment: .leading, spacing: 20) {
                    LpspRouteTimeline(origin: trip.origin, destination: trip.destination, dropoffColor: LpspThirdPartyBrand.plansPin)
                    HStack {
                        Label(trip.mode.capitalized, systemImage: "figure.walk")
                        Spacer()
                        Text(trip.duration)
                            .foregroundStyle(.secondary)
                    }
                    .font(.subheadline)
                }
                .padding(20)
            }
        }
        .navigationTitle(LpspThirdPartyFormat.frenchDate(trip.date, style: .medium))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Fichiers

struct LpspFichiersView: View {
    let files: [LpspFileItem]
    @State private var selected: LpspFileItem?
    @State private var browsePath: String?

    var body: some View {
        NavigationStack {
            Group {
                if files.isEmpty {
                    ContentUnavailableView("Fichiers", systemImage: "folder.fill")
                } else if let browsePath {
                    folderContents(path: browsePath)
                } else {
                    browseRoot
                }
            }
            .navigationTitle(browsePath ?? LpspAppCatalog.displayName("Fichiers"))
            .navigationBarTitleDisplayMode(browsePath == nil ? .large : .inline)
            .toolbar {
                if browsePath != nil {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            browsePath = parentPath(of: browsePath!)
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                Text("Parcourir")
                            }
                        }
                    }
                }
            }
            .navigationDestination(item: $selected) { file in
                LpspFileDetailView(file: file)
            }
        }
    }

    private var browseRoot: some View {
        List {
            if !deletedFiles.isEmpty {
                Section {
                    Button { browsePath = "Récemment supprimés/" } label: {
                        LpspFilesLocationRow(
                            icon: "trash",
                            color: .gray,
                            title: "Récemment supprimés",
                            subtitle: "\(deletedFiles.count) élément\(deletedFiles.count > 1 ? "s" : "")"
                        )
                    }
                    .buttonStyle(.plain)
                }
            }

            Section {
                ForEach(rootLocations, id: \.self) { location in
                    Button { browsePath = location } label: {
                        LpspFilesLocationRow(
                            icon: location.contains("iCloud") ? "icloud.fill" : "iphone",
                            color: .blue,
                            title: location.trimmingCharacters(in: CharacterSet(charactersIn: "/")),
                            subtitle: "\(fileCount(in: location)) élément\(fileCount(in: location) > 1 ? "s" : "")"
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private func folderContents(path: String) -> some View {
        List {
            let subfolders = subfolders(in: path)
            if !subfolders.isEmpty {
                Section {
                    ForEach(subfolders, id: \.self) { folder in
                        Button { browsePath = path + folder + "/" } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "folder.fill")
                                    .foregroundStyle(.blue)
                                    .font(.title3)
                                Text(folder)
                                    .foregroundStyle(.primary)
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

            Section {
                ForEach(filesIn(path: path)) { file in
                    Button { selected = file } label: {
                        LpspFileRow(file: file)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.insetGrouped)
    }

    private var deletedFiles: [LpspFileItem] { files.filter(\.isDeleted) }

    private var rootLocations: [String] {
        Array(Set(files.filter { !$0.isDeleted }.map { rootOf($0.path) })).sorted()
    }

    private func rootOf(_ path: String) -> String {
        let parts = path.split(separator: "/").map(String.init)
        guard let first = parts.first else { return path }
        return first + "/"
    }

    private func fileCount(in location: String) -> Int {
        files.filter { !$0.isDeleted && $0.path.hasPrefix(location) }.count
    }

    private func subfolders(in path: String) -> [String] {
        var names = Set<String>()
        for file in files where !file.isDeleted && file.path.hasPrefix(path) {
            let remainder = String(file.path.dropFirst(path.count))
            if let first = remainder.split(separator: "/").first, !first.isEmpty {
                names.insert(String(first))
            }
        }
        return names.sorted()
    }

    private func filesIn(path: String) -> [LpspFileItem] {
        if path == "Récemment supprimés/" { return deletedFiles }
        return files.filter { file in
            !file.isDeleted && file.path == path
        }
    }

    private func parentPath(of path: String) -> String? {
        let trimmed = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let parts = trimmed.split(separator: "/").map(String.init)
        guard parts.count > 1 else { return nil }
        return parts.dropLast().joined(separator: "/") + "/"
    }
}

private struct LpspFilesLocationRow: View {
    let icon: String
    let color: Color
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 32)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}

private struct LpspFileRow: View {
    let file: LpspFileItem

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: fileIcon)
                .font(.title3)
                .foregroundStyle(file.isDeleted ? .gray : fileColor)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(file.name)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                if !file.size.isEmpty {
                    Text(file.size)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
        .padding(.vertical, 2)
    }

    private var fileIcon: String {
        switch file.type.uppercased() {
        case "PDF": return "doc.fill"
        case "JPG", "JPEG", "PNG": return "photo.fill"
        case "M4A", "MP3": return "waveform"
        default: return "doc.text.fill"
        }
    }

    private var fileColor: Color {
        switch file.type.uppercased() {
        case "PDF": return .red
        case "JPG", "JPEG", "PNG": return .purple
        default: return .blue
        }
    }
}

private struct LpspFileDetailView: View {
    let file: LpspFileItem

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(uiColor: .secondarySystemBackground))
                    .frame(height: 200)
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "doc.richtext.fill")
                                .font(.system(size: 44))
                                .foregroundStyle(.secondary)
                            Text(file.type)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
                    }

                Text(file.name)
                    .font(.title3.weight(.semibold))

                if file.isDeleted {
                    Label("Récemment supprimé", systemImage: "trash")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }

                if !file.modifiedRaw.isEmpty {
                    Text(LpspThirdPartyFormat.frenchDateRaw(file.modifiedRaw))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Divider()

                Text(file.description)
                    .font(.body)
                    .foregroundStyle(.primary)
            }
            .padding(20)
        }
        .navigationTitle(file.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Rappels

struct LpspRappelsView: View {
    let lists: [LpspReminderList]
    @State private var selected: LpspReminderList?

    var body: some View {
        NavigationStack {
            Group {
                if lists.isEmpty {
                    ContentUnavailableView("Rappels", systemImage: "checklist")
                } else {
                    List {
                        ForEach(lists) { list in
                            Button { selected = list } label: {
                                LpspReminderListRow(list: list)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle(LpspAppCatalog.displayName("Rappels"))
            .navigationDestination(item: $selected) { list in
                LpspReminderDetailView(list: list)
            }
        }
    }
}

private struct LpspReminderListRow: View {
    let list: LpspReminderList

    var body: some View {
        HStack(spacing: 14) {
            Text(list.emoji)
                .font(.title2)
                .frame(width: 36)
            VStack(alignment: .leading, spacing: 3) {
                Text(list.name)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.primary)
                Text("\(openCount) en cours")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }

    private var openCount: Int {
        list.items.filter { !$0.completed }.count
    }
}

private struct LpspReminderDetailView: View {
    let list: LpspReminderList

    var body: some View {
        List {
            ForEach(list.items) { item in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: item.completed ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(item.completed ? Color(uiColor: .systemGray3) : LpspThirdPartyBrand.remindersYellow)
                        .padding(.top, 1)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.body)
                            .strikethrough(item.completed)
                            .foregroundStyle(item.completed ? .secondary : .primary)
                        if !item.notes.isEmpty {
                            Text(item.notes)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        if !item.dueRaw.isEmpty {
                            Text(LpspThirdPartyFormat.frenchDateRaw(item.dueRaw))
                                .font(.caption2)
                                .foregroundStyle(item.priority == "haute" ? .red : .secondary)
                        }
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(list.emoji) \(list.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Instagram

struct LpspInstagramView: View {
    let profile: LpspInstagramProfile?
    @State private var selected: LpspInstagramPost?

    private let tabs: [LpspThirdPartyTabBar.Tab] = [
        .init(id: "home", icon: "house", label: "Accueil"),
        .init(id: "search", icon: "magnifyingglass", label: "Recherche"),
        .init(id: "post", icon: "plus.app", label: ""),
        .init(id: "reels", icon: "play.rectangle", label: "Reels"),
        .init(id: "profile", icon: "person", label: "Profil")
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Group {
                    if let profile {
                        ScrollView {
                            VStack(spacing: 0) {
                                profileHeader(profile)
                                postGrid(profile.posts)
                            }
                        }
                    } else {
                        ContentUnavailableView("Instagram", systemImage: "camera.fill")
                    }
                }
                .frame(maxHeight: .infinity)

                LpspThirdPartyTabBar(tabs: tabs, selected: "profile", accent: .primary)
            }
            .navigationTitle(LpspAppCatalog.displayName("Instagram"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text(LpspAppCatalog.displayName("Instagram"))
                        .font(.title3.weight(.bold))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Image(systemName: "plus.app")
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }
            .sheet(item: $selected) { post in
                LpspInstagramPostSheet(post: post, username: profile?.username ?? "")
            }
        }
    }

    @ViewBuilder
    private func profileHeader(_ profile: LpspInstagramProfile) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 20) {
                Circle()
                    .strokeBorder(LpspThirdPartyBrand.instagramGradient, lineWidth: 3)
                    .frame(width: 86, height: 86)
                    .overlay {
                        Circle()
                            .fill(Color(uiColor: .secondarySystemBackground))
                            .padding(3)
                            .overlay {
                                Image(systemName: "person.fill")
                                    .font(.title)
                                    .foregroundStyle(.secondary)
                            }
                    }

                HStack(spacing: 0) {
                    statColumn("\(profile.posts.count)", "publications")
                    statColumn("412", "abonnés")
                    statColumn("318", "abonnements")
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(profile.username)
                    .font(.subheadline.weight(.semibold))
                Text(profile.bio)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }

            HStack(spacing: 8) {
                profileButton("Modifier le profil", filled: true)
                profileButton("Partager le profil", filled: false)
                Image(systemName: "person.badge.plus")
                    .frame(width: 36, height: 32)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            HStack(spacing: 0) {
                Image(systemName: "square.grid.3x3.fill")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(.primary).frame(height: 1)
                    }
                Image(systemName: "person.crop.rectangle")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    private func statColumn(_ value: String, _ label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.subheadline.weight(.bold))
            Text(label)
                .font(.caption2)
        }
        .frame(maxWidth: .infinity)
    }

    private func profileButton(_ title: String, filled: Bool) -> some View {
        Text(title)
            .font(.caption.weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 7)
            .background(filled ? Color(uiColor: .secondarySystemBackground) : Color.clear)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color(uiColor: .systemGray4), lineWidth: filled ? 0 : 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func postGrid(_ posts: [LpspInstagramPost]) -> some View {
        LazyVGrid(
            columns: [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)],
            spacing: 1
        ) {
            ForEach(posts) { post in
                Button { selected = post } label: {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [Color(uiColor: .systemGray5), Color(uiColor: .systemGray4)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            Image(systemName: "photo")
                                .foregroundStyle(.white.opacity(0.6))
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct LpspInstagramPostSheet: View {
    let post: LpspInstagramPost
    let username: String

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .fill(Color(uiColor: .secondarySystemBackground))
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            Image(systemName: "photo.artframe")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                        }

                    HStack(spacing: 16) {
                        Image(systemName: "heart")
                        Image(systemName: "bubble.right")
                        Image(systemName: "paperplane")
                        Spacer()
                        Image(systemName: "bookmark")
                    }
                    .font(.title3)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)

                    Text("\(post.likes) J'aime")
                        .font(.subheadline.weight(.semibold))
                        .padding(.horizontal, 16)

                    Text("\(username) \(post.caption)")
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.top, 4)

                    Text(post.date)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .textCase(.uppercase)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                }
            }
            .navigationTitle("Publication")
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Spotify

struct LpspSpotifyView: View {
    let data: LpspSpotifyData?
    @State private var selected: LpspSpotifyPlaylist?

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Group {
                    if let data {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                header(data)
                                if !data.recentTracks.isEmpty {
                                    recentSection(data.recentTracks)
                                }
                                playlistsSection(data.playlists)
                            }
                            .padding(.bottom, 88)
                        }
                    } else {
                        ContentUnavailableView("Spotify", systemImage: "music.note")
                    }
                }

                if data != nil {
                    LpspSpotifyMiniPlayer()
                }
            }
            .background(LpspThirdPartyBrand.spotifyBlack)
            .navigationTitle("Accueil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(LpspThirdPartyBrand.spotifyBlack, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .navigationDestination(item: $selected) { pl in
                LpspSpotifyPlaylistDetail(playlist: pl)
            }
        }
        .preferredColorScheme(.dark)
    }

    @ViewBuilder
    private func header(_ data: LpspSpotifyData) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bonjour")
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
            Text(data.username)
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text(data.plan)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.55))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.white.opacity(0.12))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    private func recentSection(_ tracks: [LpspSpotifyTrack]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Écoutes récentes")
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(tracks.prefix(8)) { track in
                        VStack(alignment: .leading, spacing: 8) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(
                                    LinearGradient(
                                        colors: [LpspThirdPartyBrand.spotifyGreen.opacity(0.6), LpspThirdPartyBrand.spotifyCard],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 140, height: 140)
                                .overlay {
                                    Image(systemName: "music.note")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white.opacity(0.7))
                                }
                            Text(track.title)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .frame(width: 140, alignment: .leading)
                            Text(track.artist)
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.55))
                                .lineLimit(1)
                                .frame(width: 140, alignment: .leading)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func playlistsSection(_ playlists: [LpspSpotifyPlaylist]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Vos playlists")
                .font(.title3.weight(.bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ForEach(playlists) { pl in
                Button { selected = pl } label: {
                    HStack(spacing: 14) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LpspThirdPartyBrand.spotifyGreen.opacity(0.35))
                            .frame(width: 56, height: 56)
                            .overlay {
                                Image(systemName: "music.note.list")
                                    .foregroundStyle(.white)
                            }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(pl.title)
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                            Text("\(pl.trackCount) titres")
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.55))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

private struct LpspSpotifyMiniPlayer: View {
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(LpspThirdPartyBrand.spotifyGreen.opacity(0.4))
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: "music.note")
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 2) {
                Text("Lecture en cours")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                Text("Spotify Free")
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.55))
            }
            Spacer()
            Image(systemName: "laptopcomputer.and.iphone")
                .foregroundStyle(.white.opacity(0.7))
            Image(systemName: "play.fill")
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(LpspThirdPartyBrand.spotifyCard)
        .overlay(alignment: .top) {
            Rectangle().fill(.white.opacity(0.08)).frame(height: 0.5)
        }
    }
}

private struct LpspSpotifyPlaylistDetail: View {
    let playlist: LpspSpotifyPlaylist

    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LpspThirdPartyBrand.spotifyGreen.opacity(0.5))
                        .frame(width: 120, height: 120)
                        .overlay {
                            Image(systemName: "music.note.list")
                                .font(.largeTitle)
                                .foregroundStyle(.white)
                        }
                    VStack(alignment: .leading, spacing: 6) {
                        Text(playlist.title)
                            .font(.title2.weight(.bold))
                        Text("\(playlist.trackCount) titres")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .listRowBackground(Color.clear)
            }

            Section {
                ForEach(Array(playlist.tracks.enumerated()), id: \.element.id) { index, track in
                    HStack(spacing: 14) {
                        Text("\(index + 1)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(width: 24, alignment: .trailing)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(track.title)
                                .font(.subheadline)
                            Text(track.artist)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(LpspThirdPartyBrand.spotifyBlack)
        .navigationTitle(playlist.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Netflix

struct LpspNetflixView: View {
    let data: LpspNetflixData?
    @State private var selectedProfile: LpspNetflixProfile?

    var body: some View {
        NavigationStack {
            Group {
                if let data {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            profileRow(data.profiles)
                            if !data.continueWatching.isEmpty {
                                continueSection(data.continueWatching)
                            }
                            accountSection(data)
                        }
                        .padding(.vertical, 16)
                    }
                    .background(LpspThirdPartyBrand.netflixBlack)
                    .onAppear {
                        if selectedProfile == nil {
                            selectedProfile = data.profiles.first
                        }
                    }
                } else {
                    ContentUnavailableView("Netflix", systemImage: "play.tv.fill")
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("N")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundStyle(LpspThirdPartyBrand.netflixRed)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "bell")
                        .foregroundStyle(.white)
                }
            }
            .toolbarBackground(LpspThirdPartyBrand.netflixBlack, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    private func profileRow(_ profiles: [LpspNetflixProfile]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(profiles) { profile in
                    VStack(spacing: 8) {
                        Circle()
                            .fill(profile.isKids ? Color.blue.opacity(0.35) : Color.red.opacity(0.35))
                            .frame(width: 72, height: 72)
                            .overlay {
                                Text(String(profile.avatar.prefix(1)))
                                    .font(.title.weight(.bold))
                                    .foregroundStyle(.white)
                            }
                            .overlay {
                                Circle()
                                    .strokeBorder(selectedProfile?.id == profile.id ? .white : .clear, lineWidth: 2)
                            }
                        Text(profile.name)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .onTapGesture { selectedProfile = profile }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private func continueSection(_ items: [LpspNetflixItem]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Reprendre pour \(selectedProfile?.name ?? items.first?.profileName ?? "Mathieu")")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filteredItems(items)) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(
                                        LinearGradient(
                                            colors: [LpspThirdPartyBrand.netflixRed.opacity(0.8), .black],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 140, height: 78)
                                    .overlay {
                                        Image(systemName: "play.fill")
                                            .font(.title2)
                                            .foregroundStyle(.white.opacity(0.9))
                                    }

                                GeometryReader { geo in
                                    Rectangle()
                                        .fill(LpspThirdPartyBrand.netflixRed)
                                        .frame(width: geo.size.width * progressFraction(item.progress))
                                }
                                .frame(height: 3)
                            }
                            .frame(width: 140, height: 78)

                            Text(item.title)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.white)
                                .lineLimit(2)
                                .frame(width: 140, alignment: .leading)

                            Text(item.progress)
                                .font(.caption2)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func accountSection(_ data: LpspNetflixData) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Compte")
                .font(.headline)
                .foregroundStyle(.white)
            Text(data.holder)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))
            Text(data.plan)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.55))
        }
        .padding(.horizontal, 16)
    }

    private func filteredItems(_ items: [LpspNetflixItem]) -> [LpspNetflixItem] {
        guard let profile = selectedProfile else { return items }
        return items.filter { $0.profileName.localizedCaseInsensitiveContains(profile.name.prefix(4)) || profile.name.contains($0.profileName) }
    }

    private func progressFraction(_ progress: String) -> CGFloat {
        let parts = progress.split(separator: "/").map { $0.trimmingCharacters(in: .whitespaces) }
        guard parts.count == 2 else { return 0.35 }
        let current = parseMinutes(parts[0])
        let total = parseMinutes(parts[1])
        guard total > 0 else { return 0.35 }
        return min(1, max(0, current / total))
    }

    private func parseMinutes(_ text: String) -> CGFloat {
        if text.contains("h") {
            let bits = text.replacingOccurrences(of: "min", with: "").split(separator: "h")
            if bits.count == 2, let h = Double(bits[0]), let m = Double(bits[1]) {
                return CGFloat(h * 60 + m)
            }
        }
        if let m = Double(text.replacingOccurrences(of: "min", with: "").trimmingCharacters(in: .whitespaces)) {
            return CGFloat(m)
        }
        return 0
    }
}
