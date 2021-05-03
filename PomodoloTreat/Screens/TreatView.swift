//
//  TreatView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct TreatView: View {
    @State var treatArray:[String] = ["aaaaaa","bbbbb"]
    @State var new = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                TextField("Create new Treat", text: $new)
                Button(action: {
                    treatArray.append(self.new)
                }, label: {
                    Image(systemName: "plus.circle.fill")
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
            }
        }
            .navigationBarTitle("Treat")
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
