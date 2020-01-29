//
//  User.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation
import RealmSwift

class User: Decodable {
    
   @objc dynamic var id = 0
    @objc dynamic var name: String {
        get {
            return "\(self.firstName) \(self.lastName)"
        }
        set {}
    }
    @objc dynamic var photoUri = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    
    init(){}
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUri = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
//    required init(from decoder: Decoder) throws {
//        let mainDecoder = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try mainDecoder.decode(Int.self, forKey: .id)
//        self.firstName = try mainDecoder.decode(String.self, forKey: .firstName)
//        self.lastName = try mainDecoder.decode(String.self, forKey: .lastName)
//        self.photoUri = try mainDecoder.decode(String.self, forKey: .photoUri)
//        self.name = "\(self.firstName) \(self.lastName)"
//    }
}
