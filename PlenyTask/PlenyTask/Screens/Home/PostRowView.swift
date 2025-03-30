//
//  PostRowView.swift
//  PlenyTask
//
//  Created by Ahmed Azab on 30/03/2025.
//

import SwiftUI

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(post.body)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack(spacing: 16) {
                Label("\(post.reactions.likes)", systemImage: "hand.thumbsup")
                    .font(.caption)
                
                Label("\(post.views)", systemImage: "eye")
                    .font(.caption)
                
                if !post.tags.isEmpty {
                    Text(post.tags.prefix(2).joined(separator: ", "))
                        .font(.caption)
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
