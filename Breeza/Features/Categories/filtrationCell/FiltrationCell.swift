//
//  FiltrationCell.swift
//  Breeza
//
//  Created by Amr Ali on 04/03/2024.
//

import UIKit

class FiltrationCell: UITableViewCell {

    @IBOutlet weak var labelTxt: UILabel!
    @IBOutlet weak var checkMarkBtn: UIButton!
    
    var cellChecked : Bool = true {
        didSet{
            if cellChecked {
                checkMarkBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            }else{
                checkMarkBtn.setImage(UIImage(systemName: "square"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkMarkBtnPressed(_ sender: Any) {
        cellChecked.toggle()
    }
    
}
