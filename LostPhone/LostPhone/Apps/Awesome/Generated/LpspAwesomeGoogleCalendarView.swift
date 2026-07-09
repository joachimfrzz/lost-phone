import SwiftUI

// Fidélité Spectr — écran d'accueil = preview galerie https://www.spectr.to/gallery/google-calendar
// Meliwat/awesome-ios-design-md/productivity/google-calendar/DESIGN-swiftui.md
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGoogleCalendarView: View {
    var body: some View {
        LpspGoogleCalendarShowroomRoot(store: LpspGoogleCalendarStore())
    }
}

// MARK: - Composants spec (préfixés)
private enum LpspGoogleCalendarTokens {
    // MARK: - Canvas & Surfaces
    static let gcalCanvas       = Color(red: 1.00, green: 1.00, blue: 1.00)    // #FFFFFF
    static let gcalSurfaceGray  = Color(red: 0.945, green: 0.953, blue: 0.957) // #F1F3F4
    static let gcalSurfaceGray2 = Color(red: 0.973, green: 0.976, blue: 0.980) // #F8F9FA
    static let gcalDivider      = Color(red: 0.855, green: 0.863, blue: 0.878) // #DADCE0

    // MARK: - Text
    static let gcalInk          = Color(red: 0.125, green: 0.129, blue: 0.141) // #202124
    static let gcalSecondary    = Color(red: 0.373, green: 0.388, blue: 0.408) // #5F6368
    static let gcalTertiary     = Color(red: 0.502, green: 0.525, blue: 0.545) // #80868B

    // MARK: - Brand & Actions
    static let gcalBlue         = Color(red: 0.102, green: 0.451, blue: 0.910) // #1A73E8 primary
    static let gcalBluePressed  = Color(red: 0.082, green: 0.341, blue: 0.690) // #1557B0
    static let gcalBlueTint     = Color(red: 0.910, green: 0.941, blue: 0.996) // #E8F0FE selected
    static let gcalBlueDark     = Color(red: 0.541, green: 0.706, blue: 0.973) // #8AB4F8 dark mode

    // MARK: - Event Colors (Material Primary Set)
    static let gcalEventBlue    = Color(red: 0.102, green: 0.451, blue: 0.910) // #1A73E8
    static let gcalEventRed     = Color(red: 0.851, green: 0.188, blue: 0.145) // #D93025
    static let gcalEventYellow  = Color(red: 0.976, green: 0.671, blue: 0.00)  // #F9AB00
    static let gcalEventGreen   = Color(red: 0.094, green: 0.502, blue: 0.220) // #188038

    // MARK: - 24-Color Calendar Palette (user-selectable)
    static let gcalTomato       = Color(red: 0.835, green: 0.00,  blue: 0.00)  // #D50000
    static let gcalFlamingo     = Color(red: 0.902, green: 0.486, blue: 0.451) // #E67C73
    static let gcalTangerine    = Color(red: 0.957, green: 0.318, blue: 0.118) // #F4511E
    static let gcalBanana       = Color(red: 0.965, green: 0.749, blue: 0.149) // #F6BF26
    static let gcalSage         = Color(red: 0.200, green: 0.714, blue: 0.475) // #33B679
    static let gcalBasil        = Color(red: 0.043, green: 0.502, blue: 0.263) // #0B8043
    static let gcalPeacock      = Color(red: 0.012, green: 0.608, blue: 0.898) // #039BE5
    static let gcalBlueberry    = Color(red: 0.247, green: 0.318, blue: 0.710) // #3F51B5
    static let gcalLavender     = Color(red: 0.475, green: 0.525, blue: 0.796) // #7986CB
    static let gcalGrape        = Color(red: 0.557, green: 0.141, blue: 0.667) // #8E24AA
    static let gcalGraphite     = Color(red: 0.380, green: 0.380, blue: 0.380) // #616161

    // MARK: - Dark mode
    static let gcalDarkCanvas   = Color(red: 0.125, green: 0.129, blue: 0.141) // #202124
    static let gcalDarkSurface  = Color(red: 0.176, green: 0.180, blue: 0.188) // #2D2E30
    static let gcalDarkSurface2 = Color(red: 0.235, green: 0.251, blue: 0.263) // #3C4043
    static let gcalDarkText     = Color(red: 0.910, green: 0.918, blue: 0.929) // #E8EAED
    static let gcalDarkTextSec  = Color(red: 0.604, green: 0.627, blue: 0.651) // #9AA0A6
}

private enum LpspGoogleCalendarFonts {
    // Nav titles (Google Sans Display)
    static let gcalNavTitle      = Font.system(size: 22, weight: .regular)
    static let gcalDayNumberLg   = Font.system(size: 36, weight: .regular)
    static let gcalSectionHdr    = Font.system(size: 14, weight: .regular)
    static let gcalDayLabel      = Font.system(size: 13, weight: .regular)

    // Event detail
    static let gcalEventDetail   = Font.system(size: 22, weight: .regular)

    // Event card body (SF Pro Text on iOS — system fallback)
    static let gcalEventTitle    = Font.system(size: 14, weight: .medium)
    static let gcalEventTime     = Font.system(size: 13, weight: .regular)
    static let gcalEventLocation = Font.system(size: 13, weight: .regular)

    // Tinted block (Day/Week view)
    static let gcalBlockTitle    = Font.system(size: 12, weight: .medium)
    static let gcalBlockTime     = Font.system(size: 11, weight: .regular)

    // Month grid
    static let gcalDayNumber     = Font.system(size: 14, weight: .regular)
    static let gcalTodayNumber   = Font.system(size: 14, weight: .regular)
    static let gcalWeekdayHdr    = Font.system(size: 12, weight: .medium)

    // Time gutter
    static let gcalTimeGutter    = Font.system(size: 11, weight: .regular)

    // Sidebar / Drawer
    static let gcalSidebar       = Font.system(size: 14, weight: .medium)

    // Buttons (Google Sans Medium, tracked)
    static let gcalButton        = Font.system(size: 14, weight: .regular)

    // Misc
    static let gcalTabLabel      = Font.system(size: 10, weight: .medium)
    static let gcalCaption       = Font.system(size: 12, weight: .regular)
}

fileprivate struct LpspGoogleCalendarEventCard: View {
    let title: String
    let timeRange: String       // "9:00 – 9:30 AM"
    let location: String?
    let meetLabel: String?
    let calendarColor: Color    // e.g., LpspGoogleCalendarTokens.gcalBlueberry
    var isSelected = false
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .fill(calendarColor)
                    .frame(width: 4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(LpspGoogleCalendarFonts.gcalEventTitle)
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                        .lineLimit(2)

                    Text(timeRange)
                        .font(LpspGoogleCalendarFonts.gcalEventTime)
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)

                    if let meetLabel {
                        HStack(spacing: 4) {
                            Image(systemName: "video.fill")
                                .font(.system(size: 11))
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalBlue)
                            Text(meetLabel)
                                .font(LpspGoogleCalendarFonts.gcalEventLocation)
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalBlue)
                                .lineLimit(1)
                        }
                    } else if let location = location {
                        HStack(spacing: 4) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 11))
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                            Text(location)
                                .font(LpspGoogleCalendarFonts.gcalEventLocation)
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)

                Spacer()
            }
            .frame(minHeight: 56)
            .background(
                RoundedRectangle(cornerRadius: 4, style: .continuous)
                    .fill(isSelected ? LpspGoogleCalendarTokens.gcalBlueTint : LpspGoogleCalendarTokens.gcalCanvas)
            )
            .shadow(color: Color(red: 0.235, green: 0.251, blue: 0.263).opacity(0.10), radius: 1, y: 1)
            .shadow(color: Color(red: 0.235, green: 0.251, blue: 0.263).opacity(0.15), radius: 3, y: 1)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspGoogleCalendarDayBanner: View {
    let dayNumber: String       // "14"
    let dayLabel: String        // "THU · MAY"
    let weatherSymbol: String?  // "sun.max.fill"
    let temperature: String?    // "72°"
    let isToday: Bool

    var body: some View {
        HStack(spacing: 16) {
            // Day number + label
            VStack(alignment: .leading, spacing: 4) {
                Text(dayLabel)
                    .font(LpspGoogleCalendarFonts.gcalDayLabel)
                    .tracking(0.8)
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)

                if isToday {
                    ZStack {
                        Circle()
                            .fill(LpspGoogleCalendarTokens.gcalBlue)
                            .frame(width: 56, height: 56)
                        Text(dayNumber)
                            .font(LpspGoogleCalendarFonts.gcalDayNumberLg)
                            .foregroundStyle(.white)
                    }
                } else {
                    Text(dayNumber)
                        .font(LpspGoogleCalendarFonts.gcalDayNumberLg)
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                }
            }

            Spacer()

            if let symbol = weatherSymbol, let temp = temperature {
                HStack(spacing: 8) {
                    Image(systemName: symbol)
                        .font(.system(size: 20))
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalEventYellow)
                    Text(temp)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 80)
    }
}

fileprivate struct LpspGoogleCalendarGcalFAB: View {
    var action: () -> Void
    @State private var pressed = false

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .regular))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(
                    Circle().fill(LpspGoogleCalendarTokens.gcalBlue)
                )
                // Material Level 6 dual shadow
                .shadow(color: Color(red: 0.235, green: 0.251, blue: 0.263).opacity(pressed ? 0.30 : 0.15),
                        radius: pressed ? 6 : 4, y: pressed ? 6 : 4)
                .shadow(color: Color(red: 0.235, green: 0.251, blue: 0.263).opacity(pressed ? 0.40 : 0.30),
                        radius: pressed ? 2 : 1, y: pressed ? 2 : 1)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .medium), trigger: pressed)
        .pressEvents(onPress: { pressed = true }, onRelease: { pressed = false })
    }
}

fileprivate extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in onPress() }
                .onEnded   { _ in onRelease() }
        )
    }
}

fileprivate struct LpspGoogleCalendarMonthCell: View {
    let day: Int
    let isToday: Bool
    let isCurrentMonth: Bool
    let events: [Color] // up to 3 event-source colors as small dots

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                if isToday {
                    ZStack {
                        Circle().fill(LpspGoogleCalendarTokens.gcalBlue).frame(width: 28, height: 28)
                        Text("\(day)")
                            .font(LpspGoogleCalendarFonts.gcalTodayNumber)
                            .foregroundStyle(.white)
                    }
                } else {
                    Text("\(day)")
                        .font(LpspGoogleCalendarFonts.gcalDayNumber)
                        .foregroundStyle(isCurrentMonth ? LpspGoogleCalendarTokens.gcalInk : LpspGoogleCalendarTokens.gcalTertiary)
                        .padding(.leading, 4)
                        .padding(.top, 4)
                }
                Spacer()
            }

            HStack(spacing: 2) {
                ForEach(events.prefix(3), id: \.description) { color in
                    Circle().fill(color).frame(width: 4, height: 4)
                }
                if events.count > 3 {
                    Text("+\(events.count - 3)")
                        .font(.system(size: 9, weight: .medium))
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalTertiary)
                }
            }
            .padding(.leading, 4)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 52, alignment: .topLeading)
        .background(LpspGoogleCalendarTokens.gcalCanvas)
        .overlay(alignment: .top) {
            Rectangle().fill(LpspGoogleCalendarTokens.gcalDivider).frame(height: 0.5)
        }
    }
}

fileprivate struct LpspGoogleCalendarTintedEventBlock: View {
    let title: String
    let timeRange: String
    let calendarColor: Color
    let heightPt: CGFloat   // determined by event duration

    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(calendarColor)
                .frame(width: 3)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(LpspGoogleCalendarFonts.gcalBlockTitle)
                    .foregroundStyle(calendarColor)
                    .lineLimit(1)
                if heightPt > 32 {
                    Text(timeRange)
                        .font(LpspGoogleCalendarFonts.gcalBlockTime)
                        .foregroundStyle(calendarColor.opacity(0.85))
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: heightPt, alignment: .top)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(calendarColor.opacity(0.20))
        )
    }
}

fileprivate struct LpspGoogleCalendarDrawerSection: View {
    let title: String?
    let items: [LpspGoogleCalendarDrawerItem]
    @Binding var selected: String

    struct LpspGoogleCalendarDrawerItem {
        let id: String
        let icon: String
        let label: String
        let color: Color?    // for calendar swatches
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = title {
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .tracking(0.4)
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            ForEach(items, id: \.id) { item in
                LpspGoogleCalendarDrawerRow(item: item, isSelected: selected == item.id) {
                    selected = item.id
                }
            }
        }
    }
}

fileprivate struct LpspGoogleCalendarDrawerRow: View {
    let item: LpspGoogleCalendarDrawerSection.LpspGoogleCalendarDrawerItem
    let isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                if let color = item.color {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(color)
                        .frame(width: 18, height: 18)
                } else {
                    Image(systemName: item.icon)
                        .font(.system(size: 20))
                        .foregroundStyle(isSelected ? LpspGoogleCalendarTokens.gcalBlue : LpspGoogleCalendarTokens.gcalSecondary)
                        .frame(width: 24)
                }
                Text(item.label)
                    .font(LpspGoogleCalendarFonts.gcalSidebar)
                    .foregroundStyle(isSelected ? LpspGoogleCalendarTokens.gcalBlue : LpspGoogleCalendarTokens.gcalInk)
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(isSelected ? LpspGoogleCalendarTokens.gcalBlueTint : Color.clear)
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspGoogleCalendarMaterialTextButton: View {
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
                .font(LpspGoogleCalendarFonts.gcalButton)
                .tracking(0.4)
                .foregroundStyle(LpspGoogleCalendarTokens.gcalBlue)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
    }
}

fileprivate struct LpspGoogleCalendarMaterialFilledButton: View {
    let title: String
    var systemImage: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let symbol = systemImage {
                    Image(systemName: symbol)
                        .font(.system(size: 14, weight: .medium))
                }
                Text(title.uppercased())
                    .font(LpspGoogleCalendarFonts.gcalButton)
                    .tracking(0.4)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            .background(RoundedRectangle(cornerRadius: 4).fill(LpspGoogleCalendarTokens.gcalBlue))
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct LpspGoogleCalendarCurrentTimeIndicator: View {
    let yOffset: CGFloat // computed from current time

    var body: some View {
        HStack(spacing: 0) {
            Circle().fill(LpspGoogleCalendarTokens.gcalEventRed).frame(width: 10, height: 10)
            Rectangle().fill(LpspGoogleCalendarTokens.gcalEventRed).frame(height: 2)
        }
        .offset(y: yOffset)
        .allowsHitTesting(false)
    }
}



// MARK: - Showroom data & store

private enum LpspGoogleCalendarShowroomTab: String, CaseIterable, Identifiable {
    case schedule, day, week, month

    var id: String { rawValue }

    var title: String {
        switch self {
        case .schedule: "Schedule"
        case .day: "Day"
        case .week: "Week"
        case .month: "Month"
        }
    }

    var systemImage: String {
        switch self {
        case .schedule: "list.bullet"
        case .day: "calendar.day.timeline.left"
        case .week: "calendar"
        case .month: "square.grid.2x2"
        }
    }
}

private enum LpspGoogleCalendarRSVPOption: String, CaseIterable, Identifiable {
    case yes = "Yes"
    case no = "No"
    case maybe = "Maybe"

    var id: String { rawValue }
}

private struct LpspGoogleCalendarEvent: Identifiable {
    let id: String
    let title: String
    let timeRange: String
    let location: String?
    let meetLabel: String?
    let color: Color
    let calendarId: String
    let startHour: Int
    let durationMinutes: Int
}

private enum LpspGoogleCalendarShowroomData {
    static let monthTitle = "May 2026"
    static let todayDay = 14
    static let dayLabel = "Thu · May"

    static let drawerCalendars: [LpspGoogleCalendarDrawerSection.LpspGoogleCalendarDrawerItem] = [
        .init(id: "primary", icon: "calendar", label: "Alex Mercer", color: LpspGoogleCalendarTokens.gcalBlueberry),
        .init(id: "work", icon: "calendar", label: "Work", color: LpspGoogleCalendarTokens.gcalGrape),
        .init(id: "personal", icon: "calendar", label: "Personal", color: LpspGoogleCalendarTokens.gcalTangerine),
        .init(id: "tasks", icon: "checkmark.circle", label: "Tasks", color: LpspGoogleCalendarTokens.gcalBanana),
    ]

    static let events: [LpspGoogleCalendarEvent] = [
        .init(
            id: "standup",
            title: "Stand-up",
            timeRange: "9:00 – 9:30 AM",
            location: nil,
            meetLabel: "Join with Google Meet",
            color: LpspGoogleCalendarTokens.gcalBlueberry,
            calendarId: "work",
            startHour: 9,
            durationMinutes: 30
        ),
        .init(
            id: "design",
            title: "Design review · Calendar v4",
            timeRange: "10:30 – 11:30 AM",
            location: "Conference Room B",
            meetLabel: nil,
            color: LpspGoogleCalendarTokens.gcalGrape,
            calendarId: "work",
            startHour: 10,
            durationMinutes: 60
        ),
        .init(
            id: "lunch",
            title: "Lunch with Kira",
            timeRange: "12:30 – 1:30 PM",
            location: "Tartine, Mission",
            meetLabel: nil,
            color: LpspGoogleCalendarTokens.gcalTangerine,
            calendarId: "personal",
            startHour: 12,
            durationMinutes: 60
        ),
        .init(
            id: "insurance",
            title: "Pay car insurance",
            timeRange: "3:00 PM · Task",
            location: nil,
            meetLabel: nil,
            color: LpspGoogleCalendarTokens.gcalBanana,
            calendarId: "tasks",
            startHour: 15,
            durationMinutes: 30
        ),
        .init(
            id: "yoga",
            title: "Yoga · 30 min",
            timeRange: "6:30 – 7:00 PM",
            location: nil,
            meetLabel: nil,
            color: LpspGoogleCalendarTokens.gcalSage,
            calendarId: "personal",
            startHour: 18,
            durationMinutes: 30
        ),
    ]

    static func monthEventColors(for day: Int) -> [Color] {
        switch day {
        case 14: [LpspGoogleCalendarTokens.gcalBlueberry, LpspGoogleCalendarTokens.gcalGrape, LpspGoogleCalendarTokens.gcalTangerine]
        case 15: [LpspGoogleCalendarTokens.gcalBanana]
        case 18: [LpspGoogleCalendarTokens.gcalSage]
        default: []
        }
    }
}

@MainActor
fileprivate final class LpspGoogleCalendarStore: ObservableObject {
    @Published var selectedTab: LpspGoogleCalendarShowroomTab = .schedule
    @Published var showDrawer = false
    @Published var selectedEventId: String?
    @Published var showCreateSheet = false
    @Published var showEventDetail = false
    @Published var selectedCalendarId = "primary"
    @Published var rsvpSelection: LpspGoogleCalendarRSVPOption = .yes
    @Published var events = LpspGoogleCalendarShowroomData.events
    @Published var selectedMonthDay = LpspGoogleCalendarShowroomData.todayDay
    @Published var newEventTitle = ""

    var selectedEvent: LpspGoogleCalendarEvent? {
        guard let selectedEventId else { return nil }
        return events.first { $0.id == selectedEventId }
    }

    var visibleEvents: [LpspGoogleCalendarEvent] {
        if selectedCalendarId == "primary" { return events }
        return events.filter { $0.calendarId == selectedCalendarId }
    }

    func selectEvent(_ id: String) {
        selectedEventId = id
        showEventDetail = true
    }

    func openCreateSheet() {
        newEventTitle = ""
        showCreateSheet = true
    }

    func addEvent() {
        let title = newEventTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }
        let event = LpspGoogleCalendarEvent(
            id: "new-\(events.count + 1)",
            title: title,
            timeRange: "4:00 – 4:30 PM",
            location: nil,
            meetLabel: nil,
            color: LpspGoogleCalendarTokens.gcalPeacock,
            calendarId: selectedCalendarId == "primary" ? "work" : selectedCalendarId,
            startHour: 16,
            durationMinutes: 30
        )
        events.append(event)
        events = events.sorted { $0.startHour < $1.startHour }
        showCreateSheet = false
        selectedEventId = event.id
        showEventDetail = true
    }

    func selectMonthDay(_ day: Int) {
        selectedMonthDay = day
        selectedTab = .schedule
    }

    func jumpToToday() {
        selectedMonthDay = LpspGoogleCalendarShowroomData.todayDay
        selectedTab = .schedule
    }
}

// MARK: - Écrans showroom

private struct LpspGoogleCalendarShowroomRoot: View {
    @ObservedObject var store: LpspGoogleCalendarStore

    var body: some View {
        ZStack(alignment: .leading) {
            TabView(selection: $store.selectedTab) {
                ForEach(LpspGoogleCalendarShowroomTab.allCases) { tab in
                    LpspGoogleCalendarShowroomTabScreen(store: store, tab: tab)
                        .tabItem {
                            Label(tab.title, systemImage: tab.systemImage)
                        }
                        .tag(tab)
                }
            }
            .tint(LpspGoogleCalendarTokens.gcalBlue)
            .preferredColorScheme(.light)
            .sheet(isPresented: $store.showCreateSheet) {
                LpspGoogleCalendarCreateEventSheet(store: store)
            }
            .sheet(isPresented: $store.showEventDetail) {
                if let event = store.selectedEvent {
                    LpspGoogleCalendarEventDetailSheet(store: store, event: event)
                }
            }

            if store.showDrawer {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                    .onTapGesture { store.showDrawer = false }

                LpspGoogleCalendarDrawerPanel(store: store)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeOut(duration: 0.22), value: store.showDrawer)
    }
}

private struct LpspGoogleCalendarShowroomTabScreen: View {
    @ObservedObject var store: LpspGoogleCalendarStore
    let tab: LpspGoogleCalendarShowroomTab

    var body: some View {
        Group {
            switch tab {
            case .schedule:
                LpspGoogleCalendarScheduleTabScreen(store: store)
            case .day:
                LpspGoogleCalendarDayTabScreen(store: store)
            case .week:
                LpspGoogleCalendarWeekTabScreen(store: store)
            case .month:
                LpspGoogleCalendarMonthTabScreen(store: store)
            }
        }
    }
}

private struct LpspGoogleCalendarScheduleTabScreen: View {
    @ObservedObject var store: LpspGoogleCalendarStore

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                LpspGoogleCalendarAppBar(
                    title: LpspGoogleCalendarShowroomData.monthTitle,
                    onMenu: { store.showDrawer = true },
                    onToday: { store.jumpToToday() }
                )

                ScrollView {
                    VStack(spacing: 12) {
                        LpspGoogleCalendarSpectrDayBanner()

                        ForEach(store.visibleEvents) { event in
                            LpspGoogleCalendarEventCard(
                                title: event.title,
                                timeRange: event.timeRange,
                                location: event.location,
                                meetLabel: event.meetLabel,
                                calendarColor: event.color,
                                isSelected: store.selectedEventId == event.id,
                                onTap: { store.selectEvent(event.id) }
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 88)
                }
            }
            .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())

            LpspGoogleCalendarGcalFAB {
                store.openCreateSheet()
            }
            .padding(20)
        }
    }
}

private struct LpspGoogleCalendarAppBar: View {
    let title: String
    let onMenu: () -> Void
    let onToday: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: onMenu) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
            }

            Text(title)
                .font(LpspGoogleCalendarFonts.gcalNavTitle.weight(.medium))
                .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)

            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)

            Button(action: onToday) {
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 22))
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalBlue, LpspGoogleCalendarTokens.gcalCanvas)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(LpspGoogleCalendarTokens.gcalCanvas)
    }
}

private struct LpspGoogleCalendarSpectrDayBanner: View {
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(LpspGoogleCalendarTokens.gcalBlue)
                    .frame(width: 56, height: 56)
                Text("\(LpspGoogleCalendarShowroomData.todayDay)")
                    .font(LpspGoogleCalendarFonts.gcalDayNumberLg.weight(.medium))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(LpspGoogleCalendarShowroomData.dayLabel)
                    .font(LpspGoogleCalendarFonts.gcalDayLabel)
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                Text("Today")
                    .font(LpspGoogleCalendarFonts.gcalCaption)
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
            }

            Spacer()

            HStack(spacing: 8) {
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalEventYellow)
                Text("72°")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 80)
    }
}

private struct LpspGoogleCalendarDrawerPanel: View {
    @ObservedObject var store: LpspGoogleCalendarStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Google Calendar")
                .font(LpspGoogleCalendarFonts.gcalNavTitle.weight(.medium))
                .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                .padding(16)

            LpspGoogleCalendarMaterialFilledButton(title: "Create", systemImage: "plus") {
                store.showDrawer = false
                store.openCreateSheet()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

            LpspGoogleCalendarDrawerSection(
                title: "My calendars",
                items: LpspGoogleCalendarShowroomData.drawerCalendars,
                selected: $store.selectedCalendarId
            )

            Spacer()
        }
        .frame(width: 300)
        .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
        .shadow(color: .black.opacity(0.12), radius: 16, x: 4)
    }
}

private struct LpspGoogleCalendarDayTabScreen: View {
    @ObservedObject var store: LpspGoogleCalendarStore

    private let hours = Array(8...20)

    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack(spacing: 0) {
                        ForEach(hours, id: \.self) { hour in
                            HStack(alignment: .top, spacing: 8) {
                                Text(hourLabel(hour))
                                    .font(LpspGoogleCalendarFonts.gcalTimeGutter)
                                    .foregroundStyle(LpspGoogleCalendarTokens.gcalTertiary)
                                    .frame(width: 44, alignment: .trailing)

                                Rectangle()
                                    .fill(LpspGoogleCalendarTokens.gcalDivider)
                                    .frame(height: 0.5)
                            }
                            .frame(height: 64, alignment: .top)
                        }
                    }

                    ForEach(store.visibleEvents) { event in
                        let yOffset = CGFloat(event.startHour - 8) * 64 + 8
                        let height = max(36, CGFloat(event.durationMinutes) * 64 / 60)

                        LpspGoogleCalendarTintedEventBlock(
                            title: event.title,
                            timeRange: event.timeRange,
                            calendarColor: event.color,
                            heightPt: height
                        )
                        .padding(.leading, 52)
                        .padding(.trailing, 16)
                        .offset(y: yOffset)
                        .onTapGesture { store.selectEvent(event.id) }
                    }

                    LpspGoogleCalendarCurrentTimeIndicator(yOffset: CGFloat(10 - 8) * 64 + 30)
                        .padding(.leading, 44)
                }
                .padding(.vertical, 16)
            }
            .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
            .navigationTitle("Day")
        }
    }

    private func hourLabel(_ hour: Int) -> String {
        let suffix = hour >= 12 ? "PM" : "AM"
        let value = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
        return "\(value) \(suffix)"
    }
}

private struct LpspGoogleCalendarWeekTabScreen: View {
    @ObservedObject var store: LpspGoogleCalendarStore

    private let weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(Array(weekdays.enumerated()), id: \.offset) { index, day in
                            let dayNumber = 12 + index
                            VStack(spacing: 6) {
                                Text(day)
                                    .font(LpspGoogleCalendarFonts.gcalWeekdayHdr)
                                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                                ZStack {
                                    if dayNumber == LpspGoogleCalendarShowroomData.todayDay {
                                        Circle()
                                            .fill(LpspGoogleCalendarTokens.gcalBlue)
                                            .frame(width: 28, height: 28)
                                        Text("\(dayNumber)")
                                            .font(LpspGoogleCalendarFonts.gcalTodayNumber)
                                            .foregroundStyle(.white)
                                    } else {
                                        Text("\(dayNumber)")
                                            .font(LpspGoogleCalendarFonts.gcalDayNumber)
                                            .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.vertical, 12)

                    Divider()

                    ForEach(store.visibleEvents.prefix(4)) { event in
                        LpspGoogleCalendarEventCard(
                            title: event.title,
                            timeRange: event.timeRange,
                            location: event.location,
                            meetLabel: event.meetLabel,
                            calendarColor: event.color,
                            onTap: { store.selectEvent(event.id) }
                        )
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                    }
                }
            }
            .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
            .navigationTitle("Week")
        }
    }
}

private struct LpspGoogleCalendarMonthTabScreen: View {
    @ObservedObject var store: LpspGoogleCalendarStore

    private let weekdays = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    HStack {
                        ForEach(weekdays, id: \.self) { day in
                            Text(day)
                                .font(LpspGoogleCalendarFonts.gcalWeekdayHdr)
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                                .frame(maxWidth: .infinity)
                        }
                    }

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7), spacing: 0) {
                        ForEach(1...35, id: \.self) { index in
                            let day = index - 4
                            if day >= 1 && day <= 31 {
                                Button {
                                    store.selectMonthDay(day)
                                } label: {
                                    LpspGoogleCalendarMonthCell(
                                        day: day,
                                        isToday: day == LpspGoogleCalendarShowroomData.todayDay,
                                        isCurrentMonth: true,
                                        events: LpspGoogleCalendarShowroomData.monthEventColors(for: day)
                                    )
                                    .overlay {
                                        if store.selectedMonthDay == day {
                                            RoundedRectangle(cornerRadius: 4)
                                                .strokeBorder(LpspGoogleCalendarTokens.gcalBlue, lineWidth: 2)
                                        }
                                    }
                                }
                                .buttonStyle(.plain)
                            } else {
                                Color.clear.frame(minHeight: 52)
                            }
                        }
                    }
                }
                .padding(8)
            }
            .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
            .navigationTitle(LpspGoogleCalendarShowroomData.monthTitle)
        }
    }
}

private struct LpspGoogleCalendarCreateEventSheet: View {
    @ObservedObject var store: LpspGoogleCalendarStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Add title", text: $store.newEventTitle)
                    .font(LpspGoogleCalendarFonts.gcalEventDetail)
                    .padding(.top, 8)

                Text("May 14 · 4:00 – 4:30 PM")
                    .font(LpspGoogleCalendarFonts.gcalEventTime)
                    .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)

                LpspGoogleCalendarMaterialFilledButton(title: "Save") {
                    store.addEvent()
                    dismiss()
                }

                Spacer()
            }
            .padding(20)
            .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
            .navigationTitle("New event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        store.showCreateSheet = false
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

private struct LpspGoogleCalendarEventDetailSheet: View {
    @ObservedObject var store: LpspGoogleCalendarStore
    let event: LpspGoogleCalendarEvent
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(event.color)
                            .frame(width: 18, height: 18)
                        Text(event.title)
                            .font(LpspGoogleCalendarFonts.gcalEventDetail.weight(.medium))
                            .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                    }

                    Text(event.timeRange)
                        .font(LpspGoogleCalendarFonts.gcalEventTime)
                        .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)

                    if let meetLabel = event.meetLabel {
                        HStack(spacing: 8) {
                            Image(systemName: "video.fill")
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalBlue)
                            Text(meetLabel)
                                .font(LpspGoogleCalendarFonts.gcalEventTime)
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalBlue)
                        }
                        LpspGoogleCalendarMaterialFilledButton(title: "Join Meet", systemImage: "video.fill") {}
                    }

                    if let location = event.location {
                        HStack(spacing: 8) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                            Text(location)
                                .font(LpspGoogleCalendarFonts.gcalEventTime)
                                .foregroundStyle(LpspGoogleCalendarTokens.gcalSecondary)
                        }
                    }

                    if event.meetLabel != nil {
                        Text("Going?")
                            .font(LpspGoogleCalendarFonts.gcalSectionHdr)
                            .foregroundStyle(LpspGoogleCalendarTokens.gcalInk)
                        LpspGoogleCalendarRSVPPillsControlled(selection: $store.rsvpSelection)
                    }
                }
                .padding(20)
            }
            .background(LpspGoogleCalendarTokens.gcalCanvas.ignoresSafeArea())
            .navigationTitle("Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        store.showEventDetail = false
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

private struct LpspGoogleCalendarRSVPPillsControlled: View {
    @Binding var selection: LpspGoogleCalendarRSVPOption

    var body: some View {
        HStack(spacing: 8) {
            ForEach(LpspGoogleCalendarRSVPOption.allCases) { option in
                let isSelected = selection == option
                Button {
                    withAnimation(.easeOut(duration: 0.2)) { selection = option }
                } label: {
                    Text(option.rawValue)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(isSelected ? .white : LpspGoogleCalendarTokens.gcalSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 500)
                                .fill(isSelected ? LpspGoogleCalendarTokens.gcalBlue : Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 500)
                                .strokeBorder(isSelected ? Color.clear : LpspGoogleCalendarTokens.gcalDivider, lineWidth: 1)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
}

