//
//  UserDefaults+Extension.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

extension UserDefaults {
    
    func setStruct<T: Codable>(_ value: T?, forKey defaultName: String) {
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }

    func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T: Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }

        return try? JSONDecoder().decode(type, from: encodedData)
    }
}
