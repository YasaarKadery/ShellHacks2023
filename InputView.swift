//
//  InputView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeHolder: String
    var isSecureField = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.white))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeHolder, text: $text)
                    .font((.system(size: 14)))
            } else {
                TextField(placeHolder, text: $text)
                    .font((.system(size: 14)))
                    .foregroundColor(.gray)
                
            }
            
            Divider()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", placeHolder: "name@example.com")
    }
}
