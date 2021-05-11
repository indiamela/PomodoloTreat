//
//  TaskDetailView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskEntity.start_time, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<TaskEntity>
    @ObservedObject var taskArray:TaskEntity
    @Binding var isPresented:Bool
    @State var showAllert = false
    
    var body: some View {
            VStack{
                Spacer()
                //Title
                HStack{
                    Text(taskArray.title!)
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
                    Text("\(timeText().time(time: taskArray.start_time!))-\(timeText().time(time: taskArray.end_time!))")
                        .font(.custom("Roboto Medium", size: 14))
                    Spacer()
                }
                .padding(.top,10)
                .padding(.horizontal,20)
                
                //Slider
                VStack{
                    ZStack{
                        LinearGradient.gradientOrange
                            .frame(height:30)
                            .mask(Slider(value: $taskArray.motivation,in: 0...100, step:1))
                        Slider(value: $taskArray.motivation,in: 0...100, step:1)
                            .opacity(0.05)

                    }
                    HStack{
                        Image("sad")
                        Spacer()
                        Text("\(Int(taskArray.motivation))")
                        Spacer()
                        Image("happy")
                    }
                }
                .padding(.top,10)
                .padding(.horizontal,20)
                
                //Text
                VStack(alignment: .leading){
                    HStack{
                        Text("Memo")
                            .font(.caption)
                        Spacer()
                    }
                    Text(taskArray.memo!)
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
                        .fill(RadialGradient.RadialBlue)
                        .frame(width: 95, height: 95)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 95, height: 95)
                })
                .padding(.vertical,20)
                .padding(.horizontal,20)
                Spacer()
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
                        deleteTask()
                    }), secondaryButton: .cancel())
                })
            }
            .padding()
            .background(Color.MyTheme.whiteColor)
            .cornerRadius(20)
            .edgesIgnoringSafeArea(.all)
    }
    func deleteTask(){
        tasks.filter{$0.id == taskArray.id}.forEach(viewContext.delete)
        isPresented = false
    }
}

struct TaskDetailView_Previews: PreviewProvider {

    @State static var isPresented = true
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let task = TaskEntity(context: context)
        task.title = "読書"
        task.memo = "おもしろかった"
        task.start_time = Date()
        task.end_time = Date()
        task.motivation = 60
        task.id = UUID().uuidString
        return TaskDetailView(taskArray: task,isPresented:$isPresented)
//                    .previewLayout(.sizeThatFits)
    }
}
