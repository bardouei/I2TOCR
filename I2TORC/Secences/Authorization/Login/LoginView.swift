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
            }
            .padding(.leading,60)
            .padding(.vertical,15)
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
