//
//  WelcomeView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

struct HomeView: View {
    @State var taskArray = [TaskModel]()
    @State var showDetail = false
    @State var opacity = 0.0
    var body: some View {
        
        ZStack{
            Color.MyTheme.whiteColor
                 .edgesIgnoringSafeArea(.all)
            //MARK:TIMER -
            VStack{
                ZStack{
                    //Rectangle
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient.gradientOrange)
                        .opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                        .blur(radius: 30)
                    
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
                            .textCase(.uppercase)
                        
                        //start
                        Text("start").font(.custom("Roboto Regular", size: 18))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(1)
                            .textCase(.uppercase)
                            .padding(.top,30)
                        Spacer()
                    }
                }
                .frame(height:350)
                
                //MARK:LIST -
                ScrollView{
                    LazyVStack{
                        ForEach(taskArray,id:\.self){ task in
                            DoneListSubView(task: task)
                                .onTapGesture {
                                    showDetail.toggle()
                                }
                        }
                    }
                }
                .offset(y:-30)
            }
            if showDetail {
                ZStack{
                    //Rectangle
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.7)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showDetail = false
                            self.opacity = 0
                        }
                        .opacity(0.8)
                    TaskDetailView()
                }
                .opacity(self.opacity)
                .onAppear {
                    withAnimation(.linear(duration: 0.3)) {
                        // NOTE: opacityを変更する画面再描画に対してアニメーションを行う
                        self.opacity = 1.0
                    }
                }
            }
        }
        .onAppear(perform: {
            getTask()
        })
    }
    func getTask(){
        let array1 = TaskModel(title: "読書", motivation: 70, start_time: "12:00", end_time: "12:25")
        let array2 = TaskModel(title: "映画", motivation: 50, start_time: "13:00", end_time: "13:25")
        let array3 = TaskModel(title: "勉強", motivation: 80, start_time: "14:00", end_time: "14:25")
        taskArray.append(array1)
        taskArray.append(array2)
        taskArray.append(array3)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView{
            HomeView()
//        }
    }
}