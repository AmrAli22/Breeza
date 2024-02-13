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
    func SuccessLowestStockHome ()
    func SuccessExpiredSoon     ()
}

//MARK: - AuthPresenter
class homePresenter {
    
    //MARK: - PresenterView
    weak var homeView: homeView?

    //MARK: - homeInteractor
    let homeInteractor = HomeInteractor()
    
    var lowestStockItems = [ProductContent]()
    var expiredSoonItems = [ProductContent]()
    
    
    //MARK: - PresenterConstractours
    init(homeView: homeView ) {
        self.homeView = homeView
    }
    
    //MARK: - GetLowestStock
    func getLowestStockHomeProducts(){
        self.homeView?.showSpinner()
        
        homeInteractor.GetHomeProducts(homeProudctsType: 0) { [weak self ] (LowestStockItems, error) in

            guard let self = self else { return }
            self.homeView?.hideSpinner()
            
            if let _ = error {
                self.homeView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            
            self.lowestStockItems = LowestStockItems?.content ?? [ProductContent]()
            self.homeView?.SuccessLowestStockHome()
            return
        }
    }
    
    //MARK: - GetLowestStock
    func getexpiredSoonHomeProducts(){
        self.homeView?.showSpinner()
        
        homeInteractor.GetHomeProducts(homeProudctsType: 1) { [weak self ] (expiredSoonItems, error) in

            guard let self = self else { return }
            self.homeView?.hideSpinner()
            
            if let _ = error {
                self.homeView?.FailureAlert(with: "\(error?.message ?? "please_check_your_internet_connection_and_try_again".localized())")
                return
            }
            self.expiredSoonItems = expiredSoonItems?.content ?? [ProductContent]()
            self.homeView?.SuccessExpiredSoon()
            return
        }
    }
    
    
}
