//
//  HomeVC.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var tableView : UITableView!
    var presenter                : homePresenter!
    
    
    public class func buildVC() -> HomeVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let pres = homePresenter(homeView: view)
            view.presenter = pres
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self

        let nibHomeTableViewCell = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.presenter.getexpiredSoonHomeProducts()
//        self.presenter.getLowestStockHomeProducts()

    }
    
   
}

extension HomeVC : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0  : return self.presenter.lowestStockItems.count
        case 1  : return self.presenter.expiredSoonItems.count
        default : return 2
        }
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

extension HomeVC : homeView {
    func showSpinner() {
        showLoader()
    }
    
    func hideSpinner() {
        hideLoader()
    }

    func FailureAlert(with error: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "Error".localized(), withMessage: error)
        }
    }
    
    func SuccessAlert(with msg: String) {
        
        DispatchQueue.main.async {
            self.showAlert(title: "Success".localized(), withMessage: "")
        }
    }
    
    func SuccessLowestStockHome() {
        self.tableView.reloadData()
    }
    
    func SuccessExpiredSoon() {
        self.tableView.reloadData()
    }
}
