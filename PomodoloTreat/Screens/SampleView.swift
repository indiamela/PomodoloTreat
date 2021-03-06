//
//  SampleView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct SampleView: View {
    @State var motivation: Double = 0
    @State var detailText: String = ""
    var body: some View {
        VStack{
            
            VStack{
                //Title
                HStack{
                    Text("読書")
                        .font(.title)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
                    Spacer()
                }
                .padding(.top,20)
                .padding(.horizontal,20)
                
                //Date
                HStack(){
                    Image("calendar")
                    //3rd Feb
                    Text("2021.05.02 12:00 - 12:25").font(.custom("Roboto Medium", size: 14))
                    Spacer()
                }
                .padding(.top,10)
                .padding(.horizontal,20)
                
                //Slider
                VStack{
                    ZStack{
                        LinearGradient.gradientOrange
                            .frame(height:30)
                            .mask(Slider(value: $motivation,in: 0...100, step:1))
                        Slider(value: $motivation,in: 0...100, step:1)
                            .opacity(0.05)
                    }
                    HStack{
                        Image("sad")
                        Spacer()
                        Text("\(Int(motivation))")
                        Spacer()
                        Image("happy")
                    }
                }
                .padding(.top,10)
                .padding(.horizontal,20)
                
                //Text
                VStack(alignment: .leading){
                    Text("要点など")
                        .font(.caption)
                    MultilineTextView(text: $detailText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 70)
                }
                .padding(.top,20)
                .padding(.horizontal,20)
                
                //Treat
                //rectangle-375
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                ],
                alignment: .center,
                spacing: nil,
                pinnedViews: [],
                content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .overlay(
                            Text("ナッツ3粒GET")
                                .font(.custom("Roboto Regular", size: 10))
                                .multilineTextAlignment(.center)
                        )
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(RadialGradient.RadialBlue)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                    
                })
                .padding(.vertical,20)
                .padding(.horizontal,20)
                Image("createButton")
                    .frame(width: 335)
            }
            .frame(width: 335)
            .background(Color.MyTheme.whiteColor)
            .cornerRadius(20)
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
    }
}
