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
        ZStack {
            Color(uiColor: Colors.grayDark)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators:  false) {
                VStack(alignment: .leading, spacing:  15) {
                    Image(systemName: "")
                        .font(.system(size: 30))
                        .foregroundColor(.indigo)
                    
                    (Text("WellCome, ")
                        .foregroundColor(.white) +
                     Text("\nLogin to continue")
                        .foregroundColor(Color(uiColor: Colors.grey3))
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineSpacing(10)
                    .padding(.top,20)
                    .padding(.trailing,15)
                    
                    //MARK: Custom textField
                    CustomTextField(hint: "E_mail", text: $loginModel.mobileNo)
                        .opacity(loginModel.showOTPField ? 0.4 : 1)
                        .foregroundColor(.white)
                        .padding(.top,50)
                    
                    CustomTextField(hint: "Password", text: $loginModel.otpCode)
                        .opacity(loginModel.showOTPField ? 0.4 : 1)
                        .foregroundColor(.white)
                        .padding(.top,30)
                    
                    Button(action: loginModel.showOTPField ? loginModel.verifyOTPCode : loginModel.getOTPCode) {
                        HStack(spacing: 15) {
                            Text("Login")
                                .fontWeight(.semibold)
                                .contentTransition(.identity)

                            Image(systemName: "line.diagonal.arrow")
                                .font(.title3)
                                .rotationEffect(.init(degrees: 45))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal,25)
                        .padding(.vertical)
                        .background() {
                            RoundedRectangle(cornerRadius: 19, style: .continuous)
                                .fill(.white.opacity(0.05))
                        }
                    }
                .padding(.leading,85)
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
//                            .clipShape(Capsule())
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
                    
                    Text("Don't have an Account ?")
                        .foregroundColor(Color(uiColor: Colors.lightedBlue))
                        .font(.callout)
                        .padding(20)
                                         
                    .padding(.leading,-60)
                    .frame(maxWidth: .infinity)
                }
                .padding(.leading,60)
                .padding(.vertical,15)

            }
            .alert(loginModel.errorMessage, isPresented: $loginModel.showError) {
            }
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
                .foregroundColor(.black)
                .lineLimit(1)
        }
        .padding(.horizontal,10)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

