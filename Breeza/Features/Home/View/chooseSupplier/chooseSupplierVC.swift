//
//  chooseSupplierVC.swift
//  Breeza
//
//  Created by Amr Ali on 03/03/2024.
//

import UIKit

class chooseSupplierVC: BaseVC {

    @IBOutlet weak var tableView : UITableView!
    var presenter                : homePresenter!
    
    public class func buildVC() -> chooseSupplierVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "chooseSupplierVC") as! chooseSupplierVC
        let pres = homePresenter(homeView: view)
            view.presenter = pres
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.homeView = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self

        let nibHomeTableViewCell = UINib(nibName: "selectSupplier", bundle: nil)
        tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "selectSupplier")
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .clear
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .clear

        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator   = false
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
 
    
    @IBAction func logout(_ sender: Any) {
        
        UserDefaultsManager.instance.RemoveCurrentToken()
        AppDelegate.instance?.goToOnboarding()
        
    }
    
}

extension chooseSupplierVC : UITableViewDelegate ,UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectSupplier", for: indexPath) as! selectSupplier

            
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.bestDealView.isHidden = false
                cell.outerView.borderColor = UIColor(hex: "#34A853")
            }else{
                cell.bestDealView.isHidden = true
                cell.outerView.borderColor = UIColor(hex: "#E8F3F1")
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AddToOrderVC.buildVC() , animated: true)
    }
    
}

extension chooseSupplierVC : homeView {
    func SuccessSearchableContent() {
        
    }
    
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

