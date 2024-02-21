//
//  HomeSectionHeaderView.swift
//  Breeza
//
//  Created by Amr Ali on 20/02/2024.
//

import UIKit

class HomeSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    
    var didPressInfoBtnAction     : (() -> Void)?
    
    override func prepareForReuse() {
           super.prepareForReuse()
       
       }
    
    
    @IBAction func seeAllBtnPressed(_ sender: Any) {
   
        if let didPressInfoBtnAction = didPressInfoBtnAction {
            didPressInfoBtnAction()
        }
    }
}

