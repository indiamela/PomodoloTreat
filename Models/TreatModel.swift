//
//  TreatModel.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/03.
//

import Foundation
import SwiftUI

struct TreatModel: Identifiable, Hashable{
    var id = UUID()
    var title:String
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    } 
}
