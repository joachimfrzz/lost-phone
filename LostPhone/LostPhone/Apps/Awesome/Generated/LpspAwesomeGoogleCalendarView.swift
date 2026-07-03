import SwiftUI

// Fidélité Spectr — Meliwat/awesome-ios-design-md/productivity/google-calendar/DESIGN-swiftui.md
// Gallery : https://www.spectr.to/gallery/google-calendar
// Généré par generate_awesome_apps_v3.py — composants extraits de la spec
struct LpspAwesomeGoogleCalendarView: View {
    var body: some View {
        LpspGoogleCalendarShowroomRoot()
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

private struct LpspGoogleCalendarEventCard: View {
    let title: String
    let timeRange: String       // "9:00 – 9:30 AM"
    let location: String?
    let calendarColor: Color    // e.g., LpspGoogleCalendarTokens.gcalBlueberry
    var onTap: () -> Void = {}

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 0) {
                // 4pt left color bar
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

                    if let location = location {
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
                    .fill(LpspGoogleCalendarTokens.gcalCanvas)
            )
            .shadow(color: Color(red: 0.235, green: 0.251, blue: 0.263).opacity(0.10), radius: 1, y: 1)
            .shadow(color: Color(red: 0.235, green: 0.251, blue: 0.263).opacity(0.15), radius: 3, y: 1)
        }
        .buttonStyle(.plain)
    }
}

private struct LpspGoogleCalendarDayBanner: View {
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

private struct LpspGoogleCalendarGcalFAB: View {
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
        .pressEvents(onPress: { pressed = true }, onRelease: { pressed = false })
    }
}

extension View {
    func pressEvents(onPress: @escaping () -> Void, onRelease: @escaping () -> Void) -> some View {
        simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in onPress() }
                .onEnded   { _ in onRelease() }
        )
    }
}

private struct LpspGoogleCalendarMonthCell: View {
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

private struct LpspGoogleCalendarTintedEventBlock: View {
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

private struct LpspGoogleCalendarDrawerSection: View {
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

private struct LpspGoogleCalendarDrawerRow: View {
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

private struct LpspGoogleCalendarMaterialTextButton: View {
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

private struct LpspGoogleCalendarMaterialFilledButton: View {
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

private struct LpspGoogleCalendarRSVPPills: View {
    @State private var selection: LpspGoogleCalendarRSVPOption = .yes
    enum LpspGoogleCalendarRSVPOption: String, CaseIterable { case yes = "Yes", no = "No", maybe = "Maybe" }

    var body: some View {
        HStack(spacing: 8) {
            ForEach(LpspGoogleCalendarRSVPOption.allCases, id: \.self) { option in
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

private struct LpspGoogleCalendarCurrentTimeIndicator: View {
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

private struct LpspGoogleCalendarRootTabView: View {
    var body: some View {
        TabView {
            ScheduleView() .tabItem { Label("Schedule", systemImage: "list.bullet") }
            DayView()      .tabItem { Label("Day",      systemImage: "calendar.day.timeline.left") }
            WeekView()     .tabItem { Label("Week",     systemImage: "calendar") }
            MonthView()    .tabItem { Label("Month",    systemImage: "calendar") }
        }
        .tint(LpspGoogleCalendarTokens.gcalBlue)
    }
}

// MARK: - Écrans showroom

private struct LpspGoogleCalendarShowroomRoot: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            LpspGoogleCalendarGenericTabScreen(title: "Schedule", tabIndex: 0)
                .tabItem { Label("Schedule", systemImage: "list.bullet") }
                .tag(0)
        }
        .tint(LpspGoogleCalendarTokens.gcalEventGreen)
        
    }
}


private struct LpspGoogleCalendarGenericTabScreen: View {
    let title: String
    let tabIndex: Int
    var body: some View {
        NavigationStack {
            List(0..<6, id: \.self) { i in
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LpspGoogleCalendarTokens.gcalEventGreen.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(Image(systemName: "app.fill").foregroundStyle(LpspGoogleCalendarTokens.gcalEventGreen))
                    VStack(alignment: .leading) {
                        Text("\(title) \(i + 1)").font(.system(size: 17, weight: .semibold))
                        Text("Contenu démo").font(.system(size: 14)).foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}


private struct LpspGoogleCalendarMessagingTabScreen: View {
    let title: String
    var body: some View { LpspGoogleCalendarGenericTabScreen(title: title, tabIndex: 0) }
}


