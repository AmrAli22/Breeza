

import UIKit
import PDFKit

class PDFWebViewController: UIViewController {
    var pdfURL: URL!
    
    private var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
                
        self.setPDFView()
        self.fetchPDF()
    }
    
    private func setPDFView() {
        DispatchQueue.main.async {
            self.pdfView = PDFView(frame: self.view.bounds)
            
            self.pdfView.maxScaleFactor = 3;
            self.pdfView.minScaleFactor = self.pdfView.scaleFactorForSizeToFit;
            self.pdfView.autoScales = true;
            self.pdfView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            self.view.addSubview(self.pdfView)
        }
    }
    
    private func fetchPDF() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: self.pdfURL), let document = PDFDocument(data: data) {
                DispatchQueue.main.async {
                    self.pdfView.document = document
                    self.addShareBarButton()
                }
            }
        }
    }
    
    private func addShareBarButton() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                            target: self,
                                            action: #selector(self.presentShare))
        barButtonItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func presentShare() {
        guard let pdfDocument = self.pdfView.document?.dataRepresentation() else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [pdfDocument], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        self.present(activityViewController, animated: true)
    }
}


//import UIKit
//import Kingfisher
//
//class ImagePopupViewController: UIViewController {
//    
//    private var imageUrl: URL?
//    
//    convenience init(imageUrl: URL) {
//        self.init()
//        self.imageUrl = imageUrl
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//        loadImage()
//    }
//    
//    private func setupViews() {
//        view.backgroundColor = .black
//        
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(imageView)
//        
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            imageView.topAnchor.constraint(equalTo: view.topAnchor),
//            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissImage))
//        view.addGestureRecognizer(tapGesture)
//    }
//    
//    private func loadImage() {
//        guard let imageUrl = imageUrl else { return }
//        
//        // Use Kingfisher for asynchronous image loading
//        imageView.kf.setImage(with: imageUrl)
//    }
//
//    @objc private func dismissImage() {
//        dismiss(animated: true, completion: nil)
//    }
//}
