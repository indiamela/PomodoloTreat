//
//  TreatView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import SwiftUI

struct TreatView: View {
    var body: some View {
        VStack{
            HStack{
                TextField("Create new Treat", text: <#T##Binding<String>#>)
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
