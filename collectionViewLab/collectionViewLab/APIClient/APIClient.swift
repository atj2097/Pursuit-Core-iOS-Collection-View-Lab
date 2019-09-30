//
//  APIClient.swift
//  collectionViewLab
//
//  Created by God on 9/26/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = CountryAPIClient()
    
    // MARK: - Instance Methods
    
    static func getElementLargeImageURLString(from name: String) -> String {
        return "https://www.countryflags.io/\(name.lowercased())/shiny/64.png"
    }
    
    func getCountries(completionHandler: @escaping (Result<[CountryElement], AppError>) -> ())  {
        NetworkHelper.manager.performDataTask(withUrl: elementURL, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let countInfo = try CountryElement.decodeCountryFromData(from: data)
                    completionHandler(.success(countInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    
    // MARK: - Private Properties and Initializers
    private var elementURL: URL {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
