//
//  DateUnits.swift
//  PomodoloTreat
//
//  Created by Taishi Kusunose on 2021/05/08.
//

import Foundation

public class timeText{
    func start(start_time: Date) -> String{
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        df.locale = Locale(identifier: "ja_JP")
        return df.string(from: start_time)
    }

    func end(start_time: Date, minute: Int) -> String{
        let calendar = Calendar(identifier: .gregorian)
        let end_time = calendar.date(byAdding: DateComponents(minute: minute), to: start_time)!
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        df.locale = Locale(identifier: "ja_JP")
        return df.string(from: end_time)
    }
}

