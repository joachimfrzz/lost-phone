import Foundation

// Stub localisation Notflix (SwiftGen) — showroom vendored.
enum L10n {
    enum Tab {
        static let home = "Home"
        static let search = "Search"
    }

    enum Home {
        enum Tab {
            static let tvshows = "TV shows"
            static let movies = "Movies"
        }
    }

    enum Tvshows {
        enum Popular {
            static let title = "Popular TV shows"
        }
        enum Toprated {
            static let title = "Top rated TV shows"
        }
        enum With {
            enum Genre {
                static func title(_ genre: String) -> String { "\(genre) TV shows" }
            }
        }
    }

    enum Tvshow {
        enum Details {
            static let recommendations = "Recommendations"
        }
    }

    enum Movies {
        enum Popular {
            static let title = "Popular movies"
        }
        enum Toprated {
            static let title = "Top rated movies"
        }
        enum With {
            enum Genre {
                static func title(_ genre: String) -> String { "\(genre) movies" }
            }
        }
    }

    enum Movie {
        enum Details {
            static let recommendations = "Recommendations"
            enum Cast {
                static let list = "Cast"
            }
        }
    }
}
