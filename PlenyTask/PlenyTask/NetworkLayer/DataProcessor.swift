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
    
    /// Decodes Data into a Decodable object (e.g., JSON → Model).
    func decode<T: Decodable>(_ data: Data, to type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    /// Encodes an Encodable object into Data (e.g., Model → JSON).
    func encode<T: Encodable>(_ value: T) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional: Makes JSON readable
        return try encoder.encode(value)
    }
}
