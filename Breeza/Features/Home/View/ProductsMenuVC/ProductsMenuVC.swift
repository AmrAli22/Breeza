//
//  ProductsMenuVC.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.
//

import UIKit

class ProductsMenuVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pageTitle: UILabel!
    var presenter                 : homePresenter!
    var isLowestItem              = true
    
    var currentPage: Int = 0

    var isLoading: Bool = false
    
    public class func buildVC(presenter : homePresenter , isLowestItem : Bool) -> ProductsMenuVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ProductsMenuVC") as! ProductsMenuVC
        presenter.homeView = view
        view.presenter = presenter
        view.isLowestItem = isLowestItem
        view.currentPage = isLowestItem ? presenter.currentlowestStockPage : presenter.currentexpiredSoonPage
        return view
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        
        let nibHomeTableViewCell = UINib(nibName: "ProductsMenuTableViewCell", bundle: nil)
        tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "ProductsMenuTableViewCell")
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .clear
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .clear
        
        
        pageTitle.text = isLowestItem ? "Lowest Stock" : "Expired soon"
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator   = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.homeView = self
    }
    
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ProductsMenuVC : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLowestItem ? self.presenter.lowestStockItems.count : self.presenter.expiredSoonItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsMenuTableViewCell", for: indexPath) as! ProductsMenuTableViewCell
        
        let currentItem = isLowestItem ? self.presenter.lowestStockItems[indexPath.row] : self.presenter.expiredSoonItems[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.prodName.text = currentItem.productName
        cell.prodCost.text = "\(currentItem.purchasePrice ?? 0)" + " " + "$"
        cell.prodPcs.text  = "\(currentItem.quantity ?? 0)" + " " + "PCS"
        
        
        cell.didPressAddToCartAction = { [weak self] () in
            guard let self = self else { return  }
            self.navigationController?.pushViewController(chooseSupplierVC.buildVC() , animated: true)
        }
        
        
        if isLowestItem {
            if indexPath.row == presenter.lowestStockItems.count - 1 && !isLoading {
                self.presenter.getLowestStockHomeProducts() }
        }else{
            
            if indexPath.row == presenter.expiredSoonItems.count - 1 && !isLoading { self.presenter.getexpiredSoonHomeProducts() }
        }
        
        
        
        return cell
    }
    
    
    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        if isLowestItem {
            self.presenter.getLowestStockHomeProducts()
        }else{
            self.presenter.getexpiredSoonHomeProducts()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ProductsMenuVC :homeView {
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
        isLoading = false
    }
    
    func SuccessExpiredSoon() {
        
        self.tableView.reloadData()
        isLoading = false
    }
}
