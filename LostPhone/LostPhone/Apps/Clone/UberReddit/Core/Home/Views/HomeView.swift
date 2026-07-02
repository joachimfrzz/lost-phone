
import Foundation
import SwiftUI

struct UberRedditHomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation  {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top , 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActivationButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top , 4)
            }
            
            if mapState == .locationSelected || mapState == .polylineAdded {
                RideRequestView() //this view will show the confirmation view to select the ride and price, etc.
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(UberCloneLocationManager.shared.$userLocation) { location in
            if let location {
                viewModel.userLocation = location
            }
        }
        .onAppear {
            if viewModel.userLocation == nil {
                viewModel.userLocation = UberCloneLocationManager.shared.userLocation
            }
        }
    }
}


#Preview {
    UberRedditHomeView()
}
