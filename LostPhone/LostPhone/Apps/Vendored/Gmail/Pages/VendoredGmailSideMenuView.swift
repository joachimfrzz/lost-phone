//
//  VendoredGmailSideMenuView.swift
//  Youtube_Gmail
//
//  Created by Sopheamen VAN on 9/10/24.
//

import SwiftUI

struct VendoredGmailSideMenuView: View {
    var body: some View {
        ScrollView {
            VStack {
                // logo
                VendoredGmailLogoView()
                // list item
                VendoredGmailListItemView()
            }
            .padding(.vertical)
        }
        .frame(width: 300)
        .background(Color.vendoredGmailVendoredGmailSideMenuBackground)
    }
}

#Preview {
    VendoredGmailSideMenuView()
}

struct VendoredGmailLogoView:View {
    var body: some View {
        VStack (spacing: 4){
            HStack (spacing:14){
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 32)
                Text("Gmail")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    
                Spacer()
            }
            .padding(.horizontal ,20)
            
            // divider
            Divider()
                .background(.white.opacity(0.8))
                .padding(.vertical, 10)
        }
    }
}

struct VendoredGmailListItemView:View {
    // load data sidemenu records
    var sidemenuDatas:[VendoredGmailSidemenuResponse] = sidemenuData
    var body: some View {
        LazyVStack (spacing: 26){
            ForEach(sidemenuDatas) { sidemenu in
                VendoredGmailListItemRowView(sidemenu: sidemenu)
            }
        }
    }
}

struct VendoredGmailListItemRowView:View {
    var sidemenu: VendoredGmailSidemenuResponse
    var body: some View {
        if sidemenu.title == "Primary" {
            HStack (spacing: 14){
                Image(systemName: sidemenu.icon)
                    .font(.system(size: 18))
                    .foregroundStyle(Color.vendoredGmailVendoredGmailPrimary)
                Text(sidemenu.title)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(Color.vendoredGmailVendoredGmailPrimary)
                Spacer()
                
                // badge number
                if sidemenu.badge != nil {
                    Text(sidemenu.badge ?? "")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundStyle(Color.vendoredGmailVendoredGmailPrimary)
                        .background(sidemenu.badgeColor ?? .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
            .padding(.vertical)
            .background(Color.vendoredGmailVendoredGmailPrimaryBackground)
            .clipShape(VendoredGmailRightRoundedRectangle(cornerRadius: 30))
            .padding(.trailing, 20)
            
        } else {
            HStack (spacing: 14){
                Image(systemName: sidemenu.icon)
                    .font(.system(size: 18))
                    .foregroundStyle(.white.opacity(0.8))
                Text(sidemenu.title)
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundStyle(sidemenu.titleColor ?? .white)
                Spacer()
                
                // badge number
                if sidemenu.badge != nil {
                    Text(sidemenu.badge ?? "")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundStyle(sidemenu.badgeColor == nil ? .white : .black)
                        .background(sidemenu.badgeColor ?? .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
