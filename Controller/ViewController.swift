//
//  ViewController.swift
//  WhereDidMyTimeGo
//
//  Created by Sidi Zhan on 2022/4/16.
//

import Cocoa
import Foundation

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func resetMenuItemSelected(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.reset()
    }


}

extension UserDefaults {

    enum Keys: String, CaseIterable {
        case categories
        case records
        case lastOpenDate
    }

    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }

}
