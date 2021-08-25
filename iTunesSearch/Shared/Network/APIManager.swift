//
//  APIManager.swift
//  iTunesSearch
//
//  Created by Emrullah Hancer on 24.08.2021.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    typealias callbackSuccess = (ListModel) -> Void
    typealias callbackFailure = (APIError) -> Void
    
    func fetchList(term: String, wrapperType: String, limit: Int, success: @escaping callbackSuccess, failure: @escaping callbackFailure) {
        let baseURL = "https://itunes.apple.com/search?"

        guard var urlComponents = URLComponents(string: baseURL) else { return }
        urlComponents.query = "media=\(wrapperType)&term=\(term)&limit=\(limit)"

        guard let url = urlComponents.url else { return }

        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)

                    let result = try JSONDecoder().decode(ListModel.self, from: data)
                    success(result)
                } catch {
                    failure(.parseError)
                    print(error)
                }
            } else {
                failure(.responseError)
            }
        }.resume()
    }
}
