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
    func SuccessGetItems()
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
    
    var currentItems = [HomeProductContent]()
    
    var selectedBrand    : Int?
    var selectedCat      : Int?
    var selectedSupplier : Int?
    
    var currentPage      : Int = 0
    var totalPages       : Int = 1
    
    
    //MARK: - PresenterConstractours
    init(categorisView: CategorisView ) {
        self.categorisView = categorisView
    }
    
    //MARK: - ResetData
    
    func resetData() {
        currentPage = 0
        totalPages  = 1
        
        selectedBrand    = nil
        selectedCat      = nil
        selectedSupplier = nil
        
        currentItems.removeAll()
        
    }
    
    
    
    
    //MARK: - GetLowestStock
    func getCatogrs(){
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
    

    //MARK: - GetLowestStock
    func FilterProducts(searchKey: String){
        self.categorisView?.showSpinner()
        
        categorisInteractor.GetFiltredProducts(selectedCatg: selectedCat, selectedBrand: selectedBrand, selectedSupplier: selectedSupplier, currentPage: currentPage, searchKey: searchKey) { [weak self ] (newItems, error) in

            guard let self = self else { return }
            self.categorisView?.hideSpinner()
            
            if let _ = error {
                self.categorisView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            self.currentItems.append(contentsOf: newItems?.content ?? [HomeProductContent]())
            self.currentPage = (newItems?.pageable?.pageNumber ?? 0) + 1
            self.totalPages  = newItems?.totalPages ?? 1
            self.categorisView?.SuccessGetItems()
            return
        }
    }
    
    
    
}
