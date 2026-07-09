//
//  VendoredWhatsAppCallView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 8/4/24.
//

import SwiftUI

struct VendoredWhatsAppCallView: View {
    @State private var selectionCall: String = "All"
   
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (spacing: 16){
                    VendoredWhatsAppCallHeaderView()
                    switch selectionCall {
                    case "All":
                        VendoredWhatsAppCallRecentAllView()
                    case "Missed":
                        VendoredWhatsAppCallRecentMissedView()
                    default:
                        EmptyView()
                    }
                    // setting encryption
                    VendoredWhatsAppSettingEncryption()
                     
                }
                .padding(.bottom, 20)
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    }label: {
                        Text("Edit")
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    }
                }
                // center
                ToolbarItem (placement: .principal){
                    Picker("", selection: $selectionCall) {
                        Text("All").tag("All")
                        Text("Missed").tag("Missed")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 40)

                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    }label: {
                       Image(systemName: "phone")
                    }
                }
            }
            .background(Color.vendoredWhatsAppBackgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            
          
            
        }
      
        
    }
}

#Preview {
    VendoredWhatsAppCallView()
}

struct VendoredWhatsAppCallHeaderView: View {
    var body: some View {
        VStack (spacing: 6){
            Text("Calls")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack (spacing: 12){
                Image(systemName: "link")
                    .resizable()
                    .scaledToFill()
                    .fontWeight(.semibold)
                    .frame(width: 15,height: 15)
                    .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    .padding(.all, 12)
                    .background(Color.vendoredWhatsAppBackgroundColor)
                    .clipShape(Circle())
               
                VStack (alignment: .leading,spacing: -2){
                    Text("Create Call Link")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
                    Text("Share a link for your Whatsapp call")
                        .font(.footnote)
                        .foregroundStyle(Color.vendoredWhatsAppBlackOpacity)
                }
                Spacer()
                
            }
            .padding(.all, 12)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
    }
}

struct VendoredWhatsAppCallRecentAllView: View {
    var callAllData:[VendoredWhatsAppCallResponse] = callData
    var body: some View {
        
        VStack (alignment: .leading, spacing: 6){
            Text("Recent")
                .font(.headline)
                .fontWeight(.semibold)
            LazyVStack (spacing: 0){
                ForEach(callAllData) { item in
                    VendoredWhatsAppCallProfileView(callResponse: item)
                }
               
            }
            .padding(.top,10)
            .padding(.bottom,-10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .padding(.horizontal)
       
    }
}

struct VendoredWhatsAppCallRecentMissedView: View {
    var callAllData:[VendoredWhatsAppCallResponse] = callData
    var body: some View {
        
        VStack (alignment: .leading, spacing: 6){
            Text("Recent")
                .font(.headline)
                .fontWeight(.semibold)
            LazyVStack (spacing: 0){
                ForEach(callAllData) { item in
                    if(item.type == 1) {
                        VendoredWhatsAppCallProfileView(callResponse: item)
                    }
                    
                }
               
            }
            .padding(.top,10)
            .padding(.bottom,-10)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .padding(.horizontal)
    }
}

struct VendoredWhatsAppSettingEncryption: View {
    var body: some View {
        HStack (spacing: 8){
            Image(systemName: "lock.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 10,height: 10)
                .foregroundStyle(.gray)
            Text("Your personal calls are")
                .font(.footnote)
                .foregroundStyle(.gray) +
            Text(" end-to-end encrypted")
                .font(.footnote)
                .foregroundStyle(Color.vendoredWhatsAppVendoredWhatsAppPrimary)
            
        }
    }
}
