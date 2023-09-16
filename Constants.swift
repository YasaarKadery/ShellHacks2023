//
//  Constants.swift
//  ShellHacks2023
//
//  Created by Yasaar Kadery on 9/16/23.
//

import Foundation
import SwiftUI


struct Constants {
    static let TextBlack: Color = .black
    static let TextWhite: Color = .white
    static let Background: Color = Color(red: 0.1, green: 0.11, blue: 0.12)
    static let SubheadingWhitishBlue: Color = Color(red: 0.82, green: 0.91, blue: 1)
    static let ContainerIconBluish: Color = Color(red: 0.23, green: 0.41, blue: 0.58)

    static let Primary: Color = Color(red: 0, green: 0.52, blue: 1)
    static let linearGradientBackground: LinearGradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.15, green: 0.32, blue: 0.74).opacity(0.8), location: 0.00),
            Gradient.Stop(color: Color(red: 0.02, green: 0.05, blue: 0.13).opacity(0), location: 0.71),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
}
