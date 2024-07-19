//
//  NetworkService.swift
//  Sismos-Chile
//
//  Created by Jose David Bustos H on 18-07-24.
//

import Foundation

class NetworkService {
    func fetchIndicadores(completion: @escaping ([Event]?) -> Void) {
       
        let endpointData = getEndpoint(fromName: "crearIssue")!
//        var headers: [String: String] = ["Content-Type" : "application/json"]
//        headers["x-api-key"] = endpointData.APIKey
//        if let APIToken = endpointData.APIToken {
//            headers["x-api-token"] = APIToken
//        }
        let urlString = endpointData.url.absoluteString
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response received")
                completion(nil)
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let trackResponse = try JSONDecoder().decode(SismosChile.self, from: data)
                completion(trackResponse.events)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()

    }
    
    public func getEndpoint(fromName: String) -> APIEndpointModel? {
            var endpointFile = ""
            #if DEBUG
                endpointFile = "endpointsDev"
            #else
                endpointFile = "endpoints"
            #endif
            debugPrint(endpointFile)
            guard let path = Bundle.main.path(forResource: endpointFile, ofType: "plist") else {
                debugPrint("ERROR: No se encontró archivo endpoints.plist")
                return nil
            }
            let myDict = NSDictionary(contentsOfFile: path) as! [String : Any]
            guard let endpoint = myDict[fromName] as? [String : String] else {
                debugPrint("ERROR: No existe endpoint con el nombre \(fromName)")
                return nil
            }
            return APIEndpointModel(url: URL(string: endpoint["url"]!)!, APIKey: endpoint["x-api-key"]!, APIToken: endpoint["x-api-token"])
    }
}

