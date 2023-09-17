//
//  StaySafeView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

struct StaySafeView: View {
    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            VStack {
                StaySafeImage()
                Spacer()
                VStack {
                    StaySafeTitle()
                    StaySafeDescription()
                }
                .padding(.leading, 30.0)
                
                NavigationLink {
                    SignInView()
                } label: {
                    ZStack {
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 358, height: 64)
                          .background(Constants.TextWhite)
                          .cornerRadius(10)
                        Text("Next")
                        .font(
                        Font.custom("Poppins", size: 16)
                        .weight(.semibold)
                        )
                        .kerning(0.6)
                        .foregroundColor(Constants.TextBlack)
                        .frame(width: 44, height: 24, alignment: .leading)
                    }
                }

            }
        }
       
    }
}
struct StaySafeImage: View {
    var body: some View {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 453.0, height: 353.25)
          .background(
            Image("StaySafe")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 471, height: 353.25)
              .clipped()
          )
    }
}
struct StaySafeTitle: View {
    var body: some View {
        Text("STAY SAFE\nON THE ROAD")
          .font(
            Font.custom("Rubik", size: 36)
              .weight(.medium)
          )
          .kerning(0.6)
          .foregroundColor(Constants.TextWhite)
          .frame(width: 387, height: 136, alignment: .leading)
    }
}
struct StaySafeDescription: View {
    var body: some View {
        Text("Get real-time feedback on your driving habits. Our advanced telematic tracking alerts you about sudden brakes, speed limits, and more to help you drive safely.")
          .font(Font.custom("Rubik", size: 16))
          .padding(1.0)
          .kerning(1)
          .foregroundColor(Constants.SubheadingWhitishBlue)
          .frame(width: 387, height: 94, alignment: .leading)
    }
}


struct StaySafeView_Previews: PreviewProvider {
    static var previews: some View {
        StaySafeView()
    }
}

