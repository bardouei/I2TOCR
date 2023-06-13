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
    var contentType: UITextContentType = .emailAddress
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField(hint, text:$text)
                .keyboardType(.emailAddress)
                .textContentType(contentType)
                .focused($isEnable)
                .placeholder(when: text.isEmpty) {
                    Text(hint).foregroundColor(Color(uiColor: Colors.grey2))
                }
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color(uiColor: Colors.grey2).opacity(0.2))
                
                Rectangle()
                    .fill(.white)
                    .frame(width: isEnable ? nil : 0, alignment: .leading)
                    .animation(.easeInOut(duration: 0.3), value: isEnable)
            }
            .frame(height: 2)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
