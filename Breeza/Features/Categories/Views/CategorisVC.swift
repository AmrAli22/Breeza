//
//  CategorisVC.swift
//  Breeza
//
//  Created by Amr Ali on 11/02/2024.
//

import UIKit

class CategorisVC: UIViewController, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let catogiresData = ["General", "Lungs Specialist", "Dentist", "Psychiatrist" , "Covid-19" , "Surgeon" , "Cardiologist" , "Show all"]
    
    let suppliersData = ["Michael LLC" , "Christopher" , "Willy" , "Jack" , "Christopher" , "Willy" , "Jack" , "Show all"]

    public class func buildVC() -> CategorisVC {
        let storyboard = UIStoryboard(name: "CategoriesStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CategorisVC") as! CategorisVC
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
 
        let CategorisCollectionCellnib = UINib(nibName: "CategorisCollectionCell", bundle: nil)
        collectionView.register(CategorisCollectionCellnib, forCellWithReuseIdentifier: "CategorisCollectionCell" )
        
//        collectionView.register(MyHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeaderCollectionReusableView")
        collectionView.register(MyHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerReuseIdentifier")


        
    }
    
    // MARK: - TableView DataSource and Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // MARK: - CollectionView DataSource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return catogiresData.count
        }else{
            return suppliersData.count
        }
    }
    
    // UICollectionViewDataSource method to provide the view for the header
        
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            if kind == UICollectionView.elementKindSectionHeader {
                // Dequeue the header view
                let headerXView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerReuseIdentifier", for: indexPath) as! MyHeaderCollectionView

                if indexPath.section == 0 {
                    headerXView.titleLabel.text = "Browse by category"
                }else{
                    headerXView.titleLabel.text = "Browse by Supplier"
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
            cell.cellText.text = catogiresData[indexPath.row]
        }else{
            cell.Cellimage.image = UIImage(named: "fi-rs-building")
            cell.cellText.text = suppliersData[indexPath.row]
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
        
        return CGSize(width: sizeWidth  , height: 100)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0.0 // You can adjust this value
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
