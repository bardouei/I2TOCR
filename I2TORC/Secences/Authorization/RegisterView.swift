//
//  RegisterView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import SwiftUI

struct RegisterView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isEmailValid: Bool = true
    @State private var isPasswordValid: Bool = true
    @State private var isUserName: Bool = true
    
    @State private var isPresentingNextView = false
    var body: some View {
        VStack {
            TextField("UserName", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // Perform user registration logic here
                registerUser()
            }) {
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
   private func registerUser() {
        // Implement your user registration logic here
        print("Registering user with email: \(email), password: \(password), userName: \(userName)")
        
        AuthService.registerUser(userName: userName, email: email, password: password) { result in
            switch result {
            case .success:
                // Registration successful
                print("User registered successfully.")
                // Perform any additional actions or navigate to the next screen
            case .failure(let error):
                // Registration failed
                print("Registration failed with error: \(error.localizedDescription)")
                // Display an error message or handle the error as needed
            }
        }
    }
    
    private func validateInputs() {
        isEmailValid = isValidEmail(email)
        isPasswordValid = isValidPassword(password)
        isUserName = isValidName(userName)
        
        if isEmailValid && isPasswordValid && isUserName {
            // Proceed with user registration logic
            registerUser()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Simple email validation using regular expression
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidName(_ name: String) -> Bool {
        // Simple email validation using regular expression
        return name.count >= 3
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        // Simple password validation - at least 6 characters
        return password.count >= 6
    }
}
