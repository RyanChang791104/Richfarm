// GalleryView.swift
// RichFarm - 態沃果園

import SwiftUI

struct GalleryView: View {
    // Creating an array of all the 71 downloaded image IDs
    let images: [String] = (1...71).map { "img_\($0)" }
    
    @State private var selectedImage: String?
    
    // Grid layout formatting
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header text
                    VStack(spacing: 6) {
                        Text("📷 果園剪影")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundColor(.farmDarkGreen)
                        Text("汗水與大自然交織的美麗風景，紀錄態沃果園的每一天")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                    
                    // Masonry style Photo Grid
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(images, id: \.self) { imageName in
                            GeometryReader { geo in
                                if UIImage(named: imageName) != nil {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: geo.size.width) // Make it square
                                        .clipped()
                                        .onTapGesture {
                                            selectedImage = imageName
                                        }
                                } else {
                                    // Fallback placeholder if asset isn't dragged into Xcode yet
                                    Rectangle()
                                        .fill(Color.farmLightGreen.opacity(0.3))
                                        .frame(width: geo.size.width, height: geo.size.width)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.farmGreen.opacity(0.5))
                                        )
                                }
                            }
                            .aspectRatio(1, contentMode: .fit) // Keep squares aligned properly
                        }
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true)
            // Fullscreen viewer overlay
            .overlay(
                Group {
                    if let selected = selectedImage {
                        ZStack {
                            Color.black.ignoresSafeArea()
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            selectedImage = nil
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white.opacity(0.7))
                                            .padding()
                                    }
                                }
                                Spacer()
                            }
                            
                            if UIImage(named: selected) != nil {
                                Image(selected)
                                    .resizable()
                                    .scaledToFit()
                                    .ignoresSafeArea()
                            }
                        }
                        .transition(.opacity)
                        .zIndex(2) // Appear over navbar
                    }
                }
            )
            .animation(.easeInOut, value: selectedImage != nil)
        }
    }
}
