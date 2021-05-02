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
                            Image(systemName: "house")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Spacer()
                            Image(systemName: "house")                                .resizable()
                                .frame(width: 30, height: 30)
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
                ScrollView{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        HStack{
                            Text("Placeholder")
                            Spacer()
                            VStack{
                                HStack{
                                    Image(systemName: "smile")
                                    Text("70%")
                                }
                                Text("12:00 - 12:25")
                            }

                        }
                        .padding(10)
                    }
                    .frame(width: 300, alignment: .center)
                    .padding()
                    
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        HStack{
                            Text("Placeholder")
                            Spacer()
                            VStack{
                                HStack{
                                    Image(systemName: "smile")
                                    Text("70%")
                                }
                                Text("12:00 - 12:25")
                            }

                        }
                        .padding(10)
                    }
                    .frame(width: 300, alignment: .center)
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
