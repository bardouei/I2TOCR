//
//  ContentView.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/4/23.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @State var isActive = false
    var body: some View {
        
        if isActive {
          AuthorizationVC()
        } else {
            LottieView(filename: "splash")
                .frame(width: 300, height: 300, alignment: .center)
        }
    }
}

struct LottieView: UIViewRepresentable {
//    typealias UIViewType = UIView
    var filename: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        // add animate
        let animationView = LottieAnimationView()
        if let animation = LottieAnimation.named(filename) {
            animationView.animation = animation
            animationView.loopMode = .loop
            animationView.contentMode = .scaleAspectFit
            animationView.frame = view.bounds
            view.addSubview(animationView)
            animationView.play()
            
            animationView.play(fromProgress: 0, toProgress: 1, loopMode: .playOnce) { isFinished in
                if isFinished {
                    withAnimation {
//                        self.isActive = true
                    }
                }
            }
            
            animationView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
            
        }
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
    
    
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
