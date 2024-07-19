//
//  SismosViewModel.swift
//  Sismos-Chile
//
//  Created by Jose David Bustos H on 18-07-24.
//


import Foundation
import Combine

class SismosViewModel: ObservableObject {
    @Published var indicadores: [Event] = []
    private let networkService = NetworkService()
    var reloadList: (() -> Void)?
    var arrayOfList: [Event] = [] {
        didSet {
            reloadList?()
        }
    }
    
    init() {
        fetchIndicadores()
    }
    
    func fetchIndicadores() {
        networkService.fetchIndicadores { [weak self] response in
            guard let self = self, let response = response else { return }
            DispatchQueue.main.async {
                self.indicadores = response
                self.arrayOfList = self.indicadores
            }
        }
    }
}

