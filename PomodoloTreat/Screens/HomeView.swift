//
//  WelcomeView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI

struct HomeView: View {
//
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.start_time, ascending: true)],
            animation: .default)
        private var tasks: FetchedResults<TaskEntity>

    @ObservedObject var timerManager = TimerManager()

    var toDate = Calendar.current.date(byAdding:.hour,value:1,to:Date())
    
    @State var taskArray = [TaskModel]()
    @State var array:TaskModel = TaskModel(title: "",memo: "", motivation: 0.0, start_time: "", end_time: "")
    @State var showDetail = false
    @State var opacity = 0.0
    var start_time = "12:00"
    var end_time = "12:00"
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
                        //-background
                        Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.MyTheme.whiteColor)
                            .shadow(color: Color.gray, radius:5, x:5, y:5)
                            .onTapGesture(perform: {
                                if self.timerManager.timerMode == .initial {
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
                    List{
                        ForEach(tasks){ task in
//                            DoneListSubView(task: task)
                            Text(task.title ?? "")
//                                .onTapGesture {
//                                    array = task
//                                    showDetail.toggle()
//                                }
                        }
                        .onDelete(perform: deleteTask)
                    }
                }
                .offset(y:-30)
            }
            if showDetail || timerManager.timeFinish{
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
                //詳細画面開いていたら
                    if showDetail && !self.timerManager.timeFinish {
                        TaskDetailView(taskArray: $array)
                    }else{
                        CreateTaskView(start_time: "12:00", end_time: "12:25")
                            .onAppear(perform: {
                                addItem()
                            })
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
        TaskEntity.create(in: viewContext,
                          title: "読書",
                          memo: "いっぱい読んだ",
                          start_time: "12:00",
                          end_time: "12:25"
                          )
        TaskEntity.create(in: viewContext,
                          title: "映画",
                          memo: "いっぱい見た",
                          start_time: "13:00",
                          end_time: "13:25"
                          )

        TaskEntity.create(in: viewContext,
                          title: "勉強",
                          memo: "いっぱい勉強した",
                          start_time: "14:00",
                          end_time: "14:25"
                          )
    }
    func popupNew(){
        //タイマーが0になったら新規作成モーダルを表示
    }
    func deleteAll(){
        tasks.forEach(viewContext.delete)
    }
    func addItem() {
        let newTask = TaskEntity(context: viewContext)
        newTask.title = "勉強"
        newTask.memo = "いっぱい勉強した"
        newTask.start_time = "14:00"
        newTask.end_time = "14:25"
        withAnimation {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    func deleteTask(offsets: IndexSet){
        withAnimation{
            offsets.map{tasks[$0]}.forEach(viewContext.delete)
        }
    }

    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
