//
//  AddToOrderVC.swift
//  Breeza
//
//  Created by Amr Ali on 29/01/2024.
//

import UIKit

class AddToOrderVC: UIViewController {
    
    @IBOutlet weak var AlertLabel: UILabel!
    @IBOutlet weak var numOfPicesTxtField: UITextField!
    
    public class func buildVC() -> AddToOrderVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "AddToOrderVC") as! AddToOrderVC
        return view
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        numOfPicesTxtField.delegate = self
    }
    @IBAction func addToOrderPressed(_ sender: Any) {
        
        self.navigationController?.pushViewController(SelectOrderVC.buildVC(), animated: true)
        
    }
}

extension AddToOrderVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // This method is called for each text change in the text field

           // Update your logic based on the new text
           let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""

           // Call a method or perform any actions based on the updated text
        
        let numOfPices = Int(newText) ?? 0
           handleTextChanged(numOfPices)

           // Return true if the text change should be applied, false if you want to reject the change
           return true
       }

       // Custom method to handle text changes
       func handleTextChanged(_ numOfPices: Int) {
        
           AlertLabel.isHidden = numOfPices >= 2
           
       }
    
    
}



