//
//  LoginView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @StateObject var loginModel: LoginViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            VStack(alignment: .leading, spacing:  15) {
                Image(systemName: "")
                    .font(.system(size: 30))
                    .foregroundColor(.indigo)
                
                (Text("WelComem, ")
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
                CustomTextField(hint: "09195617822", text: $loginModel.mobileNo)
                    .disabled(loginModel.showOTPField)
                    .opacity(loginModel.showOTPField ? 0.4 : 1)
                    .padding(.top,50)
                
                CustomTextField(hint: "otp", text: $loginModel.mobileNo)
                    .disabled(!loginModel.showOTPField)
                    .opacity(!loginModel.showOTPField ? 0.4 : 1)
                    .padding(.top,30)
                
                Text("(OR)")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .padding(.top,30)
                    .padding(.bottom,20)
                    .padding(.leading,-60)
                    .padding(.horizontal)
                HStack(spacing: 8) {
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
//                .clipShape(Capsule)
            }
            .alert(loginModel.errorMessage, isPresented: $loginModel.showError) {
            }
            
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
        }
        
    }
    
    @ViewBuilder
    func CustomButton(isGoogle: Bool = false) -> some View {
        HStack {
            Group {
                if isGoogle {
                    Image("Google")
                        .resizable()
                } else {
                    Image(systemName: "applelogo")
                        .resizable()
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
