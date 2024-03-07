//
//  HomeVC.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.

import UIKit

class HomeVC: BaseVC , UISearchBarDelegate {

    @IBOutlet weak var tableView : UITableView!
    var presenter                : homePresenter!
    
    public class func buildVC() -> HomeVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
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

        
        let Headernib = UINib(nibName: "HomeSectionHeaderView", bundle: nil)
        tableView.register(Headernib, forHeaderFooterViewReuseIdentifier: "HomeSectionHeaderView")
        
        let nibHomeTableViewCell = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "HomeTableViewCell")
        
        let nibHomeArticleCell = UINib(nibName: "ArticleHomeTableViewCell", bundle: nil)
        tableView.register(nibHomeArticleCell, forCellReuseIdentifier: "ArticleHomeTableViewCell")
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        self.presenter.getexpiredSoonHomeProducts()
        self.presenter.getLowestStockHomeProducts()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            // This method is called when the search bar becomes the first responder
            print("Search bar did begin editing")
        self.navigationController?.pushViewController(SearchableDataVC.buildVC(pres: self.presenter), animated: true)
            // Add your custom logic here
        }
    
    
    
    @IBAction func logout(_ sender: Any) {
        
        UserDefaultsManager.instance.RemoveCurrentToken()
        AppDelegate.instance?.goToOnboarding()
        
    }
    
}

extension HomeVC : UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 7
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                cell.selectionStyle = .none
            cell.cellType = indexPath.row
            cell.Items = self.presenter.expiredSoonItems
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                cell.selectionStyle = .none
            cell.cellType = indexPath.row
            cell.Items = self.presenter.lowestStockItems
            return cell
        }else{
            let Articlecell = tableView.dequeueReusableCell(withIdentifier: "ArticleHomeTableViewCell", for: indexPath) as! ArticleHomeTableViewCell
            Articlecell.selectionStyle = .none
            return Articlecell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
           return 70
        }else{
            return 240
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeSectionHeaderView")  as! HomeSectionHeaderView
        if section == 0 {
            view.headerTitle.text = "Lowest stock Items"
        }else if section == 1 {
            view.headerTitle.text = "Expired soon"
        }else{
            view.headerTitle.text = "Health article"
        }
        
        
        view.didPressInfoBtnAction = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(ProductsMenuVC.buildVC(presenter: self.presenter, isLowestItem: section == 0) , animated: true)
        }
            return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

extension HomeVC : homeView {
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
