//
//  SignUpView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI
func doNothing() {
    print("doing nothing")
}
struct SignInView: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String  = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            VStack(spacing: 24) {
                Image("car 2")
                InputView(text: $email,
                          title: "Email address",
                          placeHolder: "name@example.com")
                .autocapitalization(.none)
                InputView(text: $password,
                          title: "Password",
                          placeHolder: "Enter your password",isSecureField: true)
                
                SignInButton(email: email, password: password)
                Spacer()
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                }
            }
            .padding(.horizontal)
            .padding(.top,12)
        }
            
    }
        
}
struct SignInButton: View {
    let email: String
    let password: String
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        // sign in button
        Button {
            Task {
                try await viewModel.signIn(withEmail: email, password: password)
            }
            
        } label: {
            HStack {
                Text("SIGN IN")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width-32, height: 48)
        }
        .background(Color(.systemBlue))
        .disabled(!formIsValid)
        .opacity(formIsValid ? 1.0 : 0.5)
        .cornerRadius(10)

        }
}
// MARK: - AuthenticationFormProtocol
extension SignInButton: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

