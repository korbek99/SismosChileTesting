//
//  GeoJSONUtils.swift
//  SismosChile
//
//  Created by Jose David Bustos H on 19-07-24.
//

import Foundation

// Define una estructura para el GeoJSON
struct GeoJSONFeatureCollection: Codable {
    let type: String
    let features: [GeoJSONFeature]
}

struct GeoJSONFeature: Codable {
    let type: String
    let geometry: GeoJSONGeometry
    let properties: [String: AnyCodable]?
}

struct GeoJSONGeometry: Codable {
    let type: String
    let coordinates: [Double]
}

// Define un contenedor para valores codificables de tipo cualquier
struct AnyCodable: Codable {
    let value: Any

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let string = try? container.decode(String.self, forKey: .value) {
            value = string
        } else if let number = try? container.decode(Double.self, forKey: .value) {
            value = number
        } else {
            throw DecodingError.typeMismatch(AnyCodable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Type mismatch"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let string = value as? String {
            try container.encode(string, forKey: .value)
        } else if let number = value as? Double {
            try container.encode(number, forKey: .value)
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Invalid value"))
        }
    }

    private enum CodingKeys: String, CodingKey {
        case value
    }
}

// Función para leer y convertir GeoJSON a JSON
func convertGeoJSONToJSON(fileName: String) {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "geojson") else {
        print("GeoJSON file not found")
        return
    }
    
    do {
        let data = try Data(contentsOf: url)
        
        // Decodifica el archivo GeoJSON
        let decoder = JSONDecoder()
        let geoJSON = try decoder.decode(GeoJSONFeatureCollection.self, from: data)
        
        // Convierte el objeto GeoJSON a JSON
        let jsonData = try JSONEncoder().encode(geoJSON)
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("JSON Output: \(jsonString)")
        }
    } catch {
        print("Error: \(error)")
    }
}

// Llama a la función con el nombre del archivo GeoJSON (sin la extensión)
//convertGeoJSONToJSON(fileName: "your_geojson_file_name")

