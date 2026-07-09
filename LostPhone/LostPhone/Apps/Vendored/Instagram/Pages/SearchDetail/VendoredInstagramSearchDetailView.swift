//
//  VendoredInstagramSearchDetailView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct VendoredInstagramSearchDetailView: View {
    @Environment(\.dismiss)  var dismiss
    @State private var selectedTab = "For you"
    
    let tabs = [
    "For you","Accounts","Audio","Tags","Places"
    ]
    @Namespace private var underlineNamespace
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // search and back button
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 10,height: 10)
                                .padding(.trailing,8)
                                .foregroundStyle(.black)
                        }
                        VendoredInstagramTextFieldSearchView()
                        
                    }
                    .padding(.horizontal)
                    
                   // custom tab view
                    HStack {
                        ForEach(tabs, id: \.self) { tab in
                            Button(action: {
                                withAnimation {
                                    selectedTab = tab
                                }
                            }) {
                                Text(tab)
                                    .font(.subheadline)
                                    .foregroundColor(selectedTab == tab ? .black : .gray)
                                    .padding(.bottom, 10)
                                    .overlay(
                                        selectedTab == tab ?
                                            Rectangle()
                                                .frame(height: 2)
                                                .foregroundColor(.black)
                                                .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                                            : nil
                                        , alignment: .bottom
                                    )
                                    
                            }
                            .frame(width:70)
                        }
                       
                    }
                    .frame(height: 44, alignment: .leading)
                    
                    
                    // content
                    getContentTab(value: selectedTab)
                    
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    @ViewBuilder
    func getContentTab(value: String) -> some View {
        switch value {
        case "For you":
            VendoredInstagramSearchForYouView()
        case "Accounts":
            VendoredInstagramSearchAccountsView()
                .padding(.horizontal)
        case "Audio":
            VendoredInstagramSearchAudioView()
                .padding(.horizontal)
        case "Tags":
           VendoredInstagramSearchTagsView()
                .padding(.horizontal)
        case "Places":
            VendoredInstagramSearchPlacesView()
                .padding(.horizontal)
        default:
            Text("Empty View")
        }
    }
    
}

#Preview {
    VendoredInstagramSearchDetailView()
}


 

