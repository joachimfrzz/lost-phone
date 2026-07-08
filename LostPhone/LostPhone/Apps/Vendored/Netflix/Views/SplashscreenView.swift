//
//  SplashScreen.swift
//  Notflix
//
//  Created by Quentin Eude on 14/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct VendoredNetflixSplashscreenView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Image("notflix")
        }
    }
}

