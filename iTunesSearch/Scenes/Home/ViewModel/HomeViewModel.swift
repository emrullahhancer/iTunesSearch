//
//  HomeViewModel.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func success()
    func fail()
}

final class HomeViewModel {
    
    weak var delegate: ViewModelDelegate?
    var apiManager: APIManager!
    var results: [Results]? = []
    var limit = 20
    var hasNext = true
    
    init() {
        self.apiManager = APIManager()
    }
    
    func getData(term: String, wrapperType: String, refresh: Bool = false) {
        if refresh {
            limit = 20
            results?.removeAll()
            hasNext = true
        }
        apiManager.fetchList(term: term, wrapperType: wrapperType, limit: limit) { response in
            if let results = response.results {
                if results.count < self.limit {
                    self.hasNext = false
                }
                self.limit += self.limit
                self.results?.append(contentsOf: results)
                self.results = self.results?.unique(for: \.trackId)
                self.delegate?.success()
            } else {
                self.hasNext = false
            }
        } failure: { err in
            self.delegate?.fail()
        }
    }
    
}
