import SwiftUI
import Combine

// MARK: - Models
struct CalendarEvent: Identifiable {
    let id: UUID
    let title: String
    let location: String?
    let notes: String?
    let start: Date
    let end: Date
    let color: Color

    init(stableId: String, title: String, location: String?, note: String? = nil, start: Date, end: Date, color: Color) {
        self.id = LpspStableId.uuid(stableId)
        self.title = title
        self.location = location
        self.notes = note
        self.start = start
        self.end = end
        self.color = color
    }

    init(title: String, location: String?, notes: String? = nil, start: Date, end: Date, color: Color) {
        self.id = UUID()
        self.title = title
        self.location = location
        self.notes = notes
        self.start = start
        self.end = end
        self.color = color
    }
}

// MARK: - Main View
struct CalendarView: View {
    let events: [CalendarEvent]
    @State private var selectedDate = Date()
    @State private var displayedMonth = Date()
    @State private var selectedEvent: CalendarEvent?

    init(events: [CalendarEvent] = []) {
        self.events = events
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 1. Month/Year Header
                CalendarHeaderView(date: displayedMonth, onPrevious: previousMonth, onNext: nextMonth)
                
                // 2. Days of Week
                WeekDaysHeader()
                
                // 3. Month Grid
                MonthGridView(selectedDate: $selectedDate, displayedMonth: displayedMonth)
                    .padding(.bottom, 10)
                    .gesture(
                        DragGesture(minimumDistance: 30).onEnded { value in
                            if value.translation.width < -30 { nextMonth() }
                            else if value.translation.width > 30 { previousMonth() }
                        }
                    )
                
                Divider()
                
                // 4. Timeline Schedule View
                ScrollViewReader { proxy in
                    ScrollView {
                        ZStack(alignment: .top) {
                            TimelineGridView()
                            EventsLayoutView(
                                selectedDate: selectedDate,
                                events: events,
                                onSelect: { selectedEvent = $0 }
                            )
                            if Calendar.current.isDateInToday(selectedDate) {
                                CurrentTimeLineView()
                            }
                        }
                        .frame(height: 1440)
                    }
                    .onAppear {
                        proxy.scrollTo(8, anchor: .top)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Today") { goToToday() }
                            .foregroundStyle(.red)
                        Button("Calendars") { goToToday() }
                            .foregroundStyle(.red)
                    }
                    .font(.system(size: 16))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedEvent) { event in
                EventDetailSheet(event: event)
            }
        }
    }
    
    private func previousMonth() {
        if let newMonth = Calendar.current.date(byAdding: .month, value: -1, to: displayedMonth) {
            displayedMonth = newMonth
        }
    }
    
    private func nextMonth() {
        if let newMonth = Calendar.current.date(byAdding: .month, value: 1, to: displayedMonth) {
            displayedMonth = newMonth
        }
    }
    
    private func goToToday() {
        let today = Date()
        selectedDate = today
        displayedMonth = today
    }
}

// MARK: - Subcomponents

struct CalendarHeaderView: View {
    let date: Date
    var onPrevious: () -> Void = {}
    var onNext: () -> Void = {}
    
    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.red)
            }
            
            Text(date.formatted(.dateTime.month(.wide)))
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(Color.primary)
            + Text("\(date.formatted(.dateTime.year()))")
                .font(.system(size: 34, weight: .regular))
                .foregroundStyle(Color.secondary)
            
            Spacer()
            
            Button(action: onNext) {
                Image(systemName: "chevron.right")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.red)
            }
            
            HStack(spacing: 18) {
                Image(systemName: "magnifyingglass")
                Image(systemName: "plus")
            }
            .font(.title2)
            .foregroundStyle(.red)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct WeekDaysHeader: View {
    let days = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 8)
    }
}

struct MonthGridView: View {
    @Binding var selectedDate: Date
    let displayedMonth: Date
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        let days = generateDaysInMonth(for: displayedMonth)
        
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(days, id: \.self) { date in
                if let date = date {
                    DayCell(date: date, selectedDate: $selectedDate)
                } else {
                    Text("")
                        .frame(height: 35)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func generateDaysInMonth(for date: Date) -> [Date?] {
        guard let range = calendar.range(of: .day, in: .month, for: date),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: date)) else { return [] }
        
        let weekday = calendar.component(.weekday, from: firstDay)
        let offset = weekday - 1
        
        var days: [Date?] = Array(repeating: nil, count: offset)
        for day in 1...range.count {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        return days
    }
}

struct DayCell: View {
    let date: Date
    @Binding var selectedDate: Date
    private let calendar = Calendar.current
    
    var body: some View {
        let isToday = calendar.isDateInToday(date)
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        
        Button {
            selectedDate = date
        } label: {
            VStack(spacing: 2) {
                ZStack {
                    if isToday {
                        Circle()
                            .fill(.red)
                            .frame(width: 36, height: 36)
                    } else if isSelected {
                        Circle()
                            .fill(.primary)
                            .frame(width: 36, height: 36)
                    }
                    
                    Text("\(calendar.component(.day, from: date))")
                        .font(.system(size: 19, weight: (isToday || isSelected) ? .semibold : .regular))
                        .foregroundStyle(isToday ? .white : (isSelected ? Color(uiColor: .systemBackground) : .primary))
                }
                
                // Mock Event Dot
                if [2, 5, 14, 19, 23].contains(calendar.component(.day, from: date)) {
                    Circle()
                        .fill(isToday ? .red : (isSelected ? .primary : .gray))
                        .frame(width: 4, height: 4)
                } else {
                    Circle().fill(.clear).frame(width: 4, height: 4)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Timeline Components

struct TimelineGridView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<24) { hour in
                HStack(alignment: .top) {
                    // Time Label
                    Text(formatHour(hour))
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.gray)
                        .frame(width: 50, alignment: .trailing)
                        .offset(y: -6) // Align text with the line
                    
                    // Horizontal Line
                    VStack {
                        Divider()
                        Spacer()
                    }
                }
                .frame(height: 60) // 1 hour = 60 points
                .id(hour) // For scroll anchor
            }
        }
        .padding(.trailing)
    }
    
    func formatHour(_ hour: Int) -> String {
        let date = Calendar.current.date(from: DateComponents(hour: hour))!
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }
}

struct EventsLayoutView: View {
    let selectedDate: Date
    let events: [CalendarEvent]
    var onSelect: (CalendarEvent) -> Void = { _ in }

    var body: some View {
        let dayEvents = displayedEvents(for: selectedDate)

        ZStack(alignment: .topLeading) {
            ForEach(dayEvents) { event in
                Button {
                    onSelect(event)
                } label: {
                    EventCard(event: event)
                }
                .buttonStyle(.plain)
                .padding(.leading, 60)
                .padding(.trailing, 10)
                .offset(y: calculateOffset(for: event.start))
                .frame(height: calculateHeight(start: event.start, end: event.end))
            }
        }
    }
    
    func calculateOffset(for date: Date) -> CGFloat {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return CGFloat(hour * 60 + minute)
    }
    
    func calculateHeight(start: Date, end: Date) -> CGFloat {
        let duration = end.timeIntervalSince(start) // in seconds
        return CGFloat(duration / 60) // 1 minute = 1 point height
    }
    
    func displayedEvents(for date: Date) -> [CalendarEvent] {
        let calendar = Calendar.current
        let storyEvents = events.filter { calendar.isDate($0.start, inSameDayAs: date) }
        if !storyEvents.isEmpty {
            return storyEvents
        }
        return getMockEvents(for: date)
    }

    func getMockEvents(for date: Date) -> [CalendarEvent] {
        // Mock data generation relative to selected date
        let calendar = Calendar.current
        
        // Create start times for today
        func createDate(hour: Int, minute: Int) -> Date {
            calendar.date(bySettingHour: hour, minute: minute, second: 0, of: date)!
        }
        
        return [
            CalendarEvent(title: "Team Standup", location: "Zoom", notes: "Daily sync with design team.", start: createDate(hour: 9, minute: 30), end: createDate(hour: 10, minute: 0), color: .orange),
            CalendarEvent(title: "Design Review", location: "Conference Room A", notes: "Review mockups for Q3 launch.", start: createDate(hour: 11, minute: 0), end: createDate(hour: 12, minute: 30), color: .blue),
            CalendarEvent(title: "Lunch", location: "Cafeteria", notes: nil, start: createDate(hour: 13, minute: 0), end: createDate(hour: 14, minute: 0), color: .gray),
            CalendarEvent(title: "Project Sync", location: nil, notes: "Align on deliverables before deadline.", start: createDate(hour: 15, minute: 15), end: createDate(hour: 16, minute: 15), color: .purple)
        ]
    }
}

struct EventCard: View {
    let event: CalendarEvent
    
    var body: some View {
        HStack(spacing: 0) {
            // Color Indicator Line
            Rectangle()
                .fill(event.color)
                .frame(width: 4)
            
            // Content
            VStack(alignment: .leading, spacing: 2) {
                Text(event.title)
                    .font(.system(size: 12, weight: .semibold))
                    .lineLimit(1)
                
                if let location = event.location {
                    Text(location)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            
            Spacer()
        }
        .background(event.color.opacity(0.15))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(event.color.opacity(0.5), lineWidth: 0.5)
        )
    }
}

struct CurrentTimeLineView: View {
    @State private var currentTimeOffset: CGFloat = 0
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 0) {
            // Time Text
            Text(Date().formatted(date: .omitted, time: .shortened))
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.red)
                .frame(width: 50, alignment: .trailing)
                .offset(x: -5, y: -1) // Fine tune
            
            // Dot
            Circle()
                .fill(.red)
                .frame(width: 7, height: 7)
            
            // Line
            Rectangle()
                .fill(.red)
                .frame(height: 1)
        }
        .offset(y: currentTimeOffset)
        .onAppear { updateTime() }
        .onReceive(timer) { _ in updateTime() }
    }
    
    func updateTime() {
        let calendar = Calendar.current
        let date = Date()
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        // 1 hour = 60 points, 1 minute = 1 point
        currentTimeOffset = CGFloat(hour * 60 + minute)
    }
}

struct EventDetailSheet: View {
    let event: CalendarEvent
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabeledContent("Début", value: event.start.formatted(date: .abbreviated, time: .shortened))
                    LabeledContent("Fin", value: event.end.formatted(date: .abbreviated, time: .shortened))
                    if let location = event.location {
                        LabeledContent("Lieu", value: location)
                    }
                }
                if let notes = event.notes, !notes.isEmpty {
                    Section("Notes") {
                        Text(notes)
                    }
                }
            }
            .navigationTitle(event.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") { dismiss() }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    CalendarView()
}
