//
//  InitialView.swift
//  ShopApp-SwiftUI
//
//  Created by Osmancan Akagündüz on 15.04.2025.
//

import SwiftUI
import FirebaseAuth

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)

    var body: some View {
        VStack {

            if userLoggedIn {
                ContentView()
            } else {
                AuthView()
            }
            
        } //: VStack
        .onAppear{
            Auth.auth().addStateDidChangeListener { auth, user in
                if (user != nil){
                    userLoggedIn = true
                }
                else{
                    userLoggedIn = false
                }
            }
        }
    }
}


