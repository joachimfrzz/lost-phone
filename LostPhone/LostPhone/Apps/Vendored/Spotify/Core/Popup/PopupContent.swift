//
//  VendoredSpotifyAlertContent.swift
//  SpotifySwiftUI
//
//  Created by ladans on 30/08/25.
//
import SwiftUI

struct VendoredSpotifyAlertContent: View {
    @Binding var show: Bool
    var title: AttributedString
    let onTryAgain: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "lock.trianglebadge.exclamationmark.fill")
                .font(.title)
                .foregroundStyle(.spotifyDarkGrey)
                .frame(width: 65, height: 65)
                .background {
                    Circle()
                        .fill(.red.gradient)
                        .background {
                            Circle()
                                .fill(.spotifyDarkGrey)
                                .padding(-5)
                        }
                }
            
            Text("Private Content")
                .fontWeight(.semibold)
                .foregroundStyle(.spotifyWhite)
            
            Text("The \(title) content you are trying to access is only available to Spotify Premium users.",
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(.spotifyLightGrey)
            .padding(.top, 5)
            
            HStack(spacing: 10) {
                Button {
                    show = false
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.spotifyBlack)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.red.gradient)
                        }
                }
                
                Button {
                    show = false
                    onTryAgain()
                } label: {
                    Text("Try Again")
                        .foregroundStyle(.spotifyBlack)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.spotifyGreen.gradient)
                        }
                }
            }
        }
        .frame(width: 250)
        .padding([.horizontal, .bottom], 25)
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(.spotifyDarkGrey)
                .padding(.top, 25)
        }
    }
}
