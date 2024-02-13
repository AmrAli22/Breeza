//
//  OrdersPageTableViewCell.swift
//  Breeza
//
//  Created by Amr Ali on 30/01/2024.
//

import UIKit

class OrdersPageTableViewCell: UITableViewCell {
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var recivedStatues: UILabel!
    @IBOutlet weak var stauesName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
