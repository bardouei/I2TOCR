//
//  CustomTextField.swift
//  I2TORC
//
//  Created by sadegh bardouei on 6/8/23.
//

import SwiftUI

struct CustomTextField: View {
    var hint: String
    @Binding var text: String
    
    // MARK: View Poperties
    @FocusState var isEnable: Bool
    var contentType: UITextContentType = .telephoneNumber
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField(hint, text:$text)
                .keyboardType(.numberPad)
                .textContentType(contentType)
                .focused($isEnable)
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.black.opacity(0.2))
                
                Rectangle()
                    .fill(.black)
                    .frame(width: isEnable ? nil : 0)
                    .animation(.easeInOut(duration: 0.3), value: isEnable)
            }
            .frame(height: 2)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
