import SwiftUI

// Netflix clone uses sharedBackgroundVisibility (iOS 26+). Deployment target is 17.0.
extension ToolbarContent {
    @ToolbarContentBuilder
    func netflixHideSharedBackground() -> some ToolbarContent {
        if #available(iOS 26.0, *) {
            sharedBackgroundVisibility(.hidden)
        } else {
            self
        }
    }
}
