//
//  ContentView.swift
//  authStuff
//
//  Created by Patryk Puciłowski on 20/05/2024.
//

import Supabase
import SwiftUI

struct ContentView: View {
    @State var user = supabase.auth.currentUser
    var body: some View {
        NavigationStack {
            if let user {
                loggedInView(User: user)
            } else {
                authView()
            }
        }.onAppear(perform: {
            Task {
                do {
                    /// Here we're listening to the changes that occur on event of user authenticating which fills out the sesh
                    for await (event, session) in await supabase.auth.authStateChanges {
                        switch event {
                        case .signedIn:
                            self.user = try await supabase.auth.user()
                        case .signedOut:
                            self.user = nil
                        default:
                            break
                        }
                    }
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
