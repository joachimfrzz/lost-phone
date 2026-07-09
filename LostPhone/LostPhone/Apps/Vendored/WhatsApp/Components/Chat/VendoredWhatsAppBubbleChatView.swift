//
//  VendoredWhatsAppBubbleChatView.swift
//  WhatsAppclone
//
//  Created by Sopheamen VAN on 9/4/24.
//

import SwiftUI

struct VendoredWhatsAppBubbleChatView: View {
    var text: String
    var isMe: Bool
    var timeAgo: String
    var isReaction: Bool?
    var body: some View {
        if(isMe) {
            HStack {
                Spacer()
                ZStack (alignment: .bottomTrailing){
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical,7)
                    .padding(.horizontal,12)
                    .background(Color.vendoredWhatsAppMeChatBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0.1)
                    )
                    .shadow(color: Color.black.opacity(0.08), radius: 0, x: 0, y: 1)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    
                    // reaction
                    if isReaction != nil {
                        Text("😆")
                            .font(.footnote)
                            .padding(.all,4)
                            
                            .background(Color.white)
                            .clipShape(Circle())
                           
                            .overlay(Circle().stroke(.gray.opacity(0.1)))
                            .offset(x: -15, y:20)
                    }
 
                }
                
            }
        }else {
            HStack {
                ZStack (alignment: .bottomLeading){
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(.subheadline)
                            .foregroundColor(.black)
                          
                    }
                    .padding(.vertical,7)
                    .padding(.horizontal,12)
                    .background(Color.vendoredWhatsAppTextFieldBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0.1)
                    )
                    .shadow(color: Color.black.opacity(0.08), radius: 0, x: 0, y: 1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                   
                    // reaction
                    if isReaction != nil {
                        Text("😆")
                            .font(.footnote)
                            .padding(.all,4)
                            
                            .background(Color.white)
                            .clipShape(Circle())
                           
                            .overlay(Circle().stroke(.gray.opacity(0.1)))
                            .offset(x: 15, y:20)
                    }
                }
                Spacer()
                
              
            }
        }
        
    }
}
#Preview {
    VendoredWhatsAppBubbleChatView(text: vendoredWhatsAppChatData[0].text ?? "Hello, World!", isMe: true, timeAgo: vendoredWhatsAppChatData[0].timeAgo)
}

