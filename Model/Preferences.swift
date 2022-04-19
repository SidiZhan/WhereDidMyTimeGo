//
//  Preferences.swift
//  WhereDidMyTimeGo
//
//  Created by Sidi Zhan on 2022/4/17.
//

import Foundation

struct Preferences {
    // if lastOpenDate != today, then reset categories
    var lastOpenDate : Date {
        get {
            let d : Date
            d = Date.init(timeIntervalSinceReferenceDate: UserDefaults.standard.double(forKey: "lastOpenDate"))
            return d
        }
        set {
            let d : Double
            d = newValue.timeIntervalSinceReferenceDate
            UserDefaults.standard.set(d, forKey: "lastOpenDate")
        }
    }
    
    // let dict: [String: TimeInterval] = ["Work": 63, "Study": 3612]
    var categories : Dictionary<String, TimeInterval>  {
        get {
            return UserDefaults.standard.object(forKey: "categories") as? [String: TimeInterval] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "categories")
        }
    }
    
    // history: historical records ["yyyy-MM-dd": ["Work": 63, "Study": 3612]]
    var records: Dictionary<String, Dictionary<String, TimeInterval>> {
        get {
            return UserDefaults.standard.object(forKey: "records") as? [String: [String: TimeInterval]] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "records")
        }
    }
}
