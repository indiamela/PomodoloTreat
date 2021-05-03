//
//  DoneListSubView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct DoneListSubView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .overlay(
                    HStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.MyTheme.yellowColor)
                            .frame(width: 6,height: 60)
                        Spacer()
                    }
                )
            HStack{
                HStack{
                    Text("1")
                        .font(.title3)
                    Text("Placeholder")
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack(alignment:.trailing){
                    HStack{
                        Image(systemName: "smile")
                        Text("70%")
                    }
                    Text("12:00-12:25")
                }
                .frame(width: 100)
            }
            .frame(height:60)
            .padding(.horizontal,10)
        }
        .frame(width: 327,height: 60)
        .shadow(color: Color(#colorLiteral(red: 0.46666666865348816, green: 0.7333333492279053, blue: 0.9333333373069763, alpha: 0.25)), radius:10, x:10, y:10)
        .padding(10)

//        .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))

    }
}

struct DoneListSubView_Previews: PreviewProvider {
    static var previews: some View {
        DoneListSubView()
            .previewLayout(.sizeThatFits)
    }
}
