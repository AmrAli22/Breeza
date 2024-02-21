//
//  ProductsMenuTableViewCell.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.
//

import UIKit

class ProductsMenuTableViewCell: UITableViewCell {

    var didPressAddToCartAction     : (() -> Void)?
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPcs: UILabel!
    @IBOutlet weak var prodCost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToOrderBtnPressed(_ sender: Any) {
        
        if let didPressAddToCartAction =  didPressAddToCartAction {
            didPressAddToCartAction()
        }
        
    }
    
}
