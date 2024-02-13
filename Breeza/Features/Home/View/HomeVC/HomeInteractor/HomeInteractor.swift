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
    func GetHomeProducts(homeProudctsType : Int ,completion: @escaping LowestStockItemsComplation) {
        
        // homeProudctsType : 0 for lowestItems , 1 for ExpirySoon
        
        let params: [String: Any] = [
//            "barcode": nill,
//            "productName": null,
//            "brandIds":null,
//            "categoryIds": null,
//            "supplier": null,
            "sortByLowestStock": homeProudctsType == 0,
            "sortByExpirySoon" : homeProudctsType != 0,
            "underMinimum": false
        ]
        
        NetworkingManager.sendRequestAuth(method: .post, url: APIUrlsConstants.homeProducts , params: params , encoding: JSONEncoding.default) { data in
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
