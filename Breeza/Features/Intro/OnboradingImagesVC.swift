import UIKit

class OnboradingImagesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!

    let imageNames = ["OnboradingOne", "OnboradingTwo", "OnboradingThree"]
    var currentPageIndex = 0

    public class func buildVC() -> OnboradingImagesVC {
        let storyboard = UIStoryboard(name: "OnboardingStoryboard", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "OnboradingImagesVC") as! OnboradingImagesVC
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupPageControl()
        setupNextButton()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
    }

    func setupPageControl() {
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
    }

    func setupNextButton() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)

        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.image = UIImage(named: imageNames[indexPath.item])
        imageView.contentMode = .scaleAspectFill

        cell.contentView.addSubview(imageView)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    // MARK: - Actions

    @objc func nextButtonTapped() {
        currentPageIndex += 1

        if currentPageIndex < imageNames.count {
            let indexPath = IndexPath(item: currentPageIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPageIndex
        } else {
            navigateToAnotherView()
        }
    }

    func navigateToAnotherView() {
        self.navigationController?.pushViewController(StartVC.buildVC(), animated: true)
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / collectionView.bounds.width)
        pageControl.currentPage = Int(pageIndex)
        currentPageIndex = Int(pageIndex)
    }
}
