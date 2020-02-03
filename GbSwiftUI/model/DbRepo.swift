//
//  DbRepo.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 02.02.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import Foundation
import RealmSwift

class DbRepo {
    static let shared = DbRepo()
    
    private init() {}
    
    func addToDb<T: Object>(arrayOf: [T]) {
            do {
                let realm = try Realm()
                print(realm.configuration.fileURL)
                realm.beginWrite()
                realm.add(arrayOf, update: .modified)
                try realm.commitWrite()
                
            } catch {
                print(error)
            }

    }
}
