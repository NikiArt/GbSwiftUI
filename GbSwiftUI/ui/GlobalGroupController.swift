//
//  GroupController.swift
//  GbSwiftUI
//
//  Created by Nikita Boiko on 01.12.2019.
//  Copyright © 2019 Nikita Boiko. All rights reserved.
//

import UIKit

class GlobalGroupController: UITableViewController {
    let array = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GroupCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GroupCell")
        tableView.rowHeight = CGFloat(96)
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        cell.groupName.text = "Группа \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let add = UIContextualAction(style: .normal, title: "Добавить") { (_, view, _) in
            let cell = tableView.cellForRow(at: indexPath) as? GroupCell
            let currentGroupName = cell?.groupName.text ?? ""
            let arr = DataBinder.instance.groupList.filter{$0.name.contains(currentGroupName)}
            guard arr.count == 0 else {
                let alert=UIAlertController(title: "Внимание", message: "Эта группа уже добавлена", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in print("") }))
                self.present(alert, animated: true, completion: nil)
                tableView.reloadData()
                return
            }
            let newGroup = Group(name: cell?.groupName.text ?? "")
            DataBinder.instance.groupList.append(newGroup)
            tableView.reloadData()
        }
        add.backgroundColor = UIColor.green
        
        return UISwipeActionsConfiguration(actions: [add])
    }
}
