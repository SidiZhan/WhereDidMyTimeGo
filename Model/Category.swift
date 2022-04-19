//
//  Category.swift
//  WhereDidMyTimeGo
//
//  Created by Sidi Zhan on 2022/4/16.
//

import Foundation

struct Category {
    var categoryList : [String] {
        get {
            UserDefaults.standard.stringArray(forKey: "categoryList") ?? ["NA"]
        }
    }
    var color : String
    var title : String
}
