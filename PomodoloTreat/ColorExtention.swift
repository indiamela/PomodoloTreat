//
//  ColorExtention.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import Foundation
import SwiftUI

extension Color{
    
    struct MyTheme{
        static var redColor:Color{
            return Color("ColorRed")
        }
        static var yellowColor:Color{
            return Color("ColorYellow")
        }
        static var blueColor:Color{
            return Color("ColorLightBlue")
        }
        static var whiteColor:Color{
            return Color("ColorWhite")
        }
    }
}

extension LinearGradient{
    static var gradientOrange:LinearGradient{
        return LinearGradient(
            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 1, green: 0.3803921639919281, blue: 0.4313725531101227, alpha: 1)), location: 0),
                                .init(color: Color(#colorLiteral(red: 1, green: 0.7490196228027344, blue: 0.4431372582912445, alpha: 1)), location: 1)]),
            startPoint: .leading,
            endPoint: .trailing)
    }
    static var gradientBlue:LinearGradient{
        return LinearGradient(
            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.07058823853731155, green: 1, blue: 0.9686274528503418, alpha: 1)), location: 0),
                                .init(color: Color(#colorLiteral(red: 0.7019608020782471, green: 1, blue: 0.6705882549285889, alpha: 1)), location: 1)]),
            startPoint: UnitPoint(x: 0, y: 0.5),
            endPoint: UnitPoint(x: 1, y: 0.5))
    }
}

extension RadialGradient{
    static var RadialBlue: RadialGradient {
        return RadialGradient(
            gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.33725494146347046, green: 0.8000000715255737, blue: 0.9490196108818054, alpha: 0.11999999731779099)), location: 0),
                                .init(color: Color(#colorLiteral(red: 0.33725491166114807, green: 0.800000011920929, blue: 0.9490196108818054, alpha: 1)), location: 1)]),
            center: UnitPoint(x: 0.5, y: 0.5),
            startRadius: 1,
            endRadius: 100
        )
    }
}
