//
//  HomePresenter.swift
//  Breeza
//
//  Created by Amr Ali on 11/02/2024.
//

import Foundation

protocol homeView: AnyObject {
    func showSpinner()
    func hideSpinner()
    func FailureAlert(with error: String)
    func SuccessAlert(with msg  : String)
    func SuccessLowestStockHome   ()
    func SuccessExpiredSoon       ()
    func SuccessSearchableContent ()
}

//MARK: - AuthPresenter
class homePresenter {
    
    //MARK: - PresenterView
    weak var homeView: homeView?

    //MARK: - homeInteractor
    let homeInteractor = HomeInteractor()
    
    var lowestStockItems = [HomeProductContent]()
    var expiredSoonItems = [HomeProductContent]()
    var SearchableItems  = [HomeProductContent]()
    
    var currentlowestStockPage: Int = 0
    var totallowestStockPages: Int = 1
    
    var currentexpiredSoonPage: Int = 0
    var totalexpiredSoonPages: Int = 1
    
    var currentSearchablePage: Int = 0
    var totalSearchablePages : Int = 1
    
    //MARK: - PresenterConstractours
    init(homeView: homeView ) {
        self.homeView = homeView
    }
    
    func resetSearch (){
        currentSearchablePage = 0
        totalSearchablePages  = 1
        self.SearchableItems.removeAll()
    }
    
    
    //MARK: - GetSearchableData
    func GetSearchableData(searchKey : String){
        self.homeView?.showSpinner()
        
        homeInteractor.GetHomeProducts(search: searchKey , homeProudctsType: 0, currentPage : currentSearchablePage ) { [weak self ] (SearchableData, error) in

            guard let self = self else { return }
            self.homeView?.hideSpinner()
            
            if let _ = error {
                self.homeView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            
            self.SearchableItems.append(contentsOf: SearchableData?.content ?? [HomeProductContent]())
            
            self.currentSearchablePage  = (SearchableData?.pageable?.pageNumber ?? 0) + 1
            self.totalSearchablePages   =  SearchableData?.totalPages ?? 1
            
            self.homeView?.SuccessSearchableContent()
            return
        }
    }
    
    //MARK: - GetLowestStock
    func getLowestStockHomeProducts(){
        self.homeView?.showSpinner()
        
        homeInteractor.GetHomeProducts(homeProudctsType: 0, currentPage : currentlowestStockPage ) { [weak self ] (LowestStockItems, error) in

            guard let self = self else { return }
            self.homeView?.hideSpinner()
            
            if let _ = error {
                self.homeView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            
            self.lowestStockItems.append(contentsOf: LowestStockItems?.content ?? [HomeProductContent]())
            
            self.currentlowestStockPage  = (LowestStockItems?.pageable?.pageNumber ?? 0) + 1
            self.totallowestStockPages   =  LowestStockItems?.totalPages ?? 1
            
            self.homeView?.SuccessLowestStockHome()
            return
        }
    }
    
    //MARK: - GetLowestStock
    func getexpiredSoonHomeProducts(){
        self.homeView?.showSpinner()
        
        homeInteractor.GetHomeProducts(homeProudctsType: 1, currentPage: currentexpiredSoonPage) { [weak self ] (expiredSoonItems, error) in

            guard let self = self else { return }
            self.homeView?.hideSpinner()
            
            if let _ = error {
                self.homeView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            self.expiredSoonItems.append(contentsOf: expiredSoonItems?.content ?? [HomeProductContent]())
           // = expiredSoonItems?.content ?? [HomeProductContent]()
            self.currentexpiredSoonPage = (expiredSoonItems?.pageable?.pageNumber ?? 0) + 1
            self.totalexpiredSoonPages  = expiredSoonItems?.totalPages ?? 1
            self.homeView?.SuccessExpiredSoon()
            return
        }
    }
    
    
}
