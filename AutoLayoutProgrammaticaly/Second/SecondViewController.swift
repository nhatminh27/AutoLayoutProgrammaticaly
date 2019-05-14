//
//  SecondViewController.swift
//  AutoLayoutProgrammaticaly
//
//  Created by HaoLe on 5/13/19.
//  Copyright © 2019 BTS. All rights reserved.
//

import UIKit

let cellIdentifier = "SecondViewCell"

class SecondViewController: UIViewController {
    
    @IBOutlet weak var listView: UITableView!
    
    var studentNames = [
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "fsjkhfjd",
        "2214",
        "6565656"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        listView.register(UINib(nibName: "SecondViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        listView.dataSource = self
        listView.delegate = self
        listView.rowHeight = 50.0
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
        studentNames.append(contentsOf: [
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "fsjkhfjd",
            "2214",
            "6565656"
            ])
        listView.reloadData()
    }

}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SecondViewCell
        let name = studentNames[indexPath.row]
        cell?.titleLabel.text = name
        cell?.indexPath = indexPath
//        cell?.delegate = self
        cell?.onDeleteRowHandler = {[weak self] (index) in
            self?.studentNames.remove(at: indexPath.row)
            self?.listView.reloadData()
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

//extension SecondViewController: SecondViewCellDelegate {
//    
//    func secondViewCell(_ cell: SecondViewCell, onDeleteRowAt indexPath: IndexPath) {
//        studentNames.remove(at: indexPath.row)
//        listView.reloadData()
//    }
//    
//}
