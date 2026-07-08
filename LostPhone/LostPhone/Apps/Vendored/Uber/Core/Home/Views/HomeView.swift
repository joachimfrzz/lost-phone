//
//  VendoredUberHomeView.swift
//  iUber
//
//  Created by Khondakar Afridi on 7/1/24.
//

import SwiftUI

struct VendoredUberHomeView: View {
    @EnvironmentObject private var routeManager: VendoredUberRouteManger
    
    var body: some View {
        ZStack{
            VendoredUberUberMapViewRepresentable()
                .ignoresSafeArea()
            VStack{
                HStack(alignment: .center){
                    VendoredUberMapViewActionButton()
                    VendoredUberLocationSearchActivationView()
                        .onTapGesture {
                            print("Button pressed")
                            routeManager.to(route: .locationSearchView)
                        }
                }
                .padding(.leading, 12)
                .padding(.trailing, 24)
                .padding(.top, 10)
                Spacer()
            }
        }
    }
}

#Preview {
    VendoredUberHomeView()
        .environmentObject(VendoredUberRouteManger())
}
