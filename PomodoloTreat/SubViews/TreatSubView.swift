//
//  TreatSubView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct TreatSubView: View {
    var text:String
    var body: some View {
        
        Text(text)
            .frame(width: 315, height: 56)
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                                        .init(color: Color(#colorLiteral(red: 0.07058823853731155, green: 1, blue: 0.9686274528503418, alpha: 1)), location: 0),
                                        .init(color: Color(#colorLiteral(red: 0.7019608020782471, green: 1, blue: 0.6705882549285889, alpha: 1)).opacity(0.2), location: 1)]),
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5))
            )
            .padding(.top,20)
    }
}

struct TreatSubView_Previews: PreviewProvider {
    static var previews: some View {
        TreatSubView(text:"ナッツ3粒GET")
            .previewLayout(.sizeThatFits)
    }
}
