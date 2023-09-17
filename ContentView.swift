//
//  ContentView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                HomeView()
            } else {
                LaunchView()
            }
        }
            
    }
}

struct LaunchSubTextView: View {
    var body: some View {
        Text("Drive safer, understand better! NaviGuardian helps you improve your driving while demystifying car insurance for you.")
          .font(Font.custom("Rubik", size: 16))
          .kerning(1)
          .foregroundColor(Constants.SubheadingWhitishBlue)
          .frame(width: 305, height: 94, alignment: .leading)
    }
}
struct StartJourneyButton: View {
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Text("START JOURNEY")
            .font(
            Font.custom("Poppins", size: 16)
            .weight(.semibold)
            )
            .kerning(0.6)
            .foregroundColor(.white)
        }
        .padding(.horizontal, 111)
        .padding(.vertical, 20)
        .background(Constants.Primary)
        .cornerRadius(10)
    }
}
struct LaunchView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Constants.Background.ignoresSafeArea()
                Constants.linearGradientBackground.ignoresSafeArea()
                VStack {
                    LaunchImageView()
                    LaunchTextView()
                    LaunchSubTextView()
                    Spacer()
                    NavigationLink {
                        StaySafeView()
                    }label: {
                        StartJourneyButton()
                    }
                }

                }
        }.tint(Color.white)
            
        
    }
}

struct LaunchImageView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 414.12299, height: 282)
        
            .background(
                Image("launch-car")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 24.12)
                    .frame(width: 414.12298583984375, height: 282)
                    .clipped()
            )
    }
}

struct LaunchTextView: View {
    var body: some View {
        VStack {
            Text("WELCOME TO ")
                .font(Font.custom("Rubik", size: 48).weight(.medium))
                .kerning(0.6)
                .foregroundColor(.white)
            
            Text("NaviGuardian!")
                .font(Font.custom("Rubik", size: 48).weight(.medium))
                .kerning(0.6)
                .foregroundColor(.blue)
        }.frame(width: 387, height: 136, alignment: .center)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
