//
//  ContentView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/02.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView{
            NavigationView{
                HomeView()
            }
            .navigationBarHidden(true)
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            NavigationView{
                RewordView()
            }
            .navigationBarHidden(true)
            .tabItem {
                Image(systemName: "rosette")
                Text("Reword")
            }
            NavigationView{
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
        .accentColor(Color.MyTheme.yellowColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerManager())
    }
}
