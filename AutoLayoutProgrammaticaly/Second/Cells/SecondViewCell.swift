//
//  SecondViewCell.swift
//  AutoLayoutProgrammaticaly
//
//  Created by HaoLe on 5/14/19.
//  Copyright © 2019 BTS. All rights reserved.
//

import UIKit

//protocol SecondViewCellDelegate {
//    func secondViewCell(_ cell: SecondViewCell, onDeleteRowAt indexPath: IndexPath)
//}

class SecondViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var indexPath: IndexPath!
//    var delegate: SecondViewCellDelegate? = nil
    
    public var onDeleteRowHandler: ((IndexPath) -> (Void))?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
//        delegate?.secondViewCell(self, onDeleteRowAt: indexPath)
        onDeleteRowHandler?(indexPath)
    }
    
}
