//
//  Components.swift
//  CookLeat
//
//  Created by Iker Rero Martínez on 1/3/23.
//

import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String //We use this to keep what the user wrote when we cahnge from textField to secureField
    @State private var isSecured: Bool = true //Check if password is being showed or not
    private var title: String
    
//    preserve the text
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                //Set Secure and text field
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 32)
            
            Button(action: {
                isSecured.toggle() //change between Secure and text field
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
                    .tint(Color.yellow)
            }
        }
    }
}
