//
//  ProdOfCatagories.swift
//  Breeza
//
//  Created by Amr Ali on 13/02/2024.
//

import UIKit
import FittedSheets
class ProdOfCatagories: BaseVC, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isLoading: Bool = false
    var currentSearch = ""
    var debounceTimer: Timer?
    var presenter                : CategorisPresenter!

    public class func buildVC(pres : CategorisPresenter) -> ProdOfCatagories {
        let storyboard = UIStoryboard(name: "CategoriesStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ProdOfCatagories") as! ProdOfCatagories
        pres.categorisView = view
        view.presenter = pres
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let ProdOfCatogriesCollectionsCellCellnib = UINib(nibName: "ProdOfCatogriesCollectionsCell", bundle: nil)
        collectionView.register(ProdOfCatogriesCollectionsCellCellnib, forCellWithReuseIdentifier: "ProdOfCatogriesCollectionsCell" )
        
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .clear
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .clear
        self.presenter.FilterProducts(searchKey: "")
        searchBar.returnKeyType = .default
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.categorisView = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // This method is called when the user taps the return key on the keyboard
        // Add your custom return key action here
        print("Return key clicked")

        // Close the keyboard
        searchBar.resignFirstResponder()
    }
    @IBOutlet weak var openFiltersView: UIView!
    
    @IBAction func openFiltersAction(_ sender: Any) {
        
        let controller = FiltrationVC.buildVC()
        
        let useInlineMode = view != nil
        
        var options = SheetOptions()
        options.pullBarHeight = 30
        options.shouldExtendBackground = false
        options.useInlineMode = useInlineMode
        options.useFullScreenMode = false
        
        let sheet = SheetViewController(controller: controller, sizes: [.percent(0.7), .fullscreen], options: options)
        
        sheet.treatPullBarAsClear = true
        sheet.minimumSpaceAbovePullBar = 20
        sheet.cornerRadius = 30
        sheet.gripSize = CGSize(width: 100, height: 12)
        
        if let view = view {
            sheet.animateIn(to: view, in: self)
        } else {
            self.present(sheet, animated: true, completion: nil)
        }
    }
        
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self]  _ in
            guard let self = self else{return}
            self.presenter.resetData()
            self.currentSearch = searchText
            self.fetchDataFromAPI(searchText)
        }
    }
    
    func fetchDataFromAPI(_ searchText: String) {
        currentSearch = searchText
        self.presenter.FilterProducts(searchKey: searchText)
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CollectionView DataSource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.currentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdOfCatogriesCollectionsCell", for: indexPath) as! ProdOfCatogriesCollectionsCell

        let currentItem = presenter.currentItems[indexPath.row]
        
        cell.prodName.text = currentItem.productName
        cell.prodCost.text =  "$" + " " + "\(currentItem.purchasePrice ?? 0)"
        cell.companyname.text = currentItem.brand?.name
        cell.stockNumberOfpices.text = "Stock - \(currentItem.quantity ?? 0) pcs"
        
        
        if indexPath.row == presenter.currentItems.count - 1  && !isLoading {
               loadMoreData()
           }
        
        return cell
    }
    
    func loadMoreData() {
        guard !isLoading else { return }
        isLoading = true
        self.presenter.FilterProducts(searchKey: currentSearch)
    }
    

    // MARK: - CollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Add some padding to the cell size
        let sizeWidth = (collectionView.bounds.width / 2 ) - 20
        
        return CGSize(width: sizeWidth  , height: 200)
    }

}

extension ProdOfCatagories : CategorisView {
    func SuccessGetItems() {
        self.collectionView.reloadData()
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
    
    func SuccessGetCatogris() {
        self.collectionView.reloadData()
    }
    
    func SuccessGetBrands() {
        self.collectionView.reloadData()
    }
    
    func SuccessGetSuppliers() {
        self.collectionView.reloadData()
    }
    
    
}
