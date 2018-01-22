//
//  AddItemToListDelegate.swift
//  ToDo List
//
//  Created by Ryan Kistner on 1/18/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import Foundation
protocol AddItemToListDelegate : class {
    func addItemToList(title : String, descirption: String, date : Date)
}
