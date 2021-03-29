//
//  APIClient.swift
//  Stocks
//
//  Created by msc on 24.03.2021.
//

import Foundation

enum APIError: Error {
    case noData
}

protocol APIClient {
    func fetchData(onResult: @escaping (Result<StockResponse, Error>) -> Void)
    
}

class APIClientclass: APIClient {
    func fetchData(onResult: @escaping (Result<StockResponse, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://mboum.com/api/v1/qu/quote/?symbol=AAPL,F&apikey=demo") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else {
                onResult(.failure(APIError.noData))
                return
            }
            do{
                let stocksResponse = try JSONDecoder().decode(StockResponse.self, from: data)
                onResult(.success(stocksResponse))
            }catch let error{
                print(error)
                onResult(.failure(error))
            }
        })
        dataTask.resume()
       
    }
    
    
}
