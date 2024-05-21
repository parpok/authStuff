//
//  authView.swift
//  authStuff
//
//  Created by Patryk Puciłowski on 20/05/2024.
//
import SwiftUI

struct authView: View {
    @State private var loginName: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            Form {
                TextField("Login", text: $loginName)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                SecureField("Password", text: $password)
                    .textContentType(.password)

                Button("Log in") {
                    print("logging in as \(loginName) with \(password)")
                    Task {
                        do {
                            try await signIn(mail: loginName, password: password)
                        } catch let error {
                            print("Error logging in: \(error)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    authView()
}
