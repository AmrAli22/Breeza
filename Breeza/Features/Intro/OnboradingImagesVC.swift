//
//  OnboradingImagesVC.swift
//  Breeza
//
//  Created by Amr Ali on 11/01/2024.
//

import UIKit

class OnboradingImagesVC: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var  scrollView  : UIScrollView!
    @IBOutlet weak var  pageControl : UIPageControl!
    @IBOutlet weak var  nextButton  : UIButton!

    let imageNames = ["OnboradingOne", "OnboradingTwo", "OnboradingThree"] // Replace with your actual image names
    var currentPageIndex = 0

    public class func buildVC() -> OnboradingImagesVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "OnboradingImagesVC") as! OnboradingImagesVC
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        setupPageControl()
        setupNextButton()
    }

    func setupScrollView() {
        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(imageNames.count), height: view.bounds.height)

        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * view.bounds.width - 20 , y: 0, width: view.bounds.width - 20 , height: view.bounds.height * 0.8))
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .center
            scrollView.addSubview(imageView)
        }

      
    }

    func setupPageControl() {
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black

        let pageControlSize = pageControl.size(forNumberOfPages: imageNames.count)
        let pageControlX = (view.bounds.width - pageControlSize.width) / 2
        let pageControlY = view.bounds.height - pageControlSize.height - 20

        pageControl.frame = CGRect(x: pageControlX, y: pageControlY, width: pageControlSize.width, height: pageControlSize.height)

        
    }

    func setupNextButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func nextButtonTapped() {
        currentPageIndex += 1

        if currentPageIndex < imageNames.count {
            let contentOffsetX = CGFloat(currentPageIndex) * view.bounds.width
            scrollView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
            pageControl.currentPage = currentPageIndex
        } else {
            // Navigate to another view when the last image is reached
            navigateToAnotherView()
        }
    }

    func navigateToAnotherView() {
        self.navigationController?.pushViewController(StartVC.buildVC(), animated: true)
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.bounds.width)
        pageControl.currentPage = Int(pageIndex)
        currentPageIndex = Int(pageIndex)
    }
}
