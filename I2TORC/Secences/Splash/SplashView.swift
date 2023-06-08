//
//  ContentView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isPresentingNextView = false
    var body: some View {
        VStack {
            LottieView(filename: "splash", completionHandler: {
                self.isPresentingNextView = true
            })
                .frame(width: 300, height: 300, alignment: .center)
        }
        .fullScreenCover(isPresented: $isPresentingNextView, content: {
            RegisterView()
                .transition(.move(edge: .top))
        })
    }
}
