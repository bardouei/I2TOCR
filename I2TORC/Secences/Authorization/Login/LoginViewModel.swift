//
//  LoginViewModel.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var mobileNo: String = ""
    @Published var otpCode: String = ""
    
    @Published var CLIENT_CODE: String = ""
    @Published var showOTPField: Bool = false
    
    // MARK: Error Prooerties
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: FireBase API's
    func getOTPCode() {
        Task {
            do {
                // MARK: Disable it when testing with real Device
                Auth.auth().se
            } catch {
               await habdelError(error: error)
            }
        }
    }
    
    func verifyOTPCode() {
        
    }
    
    // MARK: Handel Error
    
    func habdelError(error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}
