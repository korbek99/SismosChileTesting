//
//  NetworkWorldService.swift
//  SismosChile
//
//  Created by Jose David Bustos H on 19-07-24.
//

import Foundation

class NetworkWorldService {
    func fetchIndicadores(completion: @escaping ([Event]?) -> Void) {
        let urlString = "https://api.xor.cl/sismo/recent"
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
}


