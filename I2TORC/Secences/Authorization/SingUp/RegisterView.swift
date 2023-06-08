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
    
    @State private var worngEmailValid = 0
    @State private var worngPasswordValid = 0
    @State private var worngUserName = 0
    
    @State private var isPresentingNextView = false
    
    @State private var isTabBarPresented = false
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Circle()
                .scale(2)
                .foregroundColor(.white.opacity(0.30))
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            ColorfulView()
            VStack {
                Text("Sing In")
                    .bold()
                    .font(.largeTitle)
                    .padding()
                TextField("UserName", text: $userName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, height: 50)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(worngUserName))
                    .padding()
                TextField("Email", text: $email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, height: 50)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10).border(.red, width: CGFloat(worngEmailValid))
                    .padding()
                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300, height: 50)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .border(.red, width: CGFloat(worngPasswordValid))
                    .padding()
                
                Button(action: {
//                    registerUser()
                    isTabBarPresented.toggle()
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .font(.system(size: 20, weight: .bold))
                }
                .fullScreenCover(isPresented: $isTabBarPresented) {
                                TabBarView()
                            }
//                .sheet(isPresented: $isTabBarPresented) {
//                    TabBarView()
//                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
   private func registerUser() {
        // Implement your user registration logic here
        print("Registering user with email: \(email), password: \(password), userName: \(userName)")
    
//       AuthService1.registerUser(userName: userName, email: email, password: password) {
//
//       }
//        AuthService.registerUser(userName: userName, email: email, password: "password") { result in
//            switch result {
//            case .success:
//                // Registration successful
//                print("User registered successfully.")
//                // Perform any additional actions or navigate to the next screen
//            case .failure(let error):
//                // Registration failed
//                print("Registration failed with error: \(error.localizedDescription)")
//                // Display an error message or handle the error as needed
//            }
//        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
