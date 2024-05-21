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
    } catch let error {
        throw error
    }
}

@MainActor
func signOut() async throws {
    do {
        try await auth.signOut()
    } catch let error {
        throw error
    }
}
