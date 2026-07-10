import SwiftUI

// MARK: - Main View
struct WeatherView: View {
    @Environment(\.lpspStoryDate) private var storyDate
    private var hours: [HourlyMock] { HourlyMock.generate(referenceDate: storyDate) }

    var body: some View {
        ZStack {
            // 1. Dynamic Background
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "2E335A"), Color(hex: "1C1B33")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 2. Main Scroll View
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header Section
                    HeaderView(currentTemp: hours.first?.temp ?? 0)
                        .padding(.top, 40)
                        .padding(.bottom, 40)
                    
                    // Hourly Section
                    HourlyForecastView(hours: hours)
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    
                    // Daily Section (10-Day)
                    DailyForecastView()
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    
                    // Details Grid (UV, Sunset, etc)
                    DetailsGridView()
                        .padding(.horizontal)
                        .padding(.bottom, 50)
                    
                    // Bottom Toolbar Mock
                    HStack {
                        Image(systemName: "map")
                        Spacer()
                        Image(systemName: "list.bullet")
                    }
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
            }
        }
        .preferredColorScheme(.dark) // Forces white text/dark mode look
    }
}

// MARK: - Components

struct HeaderView: View {
    let currentTemp: Int

    var body: some View {
        VStack(spacing: 6) {
            Text("Cupertino")
                .font(.system(size: 34, weight: .regular))
                .foregroundStyle(.white)
                .shadow(radius: 2)
            
            Text("\(currentTemp)°")
                .font(.system(size: 96, weight: .thin))
                .foregroundStyle(.white)
                .shadow(radius: 2)
            
            Text(Fr.mostlyClear)
                .font(.title3.weight(.medium))
                .foregroundStyle(.white.opacity(0.6))
        }
    }
}

struct HourlyForecastView: View {
    let hours: [HourlyMock]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(Fr.hourlyForecast, systemImage: "clock")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
                .padding(.top, 12)
                .padding(.leading, 15)
            
            Divider()
                .background(.white.opacity(0.2))
                .padding(.leading, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    ForEach(hours) { hour in
                        VStack(spacing: 12) {
                            Text(hour.time)
                                .font(.system(size: 15, weight: .medium))
                            
                            Image(systemName: hour.icon)
                                .symbolRenderingMode(.multicolor)
                                .font(.title2)
                                .frame(height: 20)
                            
                            Text("\(hour.temp)°")
                                .font(.system(size: 18, weight: .medium))
                        }
                        .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 12)
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

struct DailyForecastView: View {
    let days: [DailyMock] = DailyMock.generate()

    private var tempRange: ClosedRange<Int> {
        let lows = days.map(\.low)
        let highs = days.map(\.high)
        guard let minT = lows.min(), let maxT = highs.max(), minT < maxT else {
            return 0...35
        }
        return minT...maxT
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Label(Fr.tenDayForecast, systemImage: "calendar")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
                .padding(15)
            
            Divider().background(.white.opacity(0.2)).padding(.horizontal, 15)
            
            ForEach(days) { day in
                HStack {
                    // Day Name
                    Text(day.dayName)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 50, alignment: .leading)
                    
                    Spacer()
                    
                    // Icon
                    Image(systemName: day.icon)
                        .symbolRenderingMode(.multicolor)
                        .font(.title3)
                        .frame(width: 30)
                    
                    Spacer()
                    
                    // Low Temp
                    Text("\(day.low)°")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white.opacity(0.5))
                        .frame(width: 40)
                    
                    // Temperature Bar
                    TemperatureBar(low: day.low, high: day.high, range: tempRange)
                        .frame(width: 100, height: 4)
                    
                    // High Temp
                    Text("\(day.high)°")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 40, alignment: .trailing)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 15)
                
                if day.id != days.last?.id {
                    Divider().background(.white.opacity(0.2)).padding(.leading, 15)
                }
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

struct TemperatureBar: View {
    let low: Int
    let high: Int
    let range: ClosedRange<Int>
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Background Track
                Capsule()
                    .fill(Color.black.opacity(0.2))
                
                // Colored Bar
                Capsule()
                    .fill(LinearGradient(colors: [.green, .orange], startPoint: .leading, endPoint: .trailing))
                    .frame(width: width(in: geo.size.width), height: 4)
                    .offset(x: offset(in: geo.size.width))
            }
        }
    }
    
    // Calculate relative width of the bar based on daily range vs weekly range
    func width(in totalWidth: CGFloat) -> CGFloat {
        let rangeSpan = CGFloat(range.upperBound - range.lowerBound)
        let daySpan = CGFloat(high - low)
        return (daySpan / rangeSpan) * totalWidth
    }
    
    // Calculate starting offset
    func offset(in totalWidth: CGFloat) -> CGFloat {
        let rangeSpan = CGFloat(range.upperBound - range.lowerBound)
        let startDiff = CGFloat(low - range.lowerBound)
        return (startDiff / rangeSpan) * totalWidth
    }
}

struct DetailsGridView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            DetailTile(icon: "sun.max.fill", title: "INDEX UV", value: "4", description: "Modéré")
            DetailTile(icon: "sunset.fill", title: "COUCHER", value: "20 h 14", description: "Lever : 6 h 15")
            DetailTile(icon: "wind", title: "VENT", value: "13 km/h", description: "Rafales 19 km/h")
            DetailTile(icon: "drop.fill", title: "PRÉCIP.", value: "0 mm", description: "Aucune prévue")
        }
    }
}

struct DetailTile: View {
    let icon: String
    let title: String
    let value: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                Text(title)
            }
            .font(.system(size: 13, weight: .medium))
            .foregroundStyle(.white.opacity(0.5))
            
            Text(value)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(.white)
                .padding(.top, 4)
            
            Spacer()
            
            Text(description)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding()
        .frame(height: 160, alignment: .leading)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}

// MARK: - Mock Data Models

struct HourlyMock: Identifiable {
    let id = UUID()
    let time: String
    let icon: String
    let temp: Int
    
    static func generate(referenceDate: Date = Date()) -> [HourlyMock] {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: referenceDate)
        let nextHourLabel = String(format: "%d h", (hour + 1) % 24)
        return [
            HourlyMock(time: "Maintenant", icon: "sun.max.fill", temp: 24),
            HourlyMock(time: nextHourLabel, icon: "sun.max.fill", temp: 25),
            HourlyMock(time: "13 h", icon: "cloud.sun.fill", temp: 26),
            HourlyMock(time: "14 h", icon: "cloud.sun.fill", temp: 27),
            HourlyMock(time: "15 h", icon: "sun.max.fill", temp: 28),
            HourlyMock(time: "16 h", icon: "sun.max.fill", temp: 27),
            HourlyMock(time: "17 h", icon: "cloud.sun.fill", temp: 26),
            HourlyMock(time: "18 h", icon: "sun.haze.fill", temp: 24),
            HourlyMock(time: "19 h", icon: "moon.stars.fill", temp: 22)
        ]
    }
}

struct DailyMock: Identifiable {
    let id = UUID()
    let dayName: String
    let icon: String
    let low: Int
    let high: Int
    
    static func generate() -> [DailyMock] {
        return [
            DailyMock(dayName: Fr.today, icon: "sun.max.fill", low: 18, high: 28),
            DailyMock(dayName: "Mer.", icon: "cloud.sun.fill", low: 17, high: 26),
            DailyMock(dayName: "Jeu.", icon: "sun.max.fill", low: 16, high: 29),
            DailyMock(dayName: "Ven.", icon: "cloud.rain.fill", low: 15, high: 24),
            DailyMock(dayName: "Sam.", icon: "cloud.fill", low: 14, high: 23),
            DailyMock(dayName: "Dim.", icon: "sun.max.fill", low: 16, high: 27),
            DailyMock(dayName: "Lun.", icon: "cloud.sun.fill", low: 17, high: 26)
        ]
    }
}

// Extension for hex colors (Optional, but helpful for matching backgrounds)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Preview
#Preview {
    WeatherView()
}
