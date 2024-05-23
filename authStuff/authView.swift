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
    @State private var showModal = false
    var body: some View {
        NavigationStack {
            Form {
                Section("Login") {
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
                Button("Sign up") {
                    showModal.toggle()
                }
            }.sheet(isPresented: $showModal, content: {
                CreateUser()
            })
        }
    }
}

#Preview {
    authView()
}

struct CreateUser: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password2: String = ""
    @State private var alertShown = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            Form {
                Section("Mail") {
                    TextField("Whats ur mail", text: $email).textCase(.lowercase).textContentType(.emailAddress).autocorrectionDisabled()
                }
                Section("Password") {
                    SecureField("Password", text: $password).textContentType(.newPassword)

                    SecureField("Type your password again", text: $password2).textContentType(.newPassword)
                }
                Button("Create account") {
                    Task {
                        do {
                            try await signUp(mail: email, password: password)

                            alertShown.toggle()
                        }
                    }
                }.disabled(!(password == password2) || password.count <= 6 || !email.contains("@")).alert("Now verify your mail and log in", isPresented: $alertShown) {
                    Button("OK", role: .cancel) {
                        dismiss()
                    }
                }

                Section {
                    if email.isEmpty && password.isEmpty && password2.isEmpty {
                    } else if !email.contains("@") {
                        Text("Provided email isn't correct - you're missing a `@`")
                    } else if password.isEmpty || password2.isEmpty {
                    } else if password.count <= 6 {
                        Text("Password is too short - it should be at least 6 characters")
                    } else if !(password == password2) {
                        Text("Passwords don't match")
                    }
                }.foregroundStyle(Color.gray)
                // no this is not yandere dev coding it look gorgeous

            }.toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview("New account") {
    CreateUser()
}
