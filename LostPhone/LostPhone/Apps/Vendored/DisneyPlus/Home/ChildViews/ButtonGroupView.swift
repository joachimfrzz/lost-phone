//
//  VendoredDisneyButtonGroupView.swift
//  DisneyPlus
//
//  Created by Goutham S on 05/07/22.
//

import SwiftUI

struct VendoredDisneyButtonGroupView: View {
    @State private var _groupName: String? = nil
    
    init() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().alpha = 0.20
    }

    var body: some View {
        NavigationLink(tag: _groupName ?? VendoredDisneyMovieGroup.disney.rawValue,
                       selection: $_groupName,
                       destination: { VendoredDisneyMovieGroupView(
                        movieGroup: VendoredDisneyMovieGroup(
                            rawValue: _groupName ?? VendoredDisneyMovieGroup.disney.rawValue) ?? .disney)}) {
            EmptyView()
        }
        HStack {
            Button(action: {
                _groupName = VendoredDisneyMovieGroup.disney.rawValue
            }) {
                image(name: "logo-disney")
            }
            
            Button(action: {
                _groupName = VendoredDisneyMovieGroup.marvel.rawValue
            }) {
                image(name: "logo-marvel")
            }
            
            Button(action: {
                _groupName = VendoredDisneyMovieGroup.pixar.rawValue
            }) {
                image(name: "logo-pixar")
            }
            
            Button(action: {
                _groupName = VendoredDisneyMovieGroup.starWars.rawValue
            }) {
                image(name: "logo-starWars")
            }
            
            Button(action: {
                _groupName = VendoredDisneyMovieGroup.natgeo.rawValue
            }) {
                image(name: "logo-natgeo")
            }
        }
        .buttonStyle(VendoredDisneySquareButtonStyle(size: UIScreen.main.bounds.width/6)) // Divided by 6 because, we have 5 buttons and need equal spacing between them
    }
    
    private func image(name: String) -> some View {
        return Image(name)
            .resizable()
            .aspectRatio(2.8, contentMode: .fit)
            .frame(height: 20)
    }
}

struct ButtonGroupView_Previews: PreviewProvider {
    static var previews: some View {
        VendoredDisneyButtonGroupView()
    }
}
