//
//  WelcomeView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var timerManager:TimerManager
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.start_time, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<TaskEntity>
    
    @State var selectedPickerIndex = 0
    let availableMinutes = Array(1...59)
    
    @State var detailArray = TaskEntity()
    @State var newArray = TaskEntity()
    @State var showDetail = false
    @State var showNewTask = false
    @State var opacity = 0.0
    @State var showAllert = false
    @State var startTime = Date()
    @State var endTime = Date()
    @State var passedTime = 60
    @State var showActivityView = false
    @State var showMenuView = false
    
    
    var body: some View {
        ZStack{
            LinearGradient.gradientOrange
                .edgesIgnoringSafeArea(.all)
            //MARK:TIMER -
            VStack{
                Rectangle()
                    .fill(LinearGradient.gradientOrange)
                    .frame(height:60)
                .padding(.horizontal,30)
                
                //25:00
                Text(secondsToMinutesAndSeconds(seconds:timerManager.secondsLeft))
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
                            startTime = Date()
                            passedTime = self.availableMinutes[timerManager.selectedWorkTimerIndex]*60
                            endTime = startTime.addingTimeInterval(TimeInterval(passedTime))
                            self.timerManager.setTimerLength(minutes: self.passedTime)
                        }
                        self.timerManager.timerMode == .running ? self.timerManager.pause() : self.timerManager.start()
                    })
                Button(action: {
                    self.timerManager.reset()
                }, label: {
                    Image(systemName: "goforward")
                })
                .accentColor(Color.MyTheme.whiteColor)
                .opacity(self.timerManager.timerMode == .paused ? 1.0 : 0.0)
                .padding()
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30, style: .circular)
                        .fill(Color.MyTheme.whiteColor)
                        .shadow(color: Color.gray, radius:20, x:10, y:10)
                    
                    VStack{
                        ScrollView{
                            ForEach(tasks){ task in
                                Button(action: {
                                    showDetail.toggle()
                                }
                                , label: {
                                    DoneListSubView(task: task)
                                })
                                .sheet(isPresented: self.$showDetail, content: {
                                    TaskDetailView(taskArray: task, isPresented: $showDetail)
                                })
                            }
                        }
                        .accentColor(.black)
                        .padding(.top,30)
                        .sheet(isPresented: $timerManager.timeFinish, content: {
                            CreateTaskView(isPresented:$timerManager.timeFinish,start_time: $startTime,end_time: $endTime)
                        })
                        Rectangle()
                            .foregroundColor(Color.MyTheme.whiteColor)
                            .frame(height:80)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            SideMenuView(isOpen: $showMenuView)

        }
        .edgesIgnoringSafeArea(.all)
        
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
        let context = PersistenceController.shared.container.viewContext
        return NavigationView{
            HomeView()
                .environment(\.managedObjectContext, context)
                .environmentObject(TimerManager())

        }
    }
}
