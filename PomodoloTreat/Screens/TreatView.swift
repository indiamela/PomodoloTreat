//
//  TreatView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct TreatView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RewordEntity.title,
                                           ascending: true)],
        animation: .default)
    private var rewords: FetchedResults<RewordEntity>
    @State var treatArray:[String] = ["aaaaaa","bbbbb"]
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
//                        treatArray.append(self.new)
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 25, weight: .medium, design: .default))
                            .shadow(color: Color.gray, radius:5, x:5, y:5)
                            .accentColor(Color.MyTheme.yellowColor)
                    })
                }
                .padding(20)
                List{
                    ForEach(treatArray,id:\.self){ treat in
                        Text(treat)
                            .frame(height:30)
                    }
                    .onDelete{offsets in
                        self.treatArray.remove(atOffsets: offsets)}
                    .listRowBackground(Color.MyTheme.yellowColor.opacity(0.7))
                }
            }
        }
        .navigationBarTitle("Reword")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct TreatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TreatView()
        }
    }
}
