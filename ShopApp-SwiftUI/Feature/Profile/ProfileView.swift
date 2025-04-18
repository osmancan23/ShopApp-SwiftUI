//
//  ProfileView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 15.04.2025.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile View")
            
            Button {
                Task{
                    do{
                        GIDSignIn.sharedInstance.signOut()

                        try Auth.auth().signOut()
                    }catch {
                        print("error")
                    }
                }
            } label: {
                Text("Sign Out")
            }
            .buttonStyle(.bordered)

        }
    }
}

#Preview {
    ProfileView()
}
