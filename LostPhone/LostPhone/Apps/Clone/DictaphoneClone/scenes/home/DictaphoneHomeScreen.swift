//
//  DictaphoneHomeScreen.swift — vendored mushthak/voice-memos-clone-swiftui
//

import SwiftUI

struct DictaphoneHomeScreen: View {
    var recordings: [RecordingCellVM] = []

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List(recordings) {
                    RecordingCellView(recording: $0)
                }
                .listStyle(.plain)

                DictaphoneHomeScreen.BottomRecordingView()
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationTitle("All Recordings")
        }
    }
}

extension DictaphoneHomeScreen {
    struct BottomRecordingView: View {
        @State private var showingSheet = false

        var body: some View {
            ZStack(alignment: .top) {
                DictaphoneAppTheme.bottomSheetBackground
                    .frame(width: UIScreen.main.bounds.width, height: 130)

                RecordButtonView(clickHandler: {
                    showingSheet.toggle()
                })
                .padding(.top)
                .dictaphoneBottomSheet(isPresented: $showingSheet) {
                    RecordingExpandedView(onClose: {
                        showingSheet.toggle()
                    })
                    .interactiveDismissDisabled(true)
                } onClose: {
                    showingSheet.toggle()
                }
            }
        }
    }
}

struct DictaphoneHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        DictaphoneHomeScreen(recordings: PreviewHelpers.mockRecordingsVMs)
    }
}
