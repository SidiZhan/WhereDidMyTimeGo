//
//  HistoryViewController.swift
//  WhereDidMyTimeGo
//
//  Created by Sidi Zhan on 2022/4/16.
//

import Cocoa

class HistoryViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var datePicker: NSDatePicker!
    let prefs = Preferences()
    var record: Dictionary<String, TimeInterval> = [:]
    var categories: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        updateDisplay()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        updateDisplay()
    }
    
}


extension HistoryViewController {
    func updateDisplay() {
        let date = datePicker.dateValue
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        record = prefs.records[dateString] ?? [:]
        categories = []
        if !record.isEmpty {
            for k in record.keys {
                categories.append(k)
            }
        }
        tableView.reloadData()
    }
}


extension HistoryViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return categories.count
    }

}


extension HistoryViewController: NSTableViewDelegate {

    fileprivate enum CellIdentifiers {
        static let CategoryCell = "category"
        static let TimeCell = "hours"
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""
        let key = categories[row]

        if tableColumn == tableView.tableColumns[0] {
            text = key
            cellIdentifier = CellIdentifiers.CategoryCell
        } else if tableColumn == tableView.tableColumns[1] {
            guard let time = record[key] else {
                    return nil
                }
            let elapsedTime = time.rounded()
            let hours = floor(elapsedTime / 3600)
            let minutes = floor((elapsedTime - hours * 3600) / 60)
            let seconds = elapsedTime - (hours * 3600) - (minutes * 60)
            
            let hoursDisplay = String(format: "%02d", Int(hours))
            let minutesDisplay = String(format: "%02d", Int(minutes))
            let secondsDisplay = String(format: "%02d", Int(seconds))
            text = "\(hoursDisplay):\(minutesDisplay):\(secondsDisplay)"
            cellIdentifier = CellIdentifiers.TimeCell
        }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }

}
