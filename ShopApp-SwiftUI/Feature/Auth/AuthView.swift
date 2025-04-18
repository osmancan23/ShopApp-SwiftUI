//
//  AuthView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 14.04.2025.
//

import SwiftUI
import AuthenticationServices
import Firebase
import FirebaseAuth
import CryptoKit


struct AuthView: View {
    var errorMessage: String?
    @State var hasError: Bool = false



    var body: some View {
        VStack {
            Spacer()

            Image("logo")
                .resizable()
                .scaledToFit()


            Text("Welcome".uppercased())
                .font(.largeTitle)
                .fontWeight(.bold)

            Spacer()

            SocialAuthButton(type: .google)


            AppleSignInButton(hasError: $hasError)


            Spacer()
        }
            .background(.accent)
            .edgesIgnoringSafeArea(.horizontal)
            .alert(errorMessage ?? "Error", isPresented: $hasError) {

        }
    }



}
#Preview {
    AuthView()
}

struct AppleSignInButton: View {

    // nonce for Firebase Apple Sign In
    @State private var currentNonce: String?
    @Binding var hasError: Bool

    private func handleSuccessfulLogin(with authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \\(appleIDToken.debugDescription)")
                return
            }



            let credential = OAuthProvider.credential(providerID: .apple, idToken: idTokenString, rawNonce: nonce)

            // Sign in with Firebase
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)

                    hasError = true
                    return
                }

                if let user = authResult?.user {
                    if appleIDCredential.fullName != nil || appleIDCredential.email != nil {
                        let changeRequest = user.createProfileChangeRequest()
                        if let fullName = appleIDCredential.fullName {
                            changeRequest.displayName = PersonNameComponentsFormatter().string(from: fullName)
                        }
                        if let email = appleIDCredential.email {

                            print("User email from Apple: \\(email)")
                        }
                        changeRequest.commitChanges { error in
                            if let error = error {
                                print("Error updating profile: \\(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
    }

    // Function to generate nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \\(errorCode)"
            )
        }

        let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }

        return String(nonce)
    }

    // Function to hash the nonce
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    var body: some View {
        SignInWithAppleButton(.signIn) { request in

            let nonce = randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.email, .fullName]
            request.nonce = sha256(nonce)


        } onCompletion: { result in
            switch result {
            case .success(let authorization):
                handleSuccessfulLogin(with: authorization)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
            .frame(height: 45)
            .clipShape(.capsule)
            .padding(.horizontal, 20)
    }
}
