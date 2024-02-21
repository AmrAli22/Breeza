//
//  CategorisPresenter.swift
//  Breeza
//
//  Created by Amr Ali on 21/02/2024.
//

import Foundation

protocol CategorisView: AnyObject {
    func showSpinner()
    func hideSpinner()
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)
    func SuccessGetCatogris()
    func SuccessGetBrands()
    func SuccessGetSuppliers()
}

//MARK: - AuthPresenter
class CategorisPresenter {
    
    //MARK: - PresenterView
    weak var categorisView: CategorisView?

    //MARK: - homeInteractor
    let categorisInteractor = CategorisInteractor()
    
    var categorisItems = [CategorisModelElement]()
    var suppliersItems = [SuppliersModelElement]()
    var brandsItems    = [BrandsModelElement]()
    
    //MARK: - PresenterConstractours
    init(categorisView: CategorisView ) {
        self.categorisView = categorisView
    }
    
    //MARK: - GetLowestStock
    func getCatogris(){
        self.categorisView?.showSpinner()
        
        categorisInteractor.GetCategoris { [weak self ] (catgsItems, error) in

            guard let self = self else { return }
            self.categorisView?.hideSpinner()
            
            if let _ = error {
                self.categorisView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            
            self.categorisItems          = catgsItems ?? [CategorisModelElement]()
            self.categorisView?.SuccessGetCatogris()
            return
        }
    }
    
    
    func getSuppliers(){
        self.categorisView?.showSpinner()
        
        categorisInteractor.GetSuppliers { [weak self ] (SuppliersItems, error) in

            guard let self = self else { return }
            self.categorisView?.hideSpinner()
            
            if let _ = error {
                self.categorisView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            
            self.suppliersItems          = SuppliersItems ?? [SuppliersModelElement]()
            self.categorisView?.SuccessGetSuppliers()
            return
        }
    }
    
    
    
    func getBrands(){
        self.categorisView?.showSpinner()
        
        categorisInteractor.GetBrands { [weak self ] (BrandsItems, error) in

            guard let self = self else { return }
            self.categorisView?.hideSpinner()
            
            if let _ = error {
                self.categorisView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            
            self.brandsItems          = BrandsItems ?? [BrandsModelElement]()
            self.categorisView?.SuccessGetBrands()
            return
        }
    }
    

}
