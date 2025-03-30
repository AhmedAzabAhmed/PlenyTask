//
//  PostsResponse.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

struct PostsResponse: Codable {
    let posts: [Post]
    let total: Int
    let skip: Int
    let limit: Int
}

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]
    let reactions: Reactions
    let views: Int
    let userId: Int
    
    // For optional fields if they might be missing sometimes
    var imageUrl: String? // Example of optional field
}

struct Reactions: Codable {
    let likes: Int
    let dislikes: Int
    
    // Computed property for convenience
    var netScore: Int {
        return likes - dislikes
    }
}
