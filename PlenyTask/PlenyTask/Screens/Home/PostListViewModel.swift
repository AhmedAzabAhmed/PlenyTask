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
    @Published var searchText: String = ""
    
    private var searchTask: Task<Void, Never>?
    private let postsUseCase: PostsUseCase
    
    init(postsUseCase: PostsUseCase = PostsUseCase()) {
        self.postsUseCase = postsUseCase
    }
    
    @MainActor
    func loadPosts() async {
        isLoading = true
        
        do {
            let response = try await postsUseCase.fetchPosts()
            posts.removeAll()
            posts.append(contentsOf: response)
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func searchFor() {
        searchTask?.cancel()
        searchTask = Task {
            // Small delay to avoid spamming API while typing
            try? await Task.sleep(nanoseconds: 500_000_000) // 500ms
            
            guard !Task.isCancelled else { return }
            
            do {
                let response = try await postsUseCase.searchFor(query: searchText, skip: 0)
                DispatchQueue.main.async {
                    self.posts.removeAll()
                    self.posts.append(contentsOf: response)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
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
