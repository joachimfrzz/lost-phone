//
//  RouteManager.swift
//  iUber
//
//  Created by Khondakar Afridi on 7/1/24.
//

import Foundation
import SwiftUI


class VendoredUberRouteManger : ObservableObject {
    @Published var path = NavigationPath()
    
    func popToRoot(){
        path = NavigationPath()
    }
    
    func to(route : VendoredUberRoute){
        path.append(route)
    }
    
    func pop(){
        path.removeLast()
    }
    
    func popNViews(N: Int){
        path.removeLast(N)
    }
}


struct VendoredUberGetView: View {
    var route: VendoredUberRoute
    var body: some View {
        switch route {
        case .homeView:
            VendoredUberHomeView()
        case .locationSearchView:
            VendoredUberLocationSearchView()
        default:
            ContentUnavailableView("404", systemImage: "globe", description: Text("Invalid route! :(").font(.footnote))
        }
    }
}
