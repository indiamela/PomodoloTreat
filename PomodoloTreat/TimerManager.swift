//
//  TimerManager.swift
//  TimerAppEN
//
//  Created by Farukh IQBAL on 07/04/2020.
//  Copyright © 2020 Farukh IQBAL. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TimerManager: ObservableObject {
    let ObjectWillChange = ObservableObjectPublisher()
    @Published var timerMode: TimerMode = .initial
    @Published var selectedWorkTimerIndex = 0
    @Published var selectedRestTimerIndex = 0
    var timeFinish = false{
        //@Publishedでラップされたのを外す処理
        willSet{
            ObjectWillChange.send()
        }
    }
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    
    var timer = Timer()
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
    func start() {
        self.timeFinish = false
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.reset()
                self.timeFinish = true
                return
            }
            self.secondsLeft -= 1
        })
    }
    
    func reset() {
        self.timeFinish = false
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
}

enum TimerMode {
    case running
    case paused
    case initial
}

func secondsToMinutesAndSeconds(seconds: Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
    
    return "\(minuteStamp) : \(secondStamp)"
}

