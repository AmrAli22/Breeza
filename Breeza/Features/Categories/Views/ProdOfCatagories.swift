//
//  ProdOfCatagories.swift
//  Breeza
//
//  Created by Amr Ali on 13/02/2024.
//

import UIKit

class ProdOfCatagories: BaseVC, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLoading: Bool = false

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
        self.presenter.FilterProducts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        self.presenter.FilterProducts()
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
