//
//  FriendsTabPresenter.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 02.02.2020.
//  Copyright © 2020 Nikita Boiko. All rights reserved.
//

import Foundation
import RealmSwift

class FriendsListPresenter {
    
    var token: NotificationToken?
    var friendsList: Results<User>!
    var sortedFriendsList = [Section<User>]()
    
    var realm: Realm?
    let listController: FriendListController
    
    init(listController: FriendListController) {
        self.listController = listController
    }
    
    func viewDidLoad() {
        do {
            realm = try Realm()
            friendsList = realm!.objects(User.self)
            getSectionStructure()
            self.token = friendsList.observe {  (changes: RealmCollectionChange) in
                switch changes {
                case .initial(let results):
                    self.listController.tableView.reloadData()
                case let .update(results, deletions, insertions, modifications):
                    self.listController.tableView.beginUpdates()
                    self.listController.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    self.listController.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.listController.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                         with: .automatic)
                    self.listController.tableView.endUpdates()
                case .error(let error):
                    print(error)
                }
                print("данные изменились")
            }
        } catch {
            print(error)
        }
        
        

    }
    
    func getSectionStructure() {

        let friendDictionary = Dictionary.init(grouping: friendsList) {
            $0.name.prefix(1)
        }
        sortedFriendsList = friendDictionary.map{Section(text: String($0.key), items: $0.value)}
        sortedFriendsList.sort{$0.text < $1.text}
    }
    
}
