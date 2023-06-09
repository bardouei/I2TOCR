//
//  LoginViewModel.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI
import CryptoKit
import AuthenticationServices
import Firebase
import GoogleSignIn

class LoginViewModel: ObservableObject {
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    
    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false
    
    // MARK: Error Prooerties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: App Log Status
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: Apple Sign in Properties
    @Published var nonce: String = ""
    
    // MARK: FireBase API's
    func getOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                // MARK: Disable it when testing with real Device
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                
                let code = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(mobileNo)", uiDelegate: nil)
                await MainActor.run(body: {
                    CLIENT_CODE = code
                    // MARK: Enabling OTP Firld When It's Success
                    withAnimation(.easeInOut){showOTPField = true}
                })
            } catch {
               await handelError(error: error)
            }
        }
    }
    
    func verifyOTPCode() {
        UIApplication.shared.closeKeyboard()
        Task {
            do {
                let cardential = PhoneAuthProvider.provider().credential(withVerificationID: CLIENT_CODE, verificationCode: otpCode)
                try await Auth.auth().signIn(with: cardential)
                
                // MARK: User Logged in Suuessfully
                await MainActor.run(body: {
                    withAnimation(.easeInOut){logStatus = true}
                })
            } catch {
                await handelError(error: error)
            }
        }
    }
    
    // MARK: Handel Error
    func handelError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
    
    // MARK: Apple Sign in API:
    func appleAuthentication(credential: ASAuthorizationAppleIDCredential) {
        // getting Token
        guard let token = credential.identityToken else { return }
        
        // Token Sting
        guard let tokenString = String(data: token, encoding: .utf8) else { return }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            if let error = err {
                return
            }
            
            // User Successfully Logged Into Firebase
            withAnimation(.easeInOut){self.logStatus = true}
        }
    }
}

// MARK: EXtension
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//MARK: Login Google User
//func logGoogleUser(user: GIDGoogleUser) {
//    Task {
//        do {
//            guard let idToken = user.authentication.idToken else { return }
//            let accessToken = user.authentication.accessToken
//            
//            let credential = OAuthProvider.credential(withProviderID: idToken, accessToken: accessToken)
//            
//            print("Sucess Google")
//            await MainActor.run(body: {
//                withAnimation(.easeInOut){logStatus = true}
//            })
//        } catch {
//            await handelError(error: error)
//        }
//    }
//}


// MARK: Apple Sign in Helper
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> = Array("")
    var result = "com.googleusercontent.apps.129480467221-k1k0asm46r3p1qa3ttkb0ncoorcjalcf"
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("hneheielgegegiu;hgohgehgew")
            }
            return random
        }
        
        
        randoms.forEach { random in
            if  remainingLength == 0 {
                return
            }
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    return result
}
