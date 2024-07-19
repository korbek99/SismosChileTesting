//
//  SismosChile.swift
//  Sismos-Chile
//
//  Created by Jose David Bustos H on 18-07-24.
//
//
//
//import Foundation
//
//struct SismosChile: Codable {
//    let statusCode: Int
//    let statusDescription: String
//    let events: [Event]
//}
//
//struct Event: Codable {
//    let id: String
//    let url: String
//    let mapURL: String
//    let localDate, utcDate: String
//    let latitude, longitude, depth: Double
//    let magnitude: Magnitude
//    let geoReference: String
//}
//
//struct Magnitude: Codable {
//    let value: Double
//    let measureUnit: String
//}
//
import Foundation

struct SismosChile: Codable {
    let statusCode: Int
    let statusDescription: String
    let events: [Event]

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusDescription = "status_description"
        case events
    }
}

struct Event: Codable {
    let id: String
    let url: String
    let mapUrl: String
    let localDate: String
    let utcDate: String
    let latitude: Double
    let longitude: Double
    let depth: Int
    let magnitude: Magnitude
    let geoReference: String

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case mapUrl = "map_url"
        case localDate = "local_date"
        case utcDate = "utc_date"
        case latitude
        case longitude
        case depth
        case magnitude
        case geoReference = "geo_reference"
    }
}

struct Magnitude: Codable {
    let value: Double
    let measureUnit: String

    enum CodingKeys: String, CodingKey {
        case value
        case measureUnit = "measure_unit"
    }
}
