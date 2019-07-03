//
//  CodingUserInfoKey+.swift
//  iSereis
//
//  Created by Filipe Amaral Neis on 01/07/19.
//  Copyright © 2019 Filipe Amaral Neis. All rights reserved.
//

import Foundation
public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
