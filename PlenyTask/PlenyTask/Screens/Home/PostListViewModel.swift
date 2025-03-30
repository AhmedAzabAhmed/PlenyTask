//
//  PostListViewModel.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import Foundation

final class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    
    private let postsUseCase: PostsUseCase
    
    init(postsUseCase: PostsUseCase = PostsUseCase()) {
        self.postsUseCase = postsUseCase
    }
    
    @MainActor
    func loadPosts() async {
        isLoading = true
        
        do {
            let response = try await postsUseCase.fetchPosts()
            posts.append(contentsOf: response)
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func validateLoadMore(currentItem item: Post?) {
        guard let currentIndex = posts.firstIndex(where: { $0.id == item?.id }),
              currentIndex == posts.index(posts.endIndex, offsetBy: -4) else {
            return
        }
        Task {
            do {
             let response = try await postsUseCase.loadMorePosts(skip: posts.count)
                DispatchQueue.main.async {
                    self.posts.append(contentsOf: response)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
