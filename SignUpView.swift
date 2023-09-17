//
//  SignUpView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullname: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String  = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            VStack(spacing: 24) {
                Image("car 2")
                InputView(text: $email,
                          title: "Email address",
                          placeHolder: "name@example.com")
                .autocapitalization(.none)
                InputView(text: $fullname,
                          title: "Full Name",
                          placeHolder: "Enter your name")
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "Enter your password",isSecureField: true)
                InputView(text: $confirmPassword,
                          title: "Confirm Password",
                          placeHolder: "Confirm password",isSecureField: true)
                
                SignUpButton(email: email, fullname: fullname, password: password)
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                }
                
            }
            .padding(.horizontal)
            
        }
            
    }
    }


struct SignUpButton: View {
    let email: String
    let fullname: String
    let password: String
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Button {
            Task {
                try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
            }
            
        } label: {
            HStack {
                Text("SIGN UP")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width-32, height: 48)
        }
        .background(Color(.systemBlue))
        .cornerRadius(10)

        }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
