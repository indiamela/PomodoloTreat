//
//  TaskDetailView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//



import SwiftUI

struct CreateTaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @Binding var isPresented:Bool
    @Binding var start_time:Date
    @Binding var end_time:Date
    @State var passedTime:Int?
    @State var motivation: Double = 50
    @State var memo: String = ""
    @State var title:String = ""
    var arr:[String] = []
    
    var body: some View {
        VStack{
            Spacer()
            //Title
            HStack{
                TextField("Title", text: $title)
                    .font(.title)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:4, x:0, y:4)
                Spacer()
            }
            .padding(.top,20)
            .padding(.horizontal,20)
            
            //Date
                //3rd Feb
                HStack{
//                    Image("calendar")
                    DatePicker("START", selection: $start_time,displayedComponents:.hourAndMinute)
                    DatePicker("FINISH", selection: $end_time,displayedComponents:.hourAndMinute)

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
                Text("Memo")
                    .font(.caption)
                MultilineTextView(text: $memo)
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
                createTask()
                self.presentationMode.wrappedValue.dismiss()
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
        .padding()
        .background(Color.MyTheme.whiteColor)
        .cornerRadius(20)
        .edgesIgnoringSafeArea(.all)
    }
    func createTask(){
        TaskEntity.create(in: viewContext,
                          id: UUID().uuidString,
                          title: title,
                          memo: memo,
                          motivation: motivation,
                          start_time: start_time,
                          end_time: end_time
                          )
        print(start_time)
        print(end_time)
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    @State static var start_time:Date = Date()
    @State static var end_time:Date = Date().addingTimeInterval(25 * 60)
    @State static var isPresented = true
    static var previews: some View {
        CreateTaskView(isPresented:$isPresented,start_time: $start_time,end_time: $end_time)
    }
}
