//
//  Item.swift
//  TodoEdy
//
//  Created by Eddie Ortega on 2/17/19.
//  Copyright © 2019 Ortegalive Software. All rights reserved.
//

import Foundation

// For a class to be able, to be Encodable all of its properties must have standard data types.
// Mark our class as conforming to the protocols Encodable.
// This means that the item type is now able to encode itself into a plist or into a JSON file
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
