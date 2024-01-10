//
//  TableView+Extension.swift
//  bravoStore
//
//  Created by mohamed ahmed on 1/23/20.
//  Copyright © 2020 Thimar Shops. All rights reserved.
//

import UIKit

extension UITableView {
func reloadWithAnimation() {
    self.reloadData()
    let cells = self.visibleCells
    let tableHeight: CGFloat = self.bounds.size.height
    for i in cells {
        let cell: UITableViewCell = i as UITableViewCell
        cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
    }
    var index = 0
    for c in cells {
        let cell: UITableViewCell = c as UITableViewCell
        UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0);
        }, completion: nil)
        index += 1
    }
}
}


extension UICollectionView {
    func reloadWithHorizontalAnimation() {
        self.reloadData()
        Utils.run(after: 0.001) {
            let cells = self.visibleCells
            let collectionWidth: CGFloat = self.bounds.size.width
            for i in cells {
                let cell: UICollectionViewCell = i as UICollectionViewCell
                cell.transform = CGAffineTransform(translationX: collectionWidth, y: 0)
            }
            var index = 0
            for c in cells {
                let cell: UICollectionViewCell = c as UICollectionViewCell
                UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
                    cell.transform = .identity
                }, completion: nil)
                index += 1
            }
        }
    }
    
    func reloadWithVerticalAnimation() {
        self.reloadData()
      
       
        Utils.run(after: 0.001) {
            let cells = self.visibleCells
            let collectionHeight: CGFloat = self.bounds.size.height
            for i in cells {
                let cell: UICollectionViewCell = i as UICollectionViewCell
                cell.transform = CGAffineTransform(translationX: 0, y: collectionHeight)
            }
            var index = 0
            for c in cells {
                let cell: UICollectionViewCell = c as UICollectionViewCell
                UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
                    cell.transform = .identity
                }, completion: nil)
                index += 1
            }
        }
    }
    
    func reloadWithDownScaleAnimation() {
        self.reloadData()
        Utils.run(after: 0.001) {
            let cells = self.visibleCells
            for i in cells {
                let cell: UICollectionViewCell = i as UICollectionViewCell
                cell.transform = CGAffineTransform(scaleX: 0, y: 0)
                //CGAffineTransform(translationX: 0, y: collectionHeight)
            }
            var index = 0
            for c in cells {
                let cell: UICollectionViewCell = c as UICollectionViewCell
                UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
                    cell.transform = .identity
                }, completion: nil)
                index += 1
            }
        }
    }
}
extension UICollectionView {
    
    func registerCellNib<Cell: UICollectionViewCell>(cellClass: Cell.Type){
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
}
