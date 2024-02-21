//
//  CategorisVC.swift
//  Breeza
//
//  Created by Amr Ali on 11/02/2024.
//

import UIKit

class CategorisVC: BaseVC, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    var presenter                : CategorisPresenter!
    
    public class func buildVC() -> CategorisVC {
        let storyboard = UIStoryboard(name: "CategoriesStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CategorisVC") as! CategorisVC
        let pres = CategorisPresenter(categorisView: view)
            view.presenter = pres
        return view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.categorisView = self
        self.presenter.getSuppliers()
        self.presenter.getCatogris()
        self.presenter.getBrands()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
 
        let CategorisCollectionCellnib = UINib(nibName: "CategorisCollectionCell", bundle: nil)
        collectionView.register(CategorisCollectionCellnib, forCellWithReuseIdentifier: "CategorisCollectionCell" )
        collectionView.register(MyHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerReuseIdentifier")

  
        
    }
    
    // MARK: - TableView DataSource and Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    // MARK: - CollectionView DataSource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.presenter.categorisItems.count
        }else if section == 1{
            return self.presenter.suppliersItems.count
        }else{
            return self.presenter.brandsItems.count
        }
    }
    
    // UICollectionViewDataSource method to provide the view for the header
        
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            if kind == UICollectionView.elementKindSectionHeader {
                // Dequeue the header view
                let headerXView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerReuseIdentifier", for: indexPath) as! MyHeaderCollectionView

                if indexPath.section == 0 {
                    headerXView.titleLabel.text = "Browse by category"
                }else if indexPath.section == 1{
                    headerXView.titleLabel.text = "Browse by Supplier"
                }else{
                    headerXView.titleLabel.text = "Browse by Brands"
                }

                return headerXView
            }

            return UICollectionReusableView()
        }

        // UICollectionViewDelegateFlowLayout method to set the size of the header
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50) // Adjust the height as needed
        }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategorisCollectionCell", for: indexPath) as! CategorisCollectionCell
        
        if indexPath.section == 0 {
            cell.Cellimage.image = UIImage(named: "Doctor")
            cell.cellText.text   = self.presenter.categorisItems[indexPath.row].name
        }else if indexPath.section == 1 {
            cell.Cellimage.image = UIImage(named: "fi-rs-building")
            cell.cellText.text   = self.presenter.suppliersItems[indexPath.row].name
        }else{
            cell.Cellimage.image = UIImage(named: "fi-rs-building")
            cell.cellText.text   = self.presenter.brandsItems[indexPath.row].name
        }
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProdOfCatagories.buildVC(), animated: true)
    }
    
    // MARK: - CollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Add some padding to the cell size
        let sizeWidth = (collectionView.bounds.width / 4 )
        print("CollectionWidth = \(collectionView.bounds.width )")
        print("CellWidth = \((collectionView.bounds.width / 4 ) )")
        
        return CGSize(width: sizeWidth  , height: 120)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0 // You can adjust this value
       }

       // Set the spacing between sections
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // You can adjust these values
       }
    
}

class MyHeaderCollectionView: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Add the label to the header view
        addSubview(titleLabel)

        // Set up constraints for the label
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategorisVC : CategorisView {
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
