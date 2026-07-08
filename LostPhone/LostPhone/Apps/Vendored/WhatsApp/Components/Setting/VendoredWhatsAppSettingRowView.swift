//
//  VendoredWhatsAppSettingRowView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct VendoredWhatsAppSettingRowView: View {
    var icon: String
    var iconSize: CGFloat? = 11
    var title: String
    var backgroundColor: Color
    var body: some View {
        HStack (spacing: 12){
            ZStack {
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: 35,height:35)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Image(systemName: icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundStyle(.white)
                   
                   
            }
            Text(title)
                .font(.headline)
                .fontWeight(.regular)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFill()
                .frame(width: 8, height: 8)
                .fontWeight(.semibold)
                .foregroundStyle(.gray.opacity(0.5))
        }
       
    }
}

#Preview {
    VendoredWhatsAppSettingRowView(icon: "star.fill", iconSize:18, title: "Starred Messages", backgroundColor: Color.vendoredWhatsAppStarredMessageColor)
}
