//
//  MainTabBarVC.swift
//  BunyBox
//
//  Created by sayed abdo on 21/09/2023.
//
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    // MARK: - Factory Method
    
    /// Factory method to instantiate MainTabBarVC from the storyboard.
    /// - Returns: An instance of MainTabBarVC.
    public class func buildVC() -> MainTabBarVC {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MainTabBarVC") as! MainTabBarVC
    }
    
    // MARK: - Properties
    
    /// The default selected tab item index.
    public var selectedTabItemIndex = 0
    
    /// Names of tab bar images.
    private let tabBarImagesNames = ["Home",  "Categories" , "orders" ]
    
    /// Names of selected tab bar images.
    private let selectedTabBarImagesNames = ["HomeBlue",  "CategoriesBlue" ,"ordersBlue" ]
    
    /// Localized titles for tab bar items.
    private let tabBarTitles = ["Home",  "Categories" , "Orders" ]
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startViewControllers()
        customizeTabBar()
        self.selectedIndex = selectedTabItemIndex
    }
    
    // MARK: - Customization
    
    /// Customize the appearance of the tab bar.
    private func customizeTabBar() {
        self.tabBar.barTintColor = UIColor.white
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = UIColor.white
        tabBar.tintColor = #colorLiteral(red: 0.2, green: 0.3960784314, blue: 0.6509803922, alpha: 1)
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        tabBar.itemWidth = 120
        
        // Set images and titles for tab bar items
        for (index, item) in self.tabBar.items!.enumerated() {
            item.image = UIImage(named: tabBarImagesNames[index])
            item.selectedImage = UIImage(named: selectedTabBarImagesNames[index])
            item.title = tabBarTitles[index]
        }
    }
    
    /// Create and set view controllers for the tab bar.
    private func startViewControllers() {
        let homeVC      = HomeVC.buildVC()
        let ordersVC    = OrdersVC.buildVC()
        let catogriesVC = CategorisVC.buildVC()
       
        
        self.viewControllers = [homeVC, catogriesVC, ordersVC]
    }
    
    // MARK: - Tab Bar Delegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
    }

}


extension UIViewController {
    func scrollToTop() {
        func scrollToTop(view: UIView?) {
            guard let view = view else { return }

            switch view {
            case let scrollView as UIScrollView:
                if scrollView.scrollsToTop == true {
                    scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
                    return
                }
            default:
                break
            }
            for subView in view.subviews {
                scrollToTop(view: subView)
            }
        }
        scrollToTop(view: self.view)
    }

}
