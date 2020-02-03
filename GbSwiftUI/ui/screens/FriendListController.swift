//
//  FriendListController.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import UIKit
import Kingfisher

class FriendListController: UITableViewController {

    @IBOutlet weak var friendSearch: UISearchBar!
    var listPresenter: FriendsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //friendSearch.delegate = self
        listPresenter = FriendsListPresenter(listController: self)
        listPresenter?.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listPresenter?.friendsList?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listPresenter?.sortedFriendsList.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        //cell.friendName.text = listPresenter?.sortedFriendsList[indexPath.section].items[indexPath.row].name
       // cell.photo.image.kf.setImage(with: URL(string: (listPresenter?.sortedFriendsList[indexPath.section].items[indexPath.row].photoUri)!))
        //cell.photo.image.image = UIImage(named: "ava")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "Photos") as! Photos
        
        //viewController.user = DataBinder.instance.friendsSection[indexPath.section].items[indexPath.row]
        viewController.user = listPresenter?.friendsList?[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listPresenter?.sortedFriendsList[section].text
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return listPresenter?.sortedFriendsList.map{$0.text}
    }

}

extension FriendListController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendDictionary = Dictionary.init(grouping: (listPresenter?.friendsList.filter { user -> Bool in
            return searchText.isEmpty ? true : user.name.lowercased().contains(searchText.lowercased())
            })!) { $0.name.prefix(1)}

        listPresenter?.sortedFriendsList = friendDictionary.map{ Section(text: String($0.key), items: $0.value)}
        listPresenter?.sortedFriendsList.sort{$0.text < $1.text}
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }


}
