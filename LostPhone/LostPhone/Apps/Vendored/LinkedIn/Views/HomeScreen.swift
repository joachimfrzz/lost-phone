//
//  VendoredLinkedInHomeScreen.swift
//  linkedin_clone
//
//  Created by Dipak on 26/02/23.
//

import SwiftUI

struct VendoredLinkedInHomeScreen: View {
    var body: some View {
        VStack(){
//            VendoredLinkedInProfileAndPostView()
            VendoredLinkedInPostView()
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        VendoredLinkedInHomeScreen()
    }
}
