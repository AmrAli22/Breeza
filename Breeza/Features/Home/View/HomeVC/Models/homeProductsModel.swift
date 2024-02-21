// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeProductModel = try? JSONDecoder().decode(HomeProductModel.self, from: jsonData)

import Foundation

// MARK: - HomeProductModel
struct HomeProductModel: Codable {
    var totalPages, totalElements: Int?
    var pageable: Pageable?
    var size: Int?
    var content: [HomeProductContent]?
    var number: Int?
    var sort: Sort?
    var numberOfElements: Int?
    var first, last, empty: Bool?
}

// MARK: - Content
struct HomeProductContent: Codable {
    var id: Int?
    var productName: String?
    var category, brand: Brand?
    var supplier: Supplier?
    var maximumCapacity, quantity, safetyStock, expiryQuantity: Int?
    var imageURL, description, barcode: String?
    var productUomID, usageUomID, orderUomID: Int?
    var uomUsageName, uomOrderName: String?
    var uomConversionQuantity: Int?
    var sameUOM: Bool?
    var purchasePrice, minOrderQty: Int?
    var expiryUnit: String?

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

// MARK: - Supplier
struct Supplier: Codable {
    var id: Int?
    var name, contactNumber: String?
}

// MARK: - Pageable
struct Pageable: Codable {
    var pageNumber, pageSize, offset: Int?
    var sort: Sort?
    var paged, unpaged: Bool?
}

// MARK: - Sort
struct Sort: Codable {
    var sorted, empty, unsorted: Bool?
}
