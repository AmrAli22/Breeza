//
//  SelectOrderVC.swift
//  Breeza
//
//  Created by Amr Ali on 29/01/2024.
//

import UIKit

class SelectOrderVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
        public class func buildVC() -> SelectOrderVC {
            let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "SelectOrderVC") as! SelectOrderVC
            return view
        }
        
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate   = self
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.navigationBar.topItem?.title = " "
            self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .clear
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .clear

            let nibHomeTableViewCell = UINib(nibName: "OrderTableViewCell", bundle: nil)
            tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "OrderTableViewCell")
        }
    
    @IBAction func didPressSelectedOreder(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        if let popupVC = storyboard.instantiateViewController(withIdentifier: "ItemAddedPopUp") as? ItemAddedPopUp {
            present(popupVC, animated: true, completion: nil)
        }
    }
    
    }

    extension SelectOrderVC : UITableViewDelegate ,UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 9
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
                cell.selectionStyle = .none
            return cell
        }

        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 75
        }
    }



