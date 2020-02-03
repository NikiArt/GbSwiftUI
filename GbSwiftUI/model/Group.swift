//
//  Group.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photoUri: String = ""
    
    required init(){}
    
    init (name: String){
        super.init()
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUri = "photo_100"
        case name
    }
}
