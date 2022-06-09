//
//  HTTPClient.swift
//  themealdb
//
//  Created by Phil Wright on 6/8/22.
//

import Foundation

public protocol HTTPClient {
    var session: URLSession { get }
    func get(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
