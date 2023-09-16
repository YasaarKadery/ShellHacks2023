//
//  SpeedView.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import SwiftUI

import SwiftUI
import MapKit
struct SpeedView: View {
    var body: some View {
        ZStack {
            Constants.Background.ignoresSafeArea()
            Constants.linearGradientBackground.ignoresSafeArea()
            VStack {
                ShowSpeedView()
            }
        }

        
    }
}

struct ShowSpeedView: View {
    @ObservedObject private var gpsModel = GPSModel()
    var body: some View {
        
        VStack {
            Map(coordinateRegion: .constant(gpsModel.region), showsUserLocation: true)
                            .frame(height: 300) // Set the height of the map
                            .cornerRadius(16) // Add rounded corners
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 2) // Add a border
                            )
                            .padding(.horizontal) // Add horizontal padding
            
            Text("Speed:")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            
            Text("\(Int(gpsModel.averageSpeed)) MPH")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green) // Change text color
        }
        .alert("Slow down", isPresented: $gpsModel.shouldSlowDown) {
            Button("OK", role: .cancel) { }
        }
        .onAppear {
            gpsModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct SpeedLimitView_Previews: PreviewProvider {
    static var previews: some View {
        SpeedView()
    }
}



