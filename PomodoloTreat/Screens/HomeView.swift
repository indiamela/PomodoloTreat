//
//  WelcomeView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.start_time, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<TaskEntity>
    
    @ObservedObject var timerManager = TimerManager()
    
    @State var detailArray = TaskEntity()
    @State var newArray = TaskEntity()
    @State var showDetail = false
    @State var showNewTask = false
    @State var opacity = 0.0
    @State var showAllert = false
    @State var startTime = Date()
    @State var openSheet = TimerManager().$timeFinish
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
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
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
                        Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.MyTheme.whiteColor)
                            .shadow(color: Color.gray, radius:5, x:5, y:5)
                            .onTapGesture(perform: {
                                if self.timerManager.timerMode == .initial {
                                    self.startTime = Date()
                                    self.timerManager.setTimerLength(minutes: self.availableMinutes[0]*3)
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
                VStack{
                    ScrollView{
                        ForEach(tasks ,id:\.self){ task in
                            DoneListSubView(task: task)
                                .onTapGesture {
                                    showDetail = true
                                }
                                .sheet(isPresented: $showDetail, content: {
                                    TaskDetailView(taskArray: task, isPresented: $showDetail)
                                })
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .frame(height:450)

                    Spacer()
                }
//                .sheet(isPresented: $openSheet, content: {
//                    CreateTaskView(isPresented: $openSheet)
//                })
                .offset(y:-30)
//                NavigationLink("", destination: self.availableMinutes[0]*3)
//                if self.timerManager.timeFinish{
//                }
            }
        }
        .navigationBarHidden(true)
        
    }
    func popupNew(){
        //タイマーが0になったら新規作成モーダルを表示
    }

    func deleteTask(offsets: IndexSet){
        withAnimation{
            offsets.map{tasks[$0]}.forEach(viewContext.delete)
        }
    }
    func deleteTask(task: TaskEntity){
        withAnimation{
            tasks.filter{$0.id == task.id}.forEach(viewContext.delete)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        return NavigationView{
            HomeView()
                .environment(\.managedObjectContext, context)
        }
    }
}
