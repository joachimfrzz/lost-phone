import Foundation

struct VendoredGrokModeCategory: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

enum VendoredGrokData {
    static let categories: [VendoredGrokModeCategory] = [
        .init(title: "Assistant", icon: "🙂"),
        .init(title: "Storyteller", icon: "📖"),
        .init(title: "Kids Story Time", icon: "👨‍👧"),
        .init(title: "Kids Trivia Game", icon: "🏆"),
        .init(title: "Motivated", icon: "💪"),
        .init(title: "Sexy", icon: "💔"),
        .init(title: "Motivation", icon: "🏃"),
        .init(title: "Romantic", icon: "❤️"),
    ]

    /// Réponse demo du clone Flutter Sopheamen (`content_data.dart`).
    static let sampleResponse = """
Here's a 7-day healthy meal plan designed to be balanced, nutritious, and varied. It includes breakfast, lunch, dinner, and a snack each day, focusing on whole foods, lean proteins, healthy fats, and plenty of vegetables.

Day 1
• Breakfast: Greek yogurt with mixed berries, chia seeds, and honey
• Lunch: Grilled chicken salad with avocado and balsamic vinegar
• Dinner: Baked salmon with quinoa and roasted asparagus
• Snack: Apple with peanut butter

General Tips:
- Stay hydrated: aim for 8–10 cups of water daily
- Adjust portions based on your activity level and goals
- Season with herbs and spices to reduce sodium intake

Would you like me to generate a printable PDF version or add calories/macros for each meal?
"""
}
