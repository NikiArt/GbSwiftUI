//
//  ConnectingPref.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 12.01.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import Foundation

class ConnectingPref {
    static let shared = ConnectingPref()
    
    let token = ""
    var userId: Int = 0
    
    private init() {}
}
