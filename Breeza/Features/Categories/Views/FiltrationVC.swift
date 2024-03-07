//
//  FiltrationVC.swift
//  Breeza
//
//  Created by Amr Ali on 04/03/2024.
//

import UIKit

class FiltrationVC: BaseVC {
    @IBOutlet weak var tableView: UITableView!
    
    public class func buildVC() -> FiltrationVC {
        let storyboard = UIStoryboard(name: "CategoriesStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "FiltrationVC") as! FiltrationVC

        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate   = self
        tableView.dataSource = self
        
        let Headernib = UINib(nibName: "HomeSectionHeaderView", bundle: nil)
        tableView.register(Headernib, forHeaderFooterViewReuseIdentifier: "HomeSectionHeaderView")
        
        let nibHomeTableViewCell = UINib(nibName: "FiltrationCell", bundle: nil)
        tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "FiltrationCell")
        
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension FiltrationVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiltrationCell", for: indexPath) as! FiltrationCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.labelTxt.text = "Quantity Low to High"
            case 1:
                cell.labelTxt.text = "Quantity High to low"
            default:
                cell.labelTxt.text = "Expiry Date"
            }
        default:
            cell.labelTxt.text = "Section \(indexPath.row)"
        }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let view = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeSectionHeaderView")  as! HomeSectionHeaderView
        if section == 0 {
            view.headerTitle.text = "Sort"
        }else if section == 1 {
            view.headerTitle.text = "Categories"
        }else if section == 2{
            view.headerTitle.text = "Brands"
        }else{
            view.headerTitle.text = "Suppliers"
        }
        view.seeAllBtn.isHidden = true
            return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
}
