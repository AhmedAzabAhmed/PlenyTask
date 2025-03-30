//
//  DataProcessor.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

final class DataProcessor {
    static let shared = DataProcessor()
    
    private init() {}
    
    func decode<T: Decodable>(_ data: Data, to type: T.Type) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
