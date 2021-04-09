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
    func fetchHistoryStock(onResult: @escaping (Result<HistoryStocks, Error>) -> Void)
    func fetchNews(onResult: @escaping (Result<NewsResponse, Error>) -> Void)
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
    
    func fetchHistoryStock(onResult: @escaping (Result<HistoryStocks, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://mboum.com/api/v1/hi/history/?symbol=F&interval=5m&diffandsplits=true&apikey=demo") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            guard let data = data else {
                onResult(.failure(APIError.noData))
                return
            }
            do{
                let historyResponse = try JSONDecoder().decode(HistoryStocks.self, from: data)
                onResult(.success(historyResponse))

            } catch (let err) {
                print(err)
                onResult(.failure(err))
            }
        })
        dataTask.resume()
    }
    
    func fetchNews(onResult: @escaping (Result<NewsResponse, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://mboum.com/api/v1/ne/news/?apikey=demo") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                onResult(.failure(APIError.noData))
                return
            }
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                onResult(.success(newsResponse))
            } catch (let error) {
                print(error)
                onResult(.failure(error))
            }
        }
        dataTask.resume()
    }
    
}
