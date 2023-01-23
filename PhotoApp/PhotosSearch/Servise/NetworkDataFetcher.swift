//
//  NetworkService.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 04.07.2022.
//

import Foundation

final class NetworkDataFetcher {
    
    var worker = QueryCreator()
    
    func fetchImages(searchTerm: String, complition: @escaping(SearchResultModel?) -> ()) {
        worker.createRequest(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("Error received request data: \(error.localizedDescription)")
                complition(nil)
            }
            let decode = self.decodeJSONE(type: SearchResultModel.self, from: data)
            complition(decode)
        }
    }
    
    func decodeJSONE<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let jsoneError {
            print("Failed to decode JSONE", jsoneError)
            return nil
        }
    }
}
