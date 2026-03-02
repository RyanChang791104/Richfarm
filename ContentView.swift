// ContentView.swift
// RichFarm - 態沃果園

import SwiftUI

// MARK: - Color Theme
extension Color {
    static let farmGreen = Color(red: 0.18, green: 0.55, blue: 0.34)
    static let farmDarkGreen = Color(red: 0.10, green: 0.38, blue: 0.22)
    static let farmGold = Color(red: 0.85, green: 0.65, blue: 0.13)
    static let farmOrange = Color(red: 0.93, green: 0.55, blue: 0.20)
    static let farmBrown = Color(red: 0.44, green: 0.31, blue: 0.18)
    static let farmCream = Color(red: 0.98, green: 0.96, blue: 0.90)
    static let farmLightGreen = Color(red: 0.85, green: 0.94, blue: 0.85)
    static let farmBgGradientTop = Color(red: 0.95, green: 0.97, blue: 0.93)
    static let farmBgGradientBottom = Color(red: 1.0, green: 0.98, blue: 0.95)
}

// MARK: - Main Content View
struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首頁")
                }
                .tag(0)
            
            ProductsView()
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("商品")
                }
                .tag(1)
            
            GalleryView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("剪影")
                }
                .tag(2)
            
            AboutView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("關於我們")
                }
                .tag(3)
            
            CookingView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("私房料理")
                }
                .tag(4)
            
            OrderView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("下訂單")
                }
                .tag(5)
        }
        .accentColor(.farmGreen)
    }
}
