//
//  VendoredTeamsnavView.swift
//  MS Teams clone
//
//  Created by Manav Deep Singh Lamba on 31/12/21.
//

import SwiftUI

struct VendoredTeamsnavView: View {
    let img: String
    let text: String
    let stat: Int
    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 20, height: 20)
                if(stat==0) {
                    Image(img)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                else {
                    Image(systemName: img)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                    
            }
            if(stat==0) {
            Text(text)
                .foregroundColor(Color.gray)
                .font(.system(size: 10))
            }
            else {
                Text(text)
                    .foregroundColor(Color.white)
                    .font(.system(size: 10))
            }
        }
    }
}

