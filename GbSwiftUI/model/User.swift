//
//  User.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, Decodable {
    
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
    
    required init(){}
    
    init(name: String) {
        super.init()
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case photoUri = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["name"]
    }
    
    func addToDb(friends: [User]) {
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL)
                realm.beginWrite()
                realm.add(friends, update: .modified)
                try realm.commitWrite()
                
            } catch {
                print(error)
            }

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
