//
//  AuthCoordinatorView.swift
//  netflix-clone-github
//
//  Created by Pardip Bhatti on 02/01/26.
//

import SwiftUI
import SwiftUINavigation

struct AuthCoordinatorView: View {
    @Environment(\.toast) var toast
    @State var authVM: AuthVM
    
    var body: some View {
        CoordinatorView(
            environmentKeyPath: \.authCoordinator) {
                SignIn(authVM: authVM)
                    .navigationBarBackButtonHidden()
                    .toolbar {
//                        ToolbarItem(placement: .topBarLeading) {
//                            BackButton()
//                        }
//                        .netflixHideSharedBackground()
//                        
                        ToolbarItem(placement: .principal) {
                            NetflixLogoView()
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            InformationLinks(textColor: .white, isPrivacy: false)
                        }
                        .netflixHideSharedBackground()
                    }
            } destinationBuilder: { destination in
                switch destination {
                case .signin:
                    SignIn(authVM: authVM)
                        .navigationBarBackButtonHidden()
                        .toolbar {
//                            ToolbarItem(placement: .topBarLeading) {
//                                BackButton()
//                            }
//                            .netflixHideSharedBackground()
                            
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .netflixHideSharedBackground()
                        }
                case .signup:
                    Signup(authVM: authVM)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .netflixHideSharedBackground()
                        }
                    
                case .verifyEmail(let email):
                    VerifyEmail(email: email, authVM: authVM)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                NetflixLogoView()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                InformationLinks(textColor: .white, isPrivacy: false)
                            }
                            .netflixHideSharedBackground()
                        }
                }
            }
    }
}

//#Preview {
//    AuthCoordinatorView(, authVM: <#AuthVM#>)
//}

struct BackButton: View {
    @Environment(\.authCoordinator) var coordinator
    var body: some View {
        Button {
            coordinator.navigateBack()
        } label: {
            Image(systemName: "chevron.backward")
                .foregroundStyle(.white)
        }
    }
}
