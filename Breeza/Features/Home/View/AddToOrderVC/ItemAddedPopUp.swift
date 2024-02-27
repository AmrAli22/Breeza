//
//  ItemAddedPopUp.swift
//  Breeza
//
//  Created by Amr Ali on 29/01/2024.
//

import UIKit

class ItemAddedPopUp: UIViewController {

    @IBOutlet weak var popUpTitle: UILabel!
    @IBOutlet weak var popUpDesc: UILabel!
    @IBOutlet weak var BtnConfrimText: UIButton!
    
    var didPressInfoBtnAction     : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        if let didPressInfoBtnAction = didPressInfoBtnAction {
            didPressInfoBtnAction()
        }
    }
    
}
