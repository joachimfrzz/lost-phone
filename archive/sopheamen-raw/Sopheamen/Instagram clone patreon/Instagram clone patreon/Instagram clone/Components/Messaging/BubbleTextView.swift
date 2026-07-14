//
//  BubbleTextView.swift
//  Instagram clone
//
//  Created by Sopheamen VAN on 21/3/24.
//

import SwiftUI

struct BubbleTextView: View {
    var text: String
    var isMe: Bool = false
    var body: some View {
        if(isMe) {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text(text)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical,12)
                        .padding(.horizontal,18)
                        .background(Color.primaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity,alignment: .trailing)
                }
                
            }
        }else {
            HStack {
               
                VStack(alignment: .leading) {
                    Text(text)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical,12)
                        .padding(.horizontal,18)
                        .background(Color.textFieldBackgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white, lineWidth: 1)
                        )
                        .frame(maxWidth: 320,alignment: .leading)
                }
                Spacer()
              
            }
        }
        
    }
}
#Preview {
    BubbleTextView(text: "Hello, World!!", isMe: true)
}
