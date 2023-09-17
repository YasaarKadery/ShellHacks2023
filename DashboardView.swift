//
//  DashboardView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            if let user = viewModel.currentUser {
                VStack {
                    Image("car with bg 1")
                    
                      .kerning(0.14865)
                      .foregroundColor(.white)
                    Text("Welcome to ")
                      .font(
                        Font.custom("Rubik", size: 32)
                          .weight(.bold)
                      )
                      .kerning(0.14865)
                      .foregroundColor(.white)
                    
                    Text("Drive Assistant, \(user.fullname)")
                      .font(
                        Font.custom("Rubik", size: 32)
                          .weight(.bold)
                      )
                      .kerning(0.14865)
                      .foregroundColor(.white)
                    Spacer()
                    NavigationLink {
                        SpeedView()
                    } label: {
                        ZStack {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(width: 358, height: 64)
                              .background(Constants.Primary)
                              .cornerRadius(10)
                            HStack {
                                Image(systemName: "steeringwheel")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    
                                Text("START DRIVE")
                                    .font(Font.custom("Rubik", size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        
                    }

            }
            }
                
        }
     
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
