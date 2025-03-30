//
//  PostsUseCase.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

final class PostsUseCase {
    let postsRepository: PostsRepository
    
    init(postsRepository: PostsRepository = PostsRepositoryImplementation()) {
        self.postsRepository = postsRepository
    }
    
    func fetchPosts() async throws -> [Post] {
        try await postsRepository.fetchPosts(skip: 0, limit: 10)
    }
    
    func searchFor(query: String, skip: Int) async throws  -> [Post] {
        try await postsRepository.searchPosts(query: query, skip: 0, limit: 10)
    }
    
    func loadMorePosts(skip: Int) async throws -> [Post] {
        try await postsRepository.fetchPosts(skip: skip, limit: 10)
    }
}
