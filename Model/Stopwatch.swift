//
//  Stopwatch.swift
//  WhereDidMyTimeGo
//
//  Created by Sidi Zhan on 2022/4/17.
//

import Foundation

protocol StopwatchProtocol {
    func elapsedTimeOnStopwatch(_ timer: Stopwatch)
}

class Stopwatch {
    var timer: Timer? = nil
    var startTime: Date?
    var elapsedTime: TimeInterval = 0
    var delegate: StopwatchProtocol?
    
    var isTicking: Bool {
        return timer != nil
    }
    
    func timerAction() {
        guard let startTime = startTime else {
            return
        }
        elapsedTime = -startTime.timeIntervalSinceNow
        delegate?.elapsedTimeOnStopwatch(self)
    }
    
    func initTimer(initTime: TimeInterval) {
        startTime = Date()
        elapsedTime = initTime != 0 ? initTime : 0
    }
    
    func startTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timerAction()
        }
        timerAction()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timerAction()
    }
}
