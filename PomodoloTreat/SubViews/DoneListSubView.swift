//
//  DoneListSubView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct DoneListSubView: View {
//    var number:Int
//    var title:String
//    var motivation:Int
//    var start_time:String
//    var end_time:String
    var task:TaskModel
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .overlay(
                    HStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.MyTheme.yellowColor)
                            .frame(width: 6,height: 60)
                        Spacer()
                    }
                )
            HStack{
//                HStack{
//                    Text("\(String(count))")
//                        .font(.title3)
                    Text(task.title)
                        .multilineTextAlignment(.leading)
//                }
                Spacer()
                VStack(alignment:.trailing){
                    HStack{
                        Image("happy")
                        Text("\(Int(task.motivation))%")
                    }
                    Text("\(task.start_time)-\(task.end_time)")
                }
                .frame(width: 100)
            }
            .frame(height:60)
            .padding(.horizontal,10)
        }
        .frame(width: 327,height: 60)
        .shadow(color: Color(#colorLiteral(red: 0.46666666865348816, green: 0.7333333492279053, blue: 0.9333333373069763, alpha: 0.25)), radius:10, x:10, y:10)
        .padding(5)
    }
}

struct DoneListSubView_Previews: PreviewProvider {
    var task:TaskModel

    static var previews: some View {
        DoneListSubView(task: TaskModel(title: "aaa", memo:"いっぱい読んだ", motivation: 70, start_time: "00:00", end_time: "00:00"))
            .previewLayout(.sizeThatFits)
    }
}
