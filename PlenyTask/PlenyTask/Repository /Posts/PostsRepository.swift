//
//  PostsRepository.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

protocol PostsRepository {
    func fetchPosts(skip: Int, limit: Int) async throws -> [Post]
    func searchPosts(query: String, skip: Int, limit: Int) async throws -> [Post]
}
