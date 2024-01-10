//
//  UIViewController+Additions.swift
//  inSchool
//
//  Created by MohamedKhalid on 3/9/19.
//  Copyright © 2019 Mohamed Khalid. All rights reserved.
//

import UIKit
import Localize_Swift
import UIKit
import Localize_Swift
import AVFoundation
import Photos
import MobileCoreServices

extension UIViewController{
    //pops up an alert window
    
    func showAlert(title:String, withMessage message:String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok".localized(), style: .default, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    }
    func showAlert(title:String, withMessage message:String, completion: (() -> Void)?, alertTitle: String? = "Ok") -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: alertTitle?.localized(), style: .default) { _ in
            completion?()
        }
       
        alert.addAction(dismissAction)
        self.present(alert, animated: true)
    }
    
    
    func embed(_ viewController:UIViewController, inParent controller:UIViewController, inView view:UIView){
        viewController.willMove(toParent: controller)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        controller.addChild(viewController)
        viewController.didMove(toParent: controller)
    }
    
    func removeEmbedFromView() {
           guard parent != nil else { return }

         willMove(toParent: nil)
        removeFromParent()
           view.removeFromSuperview()
       }
    
    func setUpBackButton(){
               if Localize.currentLanguage() == "en" {

                    let backButton = UIBarButtonItem(image:#imageLiteral(resourceName: "icOpen") , style: .done, target: self, action: #selector(closeVC))
                   self.navigationItem.backBarButtonItem = backButton
                   
               }else{
                   let backButton = UIBarButtonItem(image:#imageLiteral(resourceName: "abBack") , style: .done, target: self, action: #selector(closeVC))
                   self.navigationItem.backBarButtonItem = backButton
                
               }
           }
    
    @objc  func closeVC(){
          navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
      }
    
    open func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = cancelTouches
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboardWhenClick() {
        self.view.addTapGesture { [weak self] recognizer in
            self?.dismissKeyboard()
        }
    }
    
    //EZSE: Dismisses keyboard
    @objc open func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK:- IMAGE CONTROLLER ALERT
    public func openPickerController(title: String = "", message: String = "", with imagePicker: UIImagePickerController, sourceRect: UIButton) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.checkCamera(imagePicker: imagePicker, sourceRect: sourceRect)
            }
            alertController.addAction(cameraAction)
        }
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
               self.checkPhotoLibrary(imagePicker: imagePicker, sourceRect: sourceRect)
            }
            alertController.addAction(photoLibraryAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = sourceRect
        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
        present(alertController, animated: true, completion: nil)
    }
  
    private func checkCamera(imagePicker: UIImagePickerController, sourceRect: UIButton) {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if (status == .authorized) {
            DispatchQueue.main.async {
                self.displayPicker(imagePicker: imagePicker, of: .camera)
            }
        }
        if (status == .restricted) {
            self.handleRestricted(sourceRect: sourceRect)
        }
        if (status == .denied) {
            self.handleDenied(sourceRect: sourceRect)
        }
        if (status == .notDetermined) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted {
                    DispatchQueue.main.async {
                        self.displayPicker(imagePicker: imagePicker, of: .camera)
                    }
                }
            })
        }
    }
    
    private func checkPhotoLibrary(imagePicker: UIImagePickerController, sourceRect: UIButton) {
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == .authorized) {
            DispatchQueue.main.async {
                self.displayPicker(imagePicker: imagePicker, of: .photoLibrary)
            }
        }
        if (status == .restricted) {
            self.handleRestricted(sourceRect: sourceRect)
        }
        if (status == .denied) {
            self.handleDenied(sourceRect: sourceRect)
        }
        if (status == .notDetermined) {
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == PHAuthorizationStatus.authorized
                {
                    DispatchQueue.main.async {
                        self.displayPicker(imagePicker: imagePicker, of: .photoLibrary)
                    }
                }
            })
        }
    }
    //MARK:- private functions
    private func handleDenied(sourceRect: UIButton) {
        let alertController = UIAlertController(title: "Media Access Denied", message: "trips doesn't have access to use your device's media. please update you settings", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Go To Settings", style: .default) { (action) in
            DispatchQueue.main.async {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
        alertController.popoverPresentationController?.sourceView = sourceRect
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func handleRestricted(sourceRect: UIButton) {
        let alertController = UIAlertController(title: "Media Access Denied", message: "This device is restricted from accessing any media at this time", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok".localized(), style: .default, handler: nil)
        alertController.popoverPresentationController?.sourceRect = sourceRect.bounds
        alertController.popoverPresentationController?.sourceView = sourceRect
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    private func displayPicker(imagePicker: UIImagePickerController, of type: UIImagePickerController.SourceType, mediaTypes: [String] = [(kUTTypeImage as String)]) {
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: type)!
        imagePicker.mediaTypes = mediaTypes // the default value is kUTTypeImage ..
        imagePicker.sourceType = type
        imagePicker.allowsEditing = true
        DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}
