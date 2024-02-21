//
//  HomeTableViewCell.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var sectionName: UILabel!
    
    var Items = [HomeProductContent]() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var cellType = 0 {
        didSet {
            if cellType == 0 {
                self.sectionName.text = "Lowest stock Items"
            }else if cellType == 1 {
                self.sectionName.text = "Expired soon"
            }
        }
    }

    var didPressSeeAllAction     : (() -> Void)?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.delegate   = self
            
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout

            let homeProdCellnib = UINib(nibName: "homeProdCell", bundle: nil)
            collectionView.register(homeProdCellnib, forCellWithReuseIdentifier: "homeProdCell" )
            
            let HomeArticleCollectioViewCellnib = UINib(nibName: "ArticleCollectionViewCell", bundle: nil)
            collectionView.register(HomeArticleCollectioViewCellnib, forCellWithReuseIdentifier: "ArticleCollectionViewCell" )
            
        }
    }
    @IBAction func seeAllBtnPressed(_ sender: Any) {
        
        if let didPressSeeAllAction =  didPressSeeAllAction {
            didPressSeeAllAction()
        }        
    }
    
     override func awakeFromNib() {
         super.awakeFromNib()
     }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return Items.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeProdCell", for: indexPath) as! homeProdCell

         var currentItem = Items[indexPath.row]
         
         if cellType == 0 {
             cell.isLowestStock = true
             cell.numOfPicesForLowestStock.text = "\(currentItem.quantity ?? 0 )" + " " + "PCS"
         }else{
             cell.isLowestStock = false
             cell.numOfPicesForExpiredSoon.text = "\(currentItem.quantity ?? 0 )" + " " + "PCS"
         }

         cell.prodName.text = currentItem.productName
         cell.ProdCost.text = "\(currentItem.purchasePrice ?? 0)" + " " + "$"
      
         
         cell.updateUi()
         return cell
         
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: 140, height: 210)

      }
 }
