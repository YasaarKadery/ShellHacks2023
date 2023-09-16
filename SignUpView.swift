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
struct SignUpView: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String  = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            VStack {
                Form {
                    Section {
                        Text("First Name")
                        TextField("First Name", text: $firstname)
                    }
                    Section {
                        Text("Last Name")
                        TextField("Last Name", text: $lastname)
                    }
                    Section {
                        Text("Email")
                        TextField("Email", text: $email)
                    }
                    Section {
                        Text("Password")
                        TextField("Password",text:$password)
                    }
                }
                
                /**
                 TODO: SUBMIT POST REQUEST TO SIGN UP SERVER WHEN HITTING CREATE ACCOUNT
                 */
                NavigationLink {
                    // todo: add dashboard
                }label: {
                    CreateAccountButton()
                    .disabled(firstname.isEmpty || lastname.isEmpty || email.isEmpty || password.isEmpty)
                }
                
            }.scrollContentBackground(.hidden)
        }
            
    }
        
            
}
struct CreateAccountButton: View {
    var body: some View {
        Button(action: doNothing) {
            ZStack {
                Rectangle()
                  .foregroundColor(.clear)
                  .frame(width: 358, height: 64)
                  .background(Constants.Primary)
                  .cornerRadius(10)
                Text("Create Account")
                  .font(
                    Font.custom("Poppins", size: 16)
                      .weight(.semibold)
                  )
                  .kerning(0.6)
                  .foregroundColor(.white)
                  .frame(width: 139, height: 24, alignment: .leading)
            }

        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

