//
//  WelcomeView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.MyTheme.whiteColor
                 .edgesIgnoringSafeArea(.all)
            //MARK:TIMER -
            VStack{
                ZStack{
                    //Rectangle
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                                gradient: Gradient(stops: [
                                                    .init(color: Color(#colorLiteral(red: 1, green: 0.3803921639919281, blue: 0.4313725531101227, alpha: 1)), location: 0),
                                                    .init(color: Color(#colorLiteral(red: 1, green: 0.7490196228027344, blue: 0.4431372582912445, alpha: 1)), location: 1)]),
                                startPoint: .leading,
                                endPoint: .trailing))
                        .opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 40)
                    
                    VStack{
                        HStack{
                            Image(systemName: "text.justify")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(Color.MyTheme.whiteColor)
                            Spacer()
                            Image(systemName: "square.and.arrow.up")                                .resizable()
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(Color.MyTheme.whiteColor)
                        }
                        .padding(.horizontal,30)
                        Spacer()
                        
                        //25:00
                        Text("25:00").font(.custom("Roboto Regular", size: 72)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .rotationEffect(.degrees(-9.826939576278036e-14))
                            //Available in iOS 14 only
                            .textCase(.uppercase)
                        
                        //start
                        Text("start").font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(1)
                            .rotationEffect(.degrees(-9.826939576278036e-14))
                            //Available in iOS 14 only
                            .textCase(.uppercase)
                            .padding(.top,30)
                        Spacer()
                    }
                }
                .frame(height:300)
                
                //MARK:LIST -
                ScrollView{                    
                    //Box
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .shadow(color: Color(#colorLiteral(red: 0.46666666865348816, green: 0.7333333492279053, blue: 0.9333333373069763, alpha: 0.25)), radius:10, x:10, y:10)
                                .overlay(
                                    HStack{
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.MyTheme.yellowColor)
                                            .frame(width: 6)
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
                            .frame(height:30)
                            .padding()
                        }
                        .frame(width: 327)
                        .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))
                    }
                    .padding()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView{
            HomeView()
//        }
    }
}
