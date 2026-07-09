//
//  StartCommunityView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 10/4/24.
//

import SwiftUI

struct StartCommunityView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showingNewCommunitySheet = false
    var body: some View {
        NavigationStack {
            
                VStack (spacing: 14){
                    Image(systemName: "person.2.badge.key.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color.primaryColor)
                    Text("Start a Community")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    HStack (spacing: 20){
                        Image(systemName: "circle.square.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.primaryColor)
                        
                        Text("Add and manage related groups from one place")
                            .font(.subheadline)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack (spacing: 20){
                        Image(systemName: "waveform")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.primaryColor)
                        
                        Text("Reach up to 2,000 members with announcements")
                            .font(.subheadline)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack (spacing: 20){
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.primaryColor)
                        
                        Text("Organize your neightborhood, school, team and more")
                            .font(.subheadline)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    // button
                    Button {
                        showingNewCommunitySheet = true
                    }label: {
                        Text("Get Started")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(Color.primaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    
                }
            .padding(.horizontal,20)
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28,height: 28)
                            .foregroundStyle(.black.opacity(0.3))
                    }
                }
            }
            .sheet(isPresented: $showingNewCommunitySheet){
                NewCommunityView()
            }
            
        }
        
    }
}

#Preview {
    StartCommunityView()
}
