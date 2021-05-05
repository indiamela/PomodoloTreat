//
//  WelcomeView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

struct HomeView: View {
//    @EnvironmentObject var timeManager:TimeManager
    @ObservedObject var timerManager = TimerManager()

    var toDate = Calendar.current.date(byAdding:.hour,value:1,to:Date())
    
    @State var taskArray = [TaskModel]()
    @State var array:TaskModel = TaskModel(title: "", motivation: 0.0, start_time: "", end_time: "")
    @State var showDetail = false
    @State var showCreateView = false
    @State var opacity = 0.0
    let availableMinutes = Array(1...59)

    var body: some View {
        ZStack{
            Color.MyTheme.whiteColor
                 .edgesIgnoringSafeArea(.all)
            //MARK:TIMER -
            VStack{
                ZStack{
                    //Rectangle
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.MyTheme.yellowColor)
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
                        Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                            .font(.custom("Roboto Regular", size: 72))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .textCase(.uppercase)
                            .shadow(color: Color.gray, radius:5, x:5, y:5)

                        
                        //start
                        //-background
                        Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.MyTheme.whiteColor)
                            .shadow(color: Color.gray, radius:5, x:5, y:5)
                            .onTapGesture(perform: {
                                if self.timerManager.timerMode == .initial {
                                    self.timerManager.setTimerLength(minutes: self.availableMinutes[0]*60)
                                }
                                self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                            })
                        Button(action: {
                            self.timerManager.reset()
                        }, label: {
                            Image(systemName: "goforward")
                        })
                        .font(.title)
                        .padding(.top,10)
                        .accentColor(Color.MyTheme.whiteColor)
                        .opacity(self.timerManager.timerMode == .paused ? 1.0 : 0.0)
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
                                    array = task
                                    showDetail.toggle()
                                }
                        }
                    }
                }
                .offset(y:-30)
            }
            if showDetail || timerManager.secondsLeft == 0{
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
                    if showDetail{
                        TaskDetailView(taskArray: $array)
                    }else{
                        TaskDetailView(taskArray: $array)
                    }
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
        .navigationBarHidden(true)
    }
    func getTask(){
        let array1 = TaskModel(title: "読書", motivation: 70, start_time: "12:00", end_time: "12:25")
        let array2 = TaskModel(title: "映画", motivation: 50, start_time: "13:00", end_time: "13:25")
        let array3 = TaskModel(title: "勉強", motivation: 80, start_time: "14:00", end_time: "14:25")
        taskArray.append(array1)
        taskArray.append(array2)
        taskArray.append(array3)
    }
    func popupNew(){
        //タイマーが0になったら新規作成モーダルを表示
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
