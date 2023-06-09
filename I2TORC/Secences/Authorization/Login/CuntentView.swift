//
//  CuntentView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/9/23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct CuntentView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus {
            DemoHome()
        } else {
            LoginView()
        }
    }
    
    @ViewBuilder
    func DemoHome() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                Text("Logged In")
                    .navigationTitle("Multi-Login")
                    .toolbar {
                        ToolbarItem {
                            Button("Logout") {
                                try? Auth.auth().signOut()
                                GIDSignIn.sharedInstance.signOut()
                                withAnimation(.easeInOut) {
                                    logStatus = false
                                }
                            }
                        }
                    }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct CuntentView_Previews: PreviewProvider {
    static var previews: some View {
        CuntentView()
    }
}
