//
//  TaskModel.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import Foundation
import SwiftUI

struct TaskModel: Identifiable, Hashable{
    var id = UUID()
    var title:String
    var memo:String
    var motivation:Double
    var start_time:String
    var end_time:String
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
}
