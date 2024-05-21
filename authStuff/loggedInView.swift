//
//  loggedInView.swift
//  authStuff
//
//  Created by Patryk Puciłowski on 20/05/2024.
//

import Supabase
import SwiftUI

struct loggedInView: View {
    @State var User: User
    var body: some View {
        Text("Welcome - you're logged in")

        Text("You are \(User.email ?? "NO WAY U LOGGED IN")")
        Button("Log out") {
            Task {
                do {
                    try await signOut()
                }
            }
            print("Bye bye")
        }
    }
}

