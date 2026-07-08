//
//  VendoredTeamsContentView.swift
//  MS Teams clone
//
//  Created by Manav Deep Singh Lamba on 30/12/21.
//

import SwiftUI

struct VendoredTeamsContentView: View {
    var body: some View {
        
        VStack {
            VendoredTeamschatView()
        }
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredTeamsContentView()
            .preferredColorScheme(.dark)
    }
}
