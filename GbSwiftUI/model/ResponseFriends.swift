//
//  ResponseFriends.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 26.01.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import Foundation

struct ResponseFriends: Decodable {
    var count: Int
    var items: [User]
}
