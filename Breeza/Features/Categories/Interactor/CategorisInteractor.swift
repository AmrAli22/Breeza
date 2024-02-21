//
//  CategorisInteractor.swift
//  Breeza
//
//  Created by Amr Ali on 21/02/2024.
//

import Foundation
import Alamofire


struct CategorisInteractor {

    typealias CategorisItemsComplation = (_ catgsItems: [CategorisModelElement]?, _ error: ErrorResponse?) -> ()
    func GetCategoris(completion: @escaping CategorisItemsComplation) {


        NetworkingManager.sendRequestAuth(method: .get, url: APIUrlsConstants.categories , params: nil , Appendedparams: nil ,encoding: URLEncoding.queryString) { data in
            do {
                
                let dataResponse: CategorisModel = try JSONDecoder().decode(CategorisModel.self, from: data!)
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
    
    
    
    typealias SuppliersItemsComplation = (_ SuppliersItems: SuppliersModel?, _ error: ErrorResponse?) -> ()
    func GetSuppliers(completion: @escaping SuppliersItemsComplation) {


        NetworkingManager.sendRequestAuth(method: .get, url: APIUrlsConstants.supplier , params: nil , Appendedparams: nil ,encoding: URLEncoding.queryString) { data in
            
            do {
                
                let dataResponse: SuppliersModel = try JSONDecoder().decode(SuppliersModel.self, from: data!)
                
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

    
    
    typealias BrandsItemsComplation = (_ BrandsItems: [BrandsModelElement]?, _ error: ErrorResponse?) -> ()
    func GetBrands(completion: @escaping BrandsItemsComplation) {


        NetworkingManager.sendRequestAuth(method: .get, url: APIUrlsConstants.brands , params: nil , Appendedparams: nil ,encoding: URLEncoding.queryString) { data in
            do {
                
                let dataResponse: BrandsModel = try JSONDecoder().decode(BrandsModel.self, from: data!)
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
