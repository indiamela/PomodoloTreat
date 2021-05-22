//
//  RewordView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct RewordView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RewordEntity.title,
                                           ascending: true)],
        animation: .default)
    private var rewords: FetchedResults<RewordEntity>
    @State var new = ""
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        ZStack{
            Color.MyTheme.whiteColor
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("card")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top,20)
                    .opacity(0.3)
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                HStack{
                    TextField("Create new Treat", text: $new)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .shadow(color: Color.gray, radius:5, x:5, y:5)

                    Button(action: {
                        if !new.isEmpty {
                            RewordEntity.create(in: viewContext, title: new)
                            new = ""
                        }
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 25, weight: .medium, design: .default))
                            .shadow(color: Color.gray, radius:5, x:5, y:5)
                            .accentColor(Color.MyTheme.redColor)
                    })
                }
                .padding(20)
                List{
                    ForEach(rewords,id:\.self){ reword in
                        Text(reword.title!)
                            .frame(height:30)
                    }
                    .onDelete(perform: deleteReword)
                    .listRowBackground(LinearGradient.gradientOrange.opacity(0.7))

                }
            }
        }
        .navigationBarTitle("Reword")
        .navigationBarTitleDisplayMode(.large)
    }
    
    func deleteReword(offsets: IndexSet){
        withAnimation{
            offsets.map{rewords[$0]}.forEach(viewContext.delete)
        }
    }
}

struct RewordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            let context = PersistenceController.preview.container.viewContext
            RewordView()
                .environment(\.managedObjectContext, context)
        }
    }
}
