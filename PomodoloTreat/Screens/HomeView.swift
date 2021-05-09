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
    
    var toDate = Calendar.current.date(byAdding:.hour,value:1,to:Date())
    
    @State var taskArray = [TaskModel]()
    @State var array = TaskEntity()
    @State var showDetail = false
    @State var opacity = 0.0
    let availableMinutes = Array(1...59)
    @State var showAllert = false
    var indexSet:IndexSet?
    @State var onDelete = false


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
                    ScrollView{
                        ForEach(tasks ,id:\.self){ task in
                            DoneListSubView(task: task)
                                .onTapGesture {
                                    array = task
                                    showDetail = true
                                }
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .frame(height:450)
                    Spacer()
                }
                .offset(y:-30)
            }
            
            //MARK: DetailView
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
                        VStack{
                            TaskDetailView(taskArray: array)
                            Button(action: {
                                self.showAllert = true
                            }, label: {
                                HStack{
                                    Image(systemName: "trash")
                                    Text("Delete")
                                }
                                .frame(width: 335,height: 50)
                                .background(Color.MyTheme.redColor)
                                .foregroundColor(Color.MyTheme.whiteColor)
                                .cornerRadius(20)
                                .padding()
                            })
                            .alert(isPresented: $showAllert, content: {
                                Alert(title: Text("削除しますか"), primaryButton: .destructive(Text("削除"),action: {
                                                                                                        self.showDetail = false
                                                                                                        deleteTask(task: array)
                                    
                                }), secondaryButton: .cancel())
                            })
                        }
                    }else{
                        VStack{
                            CreateTaskView(start_time: "12:00", end_time: "12:25")

                            Button(action: {
                                timerManager.timeFinish = false
                                createTask()
                            }, label: {
                                HStack{
                                    Image(systemName: "plus.circle.fill")
                                    Text("Complete!")
                                }
                                .frame(width: 335,height: 50)
                                .background(Color.MyTheme.blueColor)
                                .foregroundColor(Color.MyTheme.whiteColor)
                                .cornerRadius(20)
                                .padding()
                            })
                        }
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
        .navigationBarHidden(true)
    }
    func createTask(){
        TaskEntity.create(in: viewContext,
                          id: UUID().uuidString,
                          title: "筋トレ",
                          memo: "めっちゃくちゃハードに頑張った！",
                          motivation: 60,
                          start_time: Date(),
                          end_time: Date()
                          )
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
