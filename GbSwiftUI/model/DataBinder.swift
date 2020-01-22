//
//  DataBinder.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation

struct Section<T> {
    var text: String
    var items: [T]
    
}

final class DataBinder {
    
    static let instance = DataBinder()
    var userList: [User]?
    var groupList: [Group]?
    var globalGroupList: [Group]?
    var friendsSection = [Section<User>]()
    
    private init() {}
//        userList = [
//            User(name: "Вася Иванов"),
//            User(name: "Иван Васин"),
//            User(name: "Вася Пупкин"),
//            User(name: "Петя Алексеев"),
//            User(name: "Андрей Исаев"),
//            User(name: "Кирилл Петров"),
//            User(name: "Алексей Панферов")
//        ]
//        groupList = [
//            Group(name: "ВК"),
//            Group(name: "ТНТ"),
//            Group(name: "Swift"),
//            Group(name: "Программисты"),
//            Group(name: "Java"),
//            Group(name: "Музыканты"),
//            Group(name: "Рисуем все"),
//            Group(name: "Geekbrains")
//        ]
//        
//        //getSectionStructure()
//    }
    
    func getSectionStructure() {
        let sortedFriendList = userList!.sorted{$0.name < $1.name}

        let friendDictionary = Dictionary.init(grouping: sortedFriendList) {
            $0.name.prefix(1)
        }
        friendsSection = friendDictionary.map{Section(text: String($0.key), items: $0.value)}
        friendsSection.sort{$0.text < $1.text}
    }
    
    
}
