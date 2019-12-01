//
//  DataBinder.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import Foundation

final class DataBinder {
    
    static let instance = DataBinder()
    let userList: [User]
    var groupList: [Group]
    
    init() {
        userList = [
            User(name: "Вася Иванов"),
            User(name: "Иван Васин"),
            User(name: "Вася Пупкин"),
            User(name: "Петя Алексеев"),
            User(name: "Андрей Исаев"),
            User(name: "Кирилл Петров"),
            User(name: "Алексей Панферов")
        ]
        groupList = [
            Group(name: "ВК"),
            Group(name: "ТНТ"),
            Group(name: "Swift"),
            Group(name: "Программисты"),
            Group(name: "Java"),
            Group(name: "Музыканты"),
            Group(name: "Рисуем все"),
            Group(name: "Geekbrains")
        ]
    }
    
    
}
