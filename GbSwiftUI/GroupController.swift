//
//  GroupController.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import UIKit

class GroupController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataBinder.instance.groupList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.groupName.text = DataBinder.instance.groupList[indexPath.row].name
        return cell
    }
}
