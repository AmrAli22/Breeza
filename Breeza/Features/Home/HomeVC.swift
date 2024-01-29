//
//  HomeVC.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    public class func buildVC() -> HomeVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self

        let nibHomeTableViewCell = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "HomeTableViewCell")
        
    }
}

extension HomeVC : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            cell.selectionStyle = .none
        cell.isLowestStockItems = indexPath.row == 0
        cell.isArticle          = indexPath.row == 2
 
        cell.didPressSeeAllAction = { [weak self] () in
            guard let self = self else { return  }
            self.navigationController?.pushViewController(ProductsMenuVC.buildVC() , animated: true)
            
        }
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 2 {
            return 120
        }else{
             return 240
        }
       
    }

}
