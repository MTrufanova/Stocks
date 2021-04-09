//
//  NewsModel.swift
//  Stocks
//
//  Created by msc on 08.04.2021.
//

import Foundation

struct NewsModel: Decodable {
    let title: String
    let link: String
    let pubDate: String
    let source: String
    let guid: String
}
typealias NewsResponse = [NewsModel]
