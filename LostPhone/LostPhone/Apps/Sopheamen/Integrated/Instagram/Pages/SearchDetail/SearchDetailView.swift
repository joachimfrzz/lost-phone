//
//  SearchDetailView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 17/3/24.
//

import SwiftUI

struct SearchDetailView: View {
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
                        TextFieldSearchView()
                        
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
            SearchForYouView()
        case "Accounts":
            SearchAccountsView()
                .padding(.horizontal)
        case "Audio":
            SearchAudioView()
                .padding(.horizontal)
        case "Tags":
           SearchTagsView()
                .padding(.horizontal)
        case "Places":
            SearchPlacesView()
                .padding(.horizontal)
        default:
            Text("Empty View")
        }
    }
    
}

#Preview {
    SearchDetailView()
}


 

