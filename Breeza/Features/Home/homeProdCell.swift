//
//  homeProdCell.swift
//  Breeza
//
//  Created by Amr Ali on 17/01/2024.
//

import UIKit

class homeProdCell: UICollectionViewCell {

    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var numOfPicesForExpiredSoon: UILabel!
    @IBOutlet weak var ExpiredInStack: UIStackView!
    @IBOutlet weak var expiredSoonDays: UILabel!
    @IBOutlet weak var numOfPicesForLowestStock: UILabel!
    @IBOutlet weak var ProdCost: UILabel!
    
    var isLowestStock = false
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUi() {
        numOfPicesForExpiredSoon.isHidden = isLowestStock
        ExpiredInStack.isHidden = isLowestStock
        numOfPicesForLowestStock.isHidden = !isLowestStock
    }

}

