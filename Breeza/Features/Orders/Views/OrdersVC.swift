//
//  OrdersVC.swift
//  Breeza
//
//  Created by Amr Ali on 30/01/2024.
//

import UIKit

class OrdersVC: BaseVC, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var collectionView: UICollectionView!

   
        let collectionData = ["All", "Open", "Pending", "Completed"]

        // Currently selected item in CollectionView
        var selectedCollectionIndex: IndexPath?

    public class func buildVC() -> OrdersVC {
        let storyboard = UIStoryboard(name: "OrdersStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        return view
    }
    
    
        override func viewDidLoad() {
            super.viewDidLoad()

            // Set delegates and data sources
            tableView.delegate = self
            tableView.dataSource = self

            collectionView.delegate = self
            collectionView.dataSource = self

    
            let nibHomeTableViewCell = UINib(nibName: "OrdersPageTableViewCell", bundle: nil)
            tableView.register(nibHomeTableViewCell, forCellReuseIdentifier: "OrdersPageTableViewCell")

            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            let HomeArticleCollectioViewCellnib = UINib(nibName: "ordersTypeHomeCollectionCell", bundle: nil)
            collectionView.register(HomeArticleCollectioViewCellnib, forCellWithReuseIdentifier: "ordersTypeHomeCollectionCell" )
        }

        // MARK: - TableView DataSource and Delegate

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 7
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let  OrdersPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrdersPageTableViewCell" , for: indexPath) as! OrdersPageTableViewCell
            OrdersPageTableViewCell.selectionStyle = .none
            return OrdersPageTableViewCell
        }

        // MARK: - CollectionView DataSource and Delegate

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return collectionData.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ordersTypeHomeCollectionCell", for: indexPath) as! ordersTypeHomeCollectionCell
       
            cell.clipsToBounds = true
            cell.TabName.text = collectionData[indexPath.item]
            
      
            let blueColor = UIColor(hex: "#3365A6")

            // Change color if the cell is selected
            if selectedCollectionIndex == indexPath {
                cell.textView.backgroundColor   = blueColor
                cell.TabName.textColor         = UIColor.white
            } else {
                cell.textView.backgroundColor   = UIColor(hex: "#FBFBFB")
                cell.TabName.textColor         = UIColor.black
            }

            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedCollectionIndex = indexPath
            collectionView.reloadData()

            // Do something when a CollectionView cell is selected
            print("Selected: \(collectionData[indexPath.item])")
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

        // MARK: - CollectionViewFlowLayout Delegate

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel()
            label.text = collectionData[indexPath.item]
            label.sizeToFit()

            // Add some padding to the cell size
            return CGSize(width: label.frame.width + 40, height: 40)
        }
    }
