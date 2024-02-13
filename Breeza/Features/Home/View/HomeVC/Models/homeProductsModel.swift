//
//  homeProductsModel.swift
//  Breeza
//
//  Created by Amr Ali on 08/02/2024.
//

import Foundation
//   let homeProductModel = try? JSONDecoder().decode(HomeProductModel.self, from: jsonData)
// MARK: - HomeProductModel
struct HomeProductModel: Codable {
    var content: [ProductContent]?
    var pageable: Pageable?
    var totalPages, totalElements: Int?
    var last: Bool?
    var size, number: Int?
    var sort: Sort?
    var numberOfElements: Int?
    var first, empty: Bool?
}

// MARK: - Content
struct ProductContent: Codable {
    var id: Int?
    var productName: String?
    var category: Brand?
    var brand: Brand?
    var supplier: Supplier?
    var maximumCapacity, quantity, safetyStock, expiryQuantity: Int?
    var imageURL: String?
    var description: String?
    var barcode: String?
    var productUomID, usageUomID, orderUomID: Int?
    var uomUsageName, uomOrderName: String?
    var uomConversionQuantity: Int?
    var sameUOM: Bool?
    var purchasePrice, minOrderQty: Int?
    var expiryUnit: ExpiryUnit?

    enum CodingKeys: String, CodingKey {
        case id, productName, category, brand, supplier, maximumCapacity, quantity, safetyStock, expiryQuantity
        case imageURL = "imageUrl"
        case description, barcode
        case productUomID = "productUomId"
        case usageUomID = "usageUomId"
        case orderUomID = "orderUomId"
        case uomUsageName, uomOrderName, uomConversionQuantity, sameUOM, purchasePrice, minOrderQty, expiryUnit
    }
}

// MARK: - Brand
struct Brand: Codable {
    var id: Int?
    var name: String?
}

enum ExpiryUnit: String, Codable {
    case month = "Month"
    case year = "Year"
}

// MARK: - Supplier
struct Supplier: Codable {
    var id: Int?
    var name: String?
    var contactNumber: String?
}

// MARK: - Pageable
struct Pageable: Codable {
    var sort: Sort?
    var pageNumber, pageSize, offset: Int?
    var paged, unpaged: Bool?
}

// MARK: - Sort
struct Sort: Codable {
    var sorted, empty, unsorted: Bool?
}
