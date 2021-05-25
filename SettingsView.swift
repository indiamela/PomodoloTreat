//
//  ConfigView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/15.
//

import SwiftUI

struct SettingsView: View {
    @State var viblation = true
    @EnvironmentObject var timerManager:TimerManager
    let availableMinutes = Array(1...59)
    var body: some View {
            Form{
                Section(header: Text("タイマーの長さ"))  {
                    Picker(selection: $timerManager.selectedWorkTimerIndex, label: Text("Work")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                }
                
                Section(header: Text("アラーム")) {
                    HStack{
                        Toggle(isOn: $viblation,
                               label: {
                                Text("通知音")
                               })
                    }
                    HStack{
                        Toggle(isOn: $viblation,
                               label: {
                                Text("ヴァイブレーション")
                               })
                    }
                }
            }
        .navigationTitle("Setting")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingsView()
                .environmentObject(TimerManager())
        }
    }
}
