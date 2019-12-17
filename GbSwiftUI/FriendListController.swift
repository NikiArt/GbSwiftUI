//
//  FriendListController.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import UIKit

class FriendListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataBinder.instance.friendsSection[section].items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return DataBinder.instance.friendsSection.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        cell.friendName.text = DataBinder.instance.friendsSection[indexPath.section].items[indexPath.row].name
        cell.photo.image.image = UIImage(named: "ava")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "Photos") as! Photos
        
        viewController.user = DataBinder.instance.friendsSection[indexPath.section].items[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DataBinder.instance.friendsSection[section].text
    }

}
