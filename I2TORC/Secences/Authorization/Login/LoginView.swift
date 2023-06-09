//
//  LoginView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct LoginView: View {
    @StateObject var loginModel: LoginViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            VStack(alignment: .leading, spacing:  15) {
                Image(systemName: "")
                    .font(.system(size: 30))
                    .foregroundColor(.indigo)
                
                (Text("WellCome, ")
                    .foregroundColor(.black) +
                 Text("\nLogin to continue")
                    .foregroundColor(.gray)
                )
                .font(.title)
                .fontWeight(.semibold)
                .lineSpacing(10)
                .padding(.top,20)
                .padding(.trailing,15)
                
                //MARK: Custom textField
                CustomTextField(hint: "+98 9195617822", text: $loginModel.mobileNo)
                    .disabled(loginModel.showOTPField)
                    .opacity(loginModel.showOTPField ? 0.4 : 1)
                    .overlay(alignment: .trailing, content: {
                        Button("Change") {
                            withAnimation(.easeInOut) {
                                loginModel.showOTPField = false
                                loginModel.otpCode = ""
                                loginModel.CLIENT_CODE = ""
                            }
                        }
                        .font(.caption)
                        .foregroundColor(.indigo)
                        .opacity(loginModel.showOTPField ? 1 : 0)
                    })
                    .padding(.top,15)
                CustomTextField(hint: "OTP Code", text: $loginModel.mobileNo)
                    .disabled(!loginModel.showOTPField)
                    .opacity(!loginModel.showOTPField ? 0.4 : 1)
                    .padding(.top,30)
                Button(action: loginModel.showOTPField ? loginModel.verifyOTPCode : loginModel.getOTPCode) {
                    HStack(spacing: 15) {
                        Text(loginModel.showOTPField ? "Verifay Code" : "Get Code")
                            .fontWeight(.semibold)
//                            .contentTransition(.identity)

                        Image(systemName: "line.diagonal.arrow")
                            .font(.title3)
                            .rotationEffect(.init(degrees: 45))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal,25)
                    .padding(.vertical)
                    .background() {
                        RoundedRectangle(cornerRadius: 19, style: .continuous)
                            .fill(.black.opacity(0.05))
                    }
                }
            .padding(.leading,60)
            .padding(.vertical,15)
                
                Text("(OR)")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.top,30)
                    .padding(.bottom,20)
                    .padding(.leading,-60)
                    .padding(.horizontal)
                HStack(spacing: 8) {
                    //MARK: Custom Apple Sign In Button
                    CustomButton()
                    .overlay {
                        SignInWithAppleButton { (request) in
                            // request parametrs from apple login
                            loginModel.nonce = randomNonceString()
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = sha256(loginModel.nonce)
                        } onCompletion: {(result) in
                            switch result {
                            case .success(let user):
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                    return
                                }
                                loginModel.appleAuthentication(credential: credential)
                                
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 55)
                        .blendMode(.overlay)
                    }
                    .clipped()
                    
                    //MARK: Custom Google Sign in Button
                    CustomButton(isGoogle: true)
                        .overlay {
//                            if let clientID = FirebaseApp.app()?.options.clientID {
//                                GoogleSignInButton {
//                                    GIDSignIn.sharedInstance.singIn(with: .init(clientID: clientID), presenting: UIApplication.shared.rootViewController()){ user, error
//                                        
//                                    }
//                                }
//                            }
                        }
                        .clipped()
                }
                .padding(.leading,-60)
                .frame(maxWidth: .infinity)
            }
            .padding(.leading,60)
            .padding(.vertical,15)

        }
        .alert(loginModel.errorMessage, isPresented: $loginModel.showError) {
        }
    }
    
    @ViewBuilder
    func CustomButton(isGoogle: Bool = false) -> some View {
        HStack {
            Group {
                if isGoogle {
                    Image("google")
                        .resizable()
//                        .renderingMode(.template)
                } else {
                    Image(systemName: "applelogo")
                        .resizable()
//                        .renderingMode(.template)
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25)
            .frame(height: 46)
            
            Text("\(isGoogle ? "Google" : "Apple") Sign in")
                .font(.callout)
                .foregroundColor(.white)
                .lineLimit(1)
        }
        .padding(.horizontal,15)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

