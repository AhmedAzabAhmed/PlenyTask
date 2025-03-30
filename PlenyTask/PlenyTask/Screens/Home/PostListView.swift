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
