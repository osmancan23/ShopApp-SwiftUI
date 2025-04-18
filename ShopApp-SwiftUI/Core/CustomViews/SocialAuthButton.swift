//
//  SocialAuthButton.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 14.04.2025.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

enum SocialAuthType {
    case google
    case apple

    var title: String {
        switch self {
        case .google:
            return "Google"
        case .apple:
            return "Apple"
        }
    }
}

struct SocialAuthButton: View {
    let type: SocialAuthType

    func signWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: Application_Utility.rootViewController) { user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard
                let user = user?.user,
                let idToken = user.idToken else { return }

            let accessToken = user.accessToken

            let credential = OAuthProvider.credential(providerID: .google, idToken: idToken.tokenString, accessToken: accessToken.tokenString)

            Auth.auth().signIn(with: credential) { res, error in

                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                guard let user = res?.user else { return }

                print("USER : \(user)")
            }
        }
    }

    var body: some View {
        Button {
            if (type == SocialAuthType.google) {
                signWithGoogle()
            }
        } label: {
            HStack {
                Spacer()
                Image(type.title.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)

                Text("Sign in with \(type.title)")
                    .foregroundStyle(type == SocialAuthType.google ? .black : .white)
                Spacer()
            }
                .padding(8)

        }
            .buttonStyle(.borderedProminent)
            .tint(type == SocialAuthType.google ? Color.white : .black)
            .buttonBorderShape(.roundedRectangle(radius: 24))
            .padding()
    }
}


#Preview {
    SocialAuthButton(type: .apple)
}
