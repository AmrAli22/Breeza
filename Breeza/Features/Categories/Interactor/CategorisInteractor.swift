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

    
    typealias FiltredItemsComplation = (_ Items: HomeProductModel?, _ error: ErrorResponse?) -> ()
    func GetFiltredProducts(selectedCatg : Int? , selectedBrand : Int? , selectedSupplier : Int? ,currentPage : Int ,completion: @escaping FiltredItemsComplation) {
        
        var  params: [String: Any] = [
            "sortByLowestStock": false,
            "sortByExpirySoon" : true,
            "underMinimum": false
        ]
        
        if  selectedCatg != nil  {
            params.updateValue([selectedCatg!], forKey: "categoryIds")
        }
        
        if  selectedBrand  != nil {
            params.updateValue([selectedBrand!], forKey: "brandIds")
        }
        
        if  selectedSupplier != nil {
            params.updateValue([selectedSupplier!], forKey: "supplier")
        }
        
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
