//
//  StopwatchViewController.swift
//  WhereDidMyTimeGo
//
//  Created by Sidi Zhan on 2022/4/16.
//

import Cocoa

class StopwatchViewController: NSViewController {

    @IBOutlet weak var categoryButton: NSPopUpButton!
    @IBOutlet weak var timeField: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    var stopwatch = Stopwatch()
    var prefs = Preferences()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // userdefaults, popupbutton
        loadData()
        
        // category button
        categoryButton.selectItem(at: 0)
        
        // stopwatch
        configStopwatch()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        updateDisplay()
    }
    
    @IBAction func categoryChanged(_ sender: NSPopUpButton) {
        configStopwatch()
        updateDisplay()
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        stopwatch.startTimer()
        configureButtons()
    }
    
    @IBAction func stopButtonClicked(_ sender: Any) {
        stopwatch.stopTimer()
        let category = categoryButton.selectedItem?.title ?? ""
        prefs.categories[category] = stopwatch.elapsedTime
        saveData()
        configureButtons()
    }
}

extension StopwatchViewController: StopwatchProtocol {
    func elapsedTimeOnStopwatch(_ timer: Stopwatch) {
        updateDisplay()
    }
}

extension StopwatchViewController {
    func loadData() {
        let today = Date.init()
        let lastOpened = prefs.lastOpenDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: today)
        let lastOpenedString = formatter.string(from: lastOpened)
        let lastCategories = prefs.categories
        let newCategories: [String: TimeInterval] = ["Work": 0,
                                                     "Study": 0,
                                                     "Exercise": 0,
                                                     "Entertain": 0]
        
        if todayString != lastOpenedString || lastCategories.isEmpty {
            prefs.categories = newCategories
        }
    }
    
    func saveData() {
        // TODO: save the records (insert or update the file)
        let today = Date.init()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: today)
        prefs.records[todayString] = prefs.categories
        prefs.lastOpenDate = today
    }
    
    // get the selected category and find the time and change the stopwatch
    func configStopwatch() {
        let category = categoryButton.selectedItem?.title ?? ""
        
        // set stopwatch
        stopwatch.delegate = self
        let elapsedTime = prefs.categories[category] ?? 0
        stopwatch.initTimer(initTime: elapsedTime)
    }
    
    func updateDisplay() {
        var timeDisplay: String

        let elapsedTime = stopwatch.elapsedTime.rounded()
        let hours = floor(elapsedTime / 3600)
        let minutes = floor((elapsedTime - hours * 3600) / 60)
        let seconds = elapsedTime - (hours * 3600) - (minutes * 60)
        
        let hoursDisplay = String(format: "%02d", Int(hours))
        let minutesDisplay = String(format: "%02d", Int(minutes))
        let secondsDisplay = String(format: "%02d", Int(seconds))
        timeDisplay = "\(hoursDisplay):\(minutesDisplay):\(secondsDisplay)"
        timeField.stringValue = timeDisplay
    }
    
    func configureButtons() {
        startButton.isEnabled = !stopwatch.isTicking
        stopButton.isEnabled = stopwatch.isTicking
    }
}
