//
//  HomeTableViewCell.swift
//  Breeza
//
//  Created by Amr Ali on 28/01/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var sectionName: UILabel!
    
    var isLowestStockItems = false {
        didSet {
            self.sectionName.text = isLowestStockItems ? "Lowest stock Items" : "Expired soon"
        }
    }
    
    var isArticle = false
    
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
         
         self.sectionName.text = isLowestStockItems ? "Lowest stock Items" : "Expired soon"
         if isArticle {
             self.sectionName.text = "Health article"
         }
     }

     // UICollectionViewDataSource methods
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 11
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeProdCell", for: indexPath) as! homeProdCell
         let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as! ArticleCollectionViewCell
         
         if isArticle {
             return articleCell
         }else{
             cell.isLowestStock = self.isLowestStockItems
             cell.updateUi()
             return cell
         }
        
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        if isArticle  {
            
              let cellWidth = collectionView.bounds.width
              return CGSize(width: cellWidth, height: 100)
        }else{
    
              return CGSize(width: 140, height: 210)
        }
        
      }
    
 }
