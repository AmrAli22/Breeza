//
//  SearchableDataVC.swift
//  Breeza
//
//  Created by Amr Ali on 28/02/2024.
//

import UIKit

class SearchableDataVC: BaseVC, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var isLoading: Bool = false
    var currentSearch = ""
    
    var presenter                : homePresenter!
    
    var debounceTimer: Timer?
    
    public class func buildVC(pres :homePresenter) -> SearchableDataVC {
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SearchableDataVC") as! SearchableDataVC
            pres.homeView = view
            view.presenter = pres
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.homeView = self
    }
    
    func setupUI() {
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        // Setup other UI configurations as needed
        let ProdOfCatogriesCollectionsCellCellnib = UINib(nibName: "ProdOfCatogriesCollectionsCell", bundle: nil)
        collectionView.register(ProdOfCatogriesCollectionsCellCellnib, forCellWithReuseIdentifier: "ProdOfCatogriesCollectionsCell" )
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.title = " "
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = .clear
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .clear
        searchBar.returnKeyType = .default
       }

       // MARK: - UISearchBarDelegate

       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           // This method is called when the user taps the return key on the keyboard
           // Add your custom return key action here
           print("Return key clicked")

           // Close the keyboard
           searchBar.resignFirstResponder()
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounceTimer?.invalidate()
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self]  _ in
            guard let self = self else{return}
            self.presenter.resetSearch()
            self.currentSearch = searchText
            self.fetchDataFromAPI(searchText)
        }
    }
    
    func fetchDataFromAPI(_ searchText: String) {
        self.presenter.GetSearchableData(searchKey: searchText)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.SearchableItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdOfCatogriesCollectionsCell", for: indexPath) as! ProdOfCatogriesCollectionsCell
        
        let currentItem = presenter.SearchableItems[indexPath.row]
        
        cell.prodName.text = currentItem.productName
        cell.prodCost.text =  "$" + " " + "\(currentItem.purchasePrice ?? 0)"
        cell.companyname.text = currentItem.brand?.name
        cell.stockNumberOfpices.text = "Stock - \(currentItem.quantity ?? 0) pcs"
        
        
        if indexPath.row == presenter.SearchableItems.count - 1  && !isLoading {
            self.presenter.GetSearchableData(searchKey: currentSearch)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeWidth = (collectionView.bounds.width / 2 ) - 20
        return CGSize(width: sizeWidth  , height: 200)
    }
    
    // Other UICollectionViewDelegateFlowLayout methods can be implemented as needed
}

extension SearchableDataVC : homeView {
    func SuccessSearchableContent() {
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
    
    func SuccessLowestStockHome() {}
    func SuccessExpiredSoon() {}
}
