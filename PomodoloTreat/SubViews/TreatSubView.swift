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
            .multilineTextAlignment(.leading)
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                                        .init(color: Color.MyTheme.blueColor, location: 0),
                                        .init(color: Color.MyTheme.blueColor.opacity(0.2), location: 1)]),
                    startPoint: UnitPoint(x: 0, y: 0.5),
                    endPoint: UnitPoint(x: 1, y: 0.5))
            )
    }
}

struct TreatSubView_Previews: PreviewProvider {
    static var previews: some View {
        TreatSubView(text:"ナッツ3粒GET")
            .previewLayout(.sizeThatFits)
    }
}
