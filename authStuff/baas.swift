//
//  baas.swift
//  authStuff
//
//  Created by Patryk Puciłowski on 20/05/2024.
//

import Combine
import Foundation
import Supabase

let auth = supabase.auth

@MainActor
func signIn(mail: String, password: String) async throws {
    do {
        let session = try await auth.signIn(email: mail, password: password)
        print("Logging in as \(mail) with password \(password)")
    } catch let error {
        print(error.localizedDescription)
    }
}

@MainActor
func signOut() async throws {
    do {
        try await auth.signOut(scope: .local)
        print("Bye bye")
    } catch let error {
        print(error.localizedDescription)
    }
}

@MainActor
func signUp(mail: String, password: String) async throws {
    do {
        try await auth.signUp(email: mail, password: password)
        print("Signing up as \(mail) with \(password) - now verify ur account")
    } catch let error {
        print(error.localizedDescription)
    }
}
