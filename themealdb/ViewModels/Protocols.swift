//
//  Protocols.swift
//  themealdb
//
//  Created by Phil Wright on 4/30/22.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func willLoadData()
    func didLoadData()
    func didLoadDataWithError(error: Error)
}

protocol ViewModelType {
    func bootstrap()
    var delegate: ViewModelDelegate? { get set }
}
