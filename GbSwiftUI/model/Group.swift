//
//  Group.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation

class Group: Decodable {
    
    var id: Int = 0
    var name: String = ""
    var photoUri: String = ""
    
    init(){}
    
    init (name: String){
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUri = "photo_50"
        case name
    }
}
