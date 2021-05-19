//
//  ConfigView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/15.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var timerManager:TimerManager
    let availableMinutes = Array(1...59)
    var body: some View {
            Form{
                Section(header: Text("TimerSet"))  {
                    Picker(selection: $timerManager.selectedWorkTimerIndex, label: Text("Work")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                    Picker(selection: self.$timerManager.selectedRestTimerIndex, label: Text("Rest")) {
                        ForEach(0 ..< availableMinutes.count) {
                            Text("\(self.availableMinutes[$0]) min")
                        }
                    }
                }
                
                Section(header: Text("ヘッダーテキスト")) {
                    Text("部品３")
                    Text("部品４")
                }
            }
        .navigationTitle("Setting")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SettingsView()
        }
    }
}
