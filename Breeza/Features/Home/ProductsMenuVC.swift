//
//  ProductsMenuVC.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.
//

import UIKit

class ProductsMenuVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
        public class func buildVC() -> ProductsMenuVC {
            let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "ProductsMenuVC") as! ProductsMenuVC
            return view
        }
        
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate   = self
            
            self.navigationController?.isNavigationBarHidden = false

            let nibHomeTableViewCell = UINib(nibName: "ProductsMenuTableViewCell", bundle: nil)
            tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "ProductsMenuTableViewCell")


        }
    }

    extension ProductsMenuVC : UITableViewDelegate ,UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 9
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsMenuTableViewCell", for: indexPath) as! ProductsMenuTableViewCell
                cell.selectionStyle = .none
                cell.didPressAddToCartAction = { [weak self] () in
                    guard let self = self else { return  }
                    self.navigationController?.pushViewController(AddToOrderVC.buildVC() , animated: true)
            }
            return cell
        }

        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
    }
