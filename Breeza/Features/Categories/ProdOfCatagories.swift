//
//  ProdOfCatagories.swift
//  Breeza
//
//  Created by Amr Ali on 13/02/2024.
//

import UIKit

class ProdOfCatagories: BaseVC, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let prodData = ["General", "Lungs Specialist", "Dentist", "Psychiatrist" , "Covid-19" , "Surgeon" , "Cardiologist" , "Show all"]


    public class func buildVC() -> ProdOfCatagories {
        let storyboard = UIStoryboard(name: "CategoriesStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ProdOfCatagories") as! ProdOfCatagories
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
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - CollectionView DataSource and Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProdOfCatogriesCollectionsCell", for: indexPath) as! ProdOfCatogriesCollectionsCell
        return cell
    }
    

    // MARK: - CollectionViewFlowLayout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Add some padding to the cell size
        let sizeWidth = (collectionView.bounds.width / 2 ) - 20
        
        return CGSize(width: sizeWidth  , height: 200)
    }

}
