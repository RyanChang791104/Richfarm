// StoryDetailView.swift
// RichFarm - 態沃果園

import SwiftUI

struct StoryItem: Identifiable {
    let id = UUID()
    let imageName: String?
    let title: String
    let preview: String
    let fullContent: String
    let icon: String
    let color: Color
}

struct StoryDetailView: View {
    let story: StoryItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Hero image
                    if let img = story.imageName {
                        Image(img)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [story.color.opacity(0.3), story.color.opacity(0.1)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(height: 220)
                            
                            Image(systemName: story.icon)
                                .font(.system(size: 60))
                                .foregroundColor(story.color)
                        }
                    }
                    
                    // Title
                    Text(story.title)
                        .font(.system(size: 26, weight: .heavy))
                        .foregroundColor(.farmDarkGreen)
                    
                    // Divider with icon
                    HStack {
                        Image(systemName: story.icon)
                            .foregroundColor(story.color)
                        Rectangle()
                            .fill(story.color.opacity(0.3))
                            .frame(height: 2)
                    }
                    
                    // Full story content
                    Text(story.fullContent)
                        .font(.system(size: 16))
                        .foregroundColor(.farmText)
                        .lineSpacing(10)
                }
                .padding(24)
                .padding(.bottom, 40)
            }
            .background(
                LinearGradient(
                    colors: [.farmBgGradientTop, .farmBgGradientBottom],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("農園故事")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.farmDarkGreen)
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.farmTextLight)
                    }
                }
            }
        }
    }
}
