//
//  SideMenuView.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/15.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isOpen: Bool

    var body: some View {
        ZStack {
            // 背景部分
            GeometryReader { geometry in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .opacity(1.0)
            .animation(.easeIn(duration: 0.25))
            .onTapGesture {
                self.isOpen = false
            }

            // Todo: ここにリスト部分を実装する
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    @State static var isOpen = true
    static var previews: some View {
        SideMenuView(isOpen: $isOpen)
    }
}
