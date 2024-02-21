//
//  CatgsModels.swift
//  Breeza
//
//  Created by Amr Ali on 21/02/2024.
//

import Foundation

// MARK: - SuppliersModelElement
struct SuppliersModelElement: Codable {
    var id: Int?
    var name, contactNumber, email: String?
}

typealias SuppliersModel = [SuppliersModelElement]

// MARK: -----------------------------------------------------------------------------

// MARK: - BrandsModelElement
struct BrandsModelElement: Codable {
    var id: Int?
    var name: String?
}

typealias BrandsModel = [BrandsModelElement]

// MARK: -----------------------------------------------------------------------------

// MARK: - CategorisModelElement
struct CategorisModelElement: Codable {
    var id: Int?
    var name: String?
}

typealias CategorisModel = [CategorisModelElement]
