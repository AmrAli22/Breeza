//
//  HomeInteractor.swift
//  Breeza
//
//  Created by Amr Ali on 08/02/2024.
//

import Foundation
import Alamofire


struct HomeInteractor {
    
    
    typealias LowestStockItemsComplation = (_ LowestStockItems: HomeProductModel?, _ error: ErrorResponse?) -> ()
    func GetHomeProducts(homeProudctsType : Int ,currentPage : Int ,completion: @escaping LowestStockItemsComplation) {
        
        let params: [String: Any] = [
            "sortByLowestStock": homeProudctsType == 0,
            "sortByExpirySoon" : homeProudctsType != 0,
            "underMinimum": false
        ]
        
        let pageinig : [String: Any] = [
            "page" : currentPage ,
            "size" : 10
        ]

        NetworkingManager.sendRequestAuth(method: .post, url: APIUrlsConstants.homeProducts , params: params , Appendedparams: pageinig ,encoding: JSONEncoding.default) { data in
            do {
                
                let dataResponse: HomeProductModel = try JSONDecoder().decode(HomeProductModel.self, from: data!)
                completion(dataResponse, nil)
          
            } catch (let error) {
                let errorResponse = ErrorResponse(message: error.localizedDescription)
                completion(nil, errorResponse)
                return
            }
        } errorHandler: { error in
            completion(nil, error)
            return
        }
    }
}
