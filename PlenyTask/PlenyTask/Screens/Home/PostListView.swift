//
//  PostListView.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel = PostListViewModel()
    
    var body: some View {
        
        List {
            SearchBar(searchText: $viewModel.searchText)
                .listRowSeparator(.hidden)
                .onChange(of: viewModel.searchText) { newValue in
                    if !newValue.isEmpty {
                        viewModel.searchFor()
                    } else {
                        // Reset to normal posts when search is cleared
                        Task {
                            viewModel.posts.removeAll()
                            await viewModel.loadPosts()
                        }
                    }
                }
            
            ForEach(viewModel.posts, id: \.id) { post in
                PostRowView(post: post)
                    .onAppear {
                        viewModel.validateLoadMore(currentItem: post)
                    }
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        
        .task {
            await viewModel.loadPosts()
        }
    }
}

#Preview {
    PostListView()
}
