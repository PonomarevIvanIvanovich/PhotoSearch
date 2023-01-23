//
//  Worker.swift
//  PhotosSearch
//
//  Created by Иван Пономарев on 03.07.2022.
//

import Foundation

final class QueryCreator {
    
    func createRequest(searchTerm: String, completion: @escaping(Data?, Error?) -> Void) {
        let parametrs = self.prepareParam(searhTerm: searchTerm)
        let url = self.createURL(params: parametrs)
        guard let url = url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func prepareHeaders() -> [String : String]? {
        var headers = [String : String]()
        headers["Authorization"] = "Client-ID EsWez5TGTHR3IkMgyV6WPj_GlT7C6DKRbQAxLpRnM7k"
        return headers
    }

    private func prepareParam(searhTerm: String) -> [String : String] {
        var parametrs = [String : String]()
        parametrs["query"] = searhTerm
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(30)
        return parametrs
    }

    private func createURL(params : [String : String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map{ URLQueryItem(name: $0, value: $1)}
        guard let componentsURL = components.url else { return nil}
        return componentsURL
    }

    private func createDataTask(from request: URLRequest,
                                completion: @escaping(Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
