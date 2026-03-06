// ProductsView.swift
// RichFarm - 態沃果園

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

struct Product: Identifiable {
    let id = UUID()
    let imageName: String?
    let emoji: String
    let name: String
    let description: String
    let price: String
    let weight: String
    let details: String
    let color: Color
    let tags: [String]
}

struct ProductsView: View {
    let products: [Product] = [
        Product(
            imageName: "img_3", // Example mapping
            emoji: "🍊",
            name: "日本種香丁",
            description: "態沃果園獨有的日本種香丁，別處吃不到！果肉非常細膩，入口沁甜鮮香，口齒留香。",
            price: "390元起",
            weight: "10斤/20斤",
            details: "【重量規格】10斤/20斤\n【價格】10斤／390元、20斤／700元\n【產地】新竹關西\n【運費】北北基100元/中南部150元\n【交易方式】面交/貨運寄送\n【付款方式】貨到付款/轉帳",
            color: .farmOrange,
            tags: ["當季", "限量", "獨家"]
        ),
        Product(
            imageName: "img_5",
            emoji: "🍊",
            name: "日本種蜜丁",
            description: "每年只有在冬天接近年終才有機會吃到，接單現採，新鮮程度沒話說！富含維他命C。",
            price: "依季節報價",
            weight: "10斤/20斤",
            details: "一年只有一次的多汁蜜丁\n新鮮採收，接單現採\n富含維他命C\n關西態沃小農果園獨家",
            color: Color(red: 0.9, green: 0.6, blue: 0.1),
            tags: ["當季", "維他命C"]
        ),
        Product(
            imageName: "img_6",
            emoji: "🥝",
            name: "桶柑",
            description: "老爸種了50年以上的桶柑，皮薄多汁，有酸有甜，就如同人生一般有溫度！",
            price: "依季節報價",
            weight: "依產量",
            details: "50年以上老樹\n桶柑品種\n皮薄多汁\n酸甜可口\n產地直送・新鮮保證",
            color: .farmGreen,
            tags: ["老樹", "有溫度"]
        ),
        Product(
            imageName: "img_7",
            emoji: "🫒",
            name: "苦茶油",
            description: "自家栽種苦茶籽，純正天然壓榨，為家人健康把關！",
            price: "依季節報價",
            weight: "依產量",
            details: "自家栽種苦茶籽\n天然壓榨工法\n無添加化學物質\n健康好油",
            color: .farmBrown,
            tags: ["天然", "健康"]
        ),
        Product(
            imageName: "img_8",
            emoji: "🍵",
            name: "關西仙草茶",
            description: "用修剪的柑橘樹枝當材燒煮，經過6小時以上熬煮，純正關西仙草茶！不加糖，清熱解暑。",
            price: "依訂購量報價",
            weight: "瓶裝",
            details: "純正關西仙草茶\n6小時以上熬煮\n不加糖，甘純濃\n接單排時間熬煮\n適合小朋友喝\n\n★ 整瓶不加水煮仙草雞湯超好喝！\n★ 收到放冷凍保存\n★ 歡迎公司學校團購",
            color: Color(red: 0.30, green: 0.30, blue: 0.30),
            tags: ["手作", "無糖", "團購"]
        ),
        Product(
            imageName: "img_10",
            emoji: "🍋",
            name: "柚子",
            description: "老爸種了50年以上的柚子，皮厚有水份，有酸有甜，就如同人生一般有溫度！",
            price: "依季節報價",
            weight: "依產量",
            details: "50年以上老樹\n柚子全身都是寶：\n・綠皮 → 自製清潔劑\n・白囊 → 柚皮糖\n・果肉 → 果醬/柚子茶",
            color: .farmGold,
            tags: ["老樹", "自然農法"]
        )
    ]
    
    @State private var selectedProduct: Product?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 8) {
                        Text("🌿 特色農產品")
                            .font(.system(size: 28, weight: .heavy))
                            .foregroundColor(.farmDarkGreen)
                        Text("自然農法 · 用心栽培 · 新鮮直送")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.farmTextLight)
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    
                    // Product Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 20) {
                        ForEach(products) { product in
                            ProductCardView(product: product)
                                .onTapGesture {
                                    selectedProduct = product
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                }
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
                    Text("商品")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.farmDarkGreen)
                }
            }
            .sheet(item: $selectedProduct) { product in
                ProductDetailSheet(product: product)
            }
        }
    }
}

// MARK: - Product Card
struct ProductCardView: View {
    let product: Product
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Image / Emoji Area
            ZStack {
                Rectangle()
                    .fill(product.color.opacity(0.1))
                
#if os(iOS)
                if let imageName = product.imageName, UIImage(named: imageName) != nil {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Text(product.emoji)
                        .font(.system(size: 50))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                }
#else
                if let imageName = product.imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Text(product.emoji)
                        .font(.system(size: 50))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                }
#endif
            }
            .frame(height: 120)
            .clipped()
            
            // Content Area
            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.farmBrown)
                    .lineLimit(1)
                
                // Tags
                HStack(spacing: 4) {
                    ForEach(product.tags.prefix(2), id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 9, weight: .bold))
                            .foregroundColor(product.color)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(product.color.opacity(0.15))
                            )
                    }
                }
                
                Spacer(minLength: 0)
                
                HStack {
                    Text(product.price)
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(product.color)
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.farmGreen)
                        .font(.system(size: 20))
                }
            }
            .padding(12)
            .frame(height: 100)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        )
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.spring(response: 0.3), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

// MARK: - Product Detail Sheet
struct ProductDetailSheet: View {
    let product: Product
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Header Image
                    ZStack(alignment: .bottom) {
#if os(iOS)
                        if let imageName = product.imageName, UIImage(named: imageName) != nil {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 280)
                                .clipped()
                        } else {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [product.color.opacity(0.4), product.color.opacity(0.1)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(height: 280)
                            
                            Text(product.emoji)
                                .font(.system(size: 100))
                                .offset(y: -40)
                                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                        }
#else
                        if let imageName = product.imageName {
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 280)
                                .clipped()
                        } else {
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [product.color.opacity(0.4), product.color.opacity(0.1)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .frame(height: 280)
                            
                            Text(product.emoji)
                                .font(.system(size: 100))
                                .offset(y: -40)
                                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                        }
#endif
                        
                        // Curved overlay to blend into background
                        Rectangle()
                            .fill(Color.farmBgGradientTop)
                            .frame(height: 30)
                            .cornerRadius(30, corners: [.topLeft, .topRight])
                            .offset(y: 15) // Hide the bottom corners
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        // Title & Price Header
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.name)
                                    .font(.system(size: 28, weight: .heavy))
                                    .foregroundColor(.farmBrown)
                                
                                // Tags
                                HStack(spacing: 6) {
                                    ForEach(product.tags, id: \.self) { tag in
                                        Text(tag)
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 4)
                                            .background(
                                                Capsule()
                                                    .fill(product.color.opacity(0.9))
                                            )
                                    }
                                }
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                Text(product.price)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(product.color)
                                Text(product.weight)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.farmTextLight)
                            }
                        }
                        
                        Divider()
                        
                        // Description
                        VStack(alignment: .leading, spacing: 12) {
                            Text("商品介紹")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.farmDarkGreen)
                            
                            Text(product.description)
                                .font(.system(size: 15))
                                .foregroundColor(.farmTextLight)
                                .lineSpacing(6)
                        }
                        
                        // Details Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "list.clipboard.fill")
                                    .foregroundColor(product.color)
                                Text("詳細資訊")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.farmBrown)
                            }
                            
                            Divider()
                            
                            Text(product.details)
                                .font(.system(size: 14))
                                .foregroundColor(.farmTextLight)
                                .lineSpacing(6)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.04), radius: 10, x: 0, y: 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                                )
                        )
                        
                        // Order Button
                        Button(action: {
                            if let url = URL(string: "tel:0911897739") {
                                openURL(url)
                            }
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 18))
                                Text("專人電話訂購 0911-897-739")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            colors: [.farmGreen, .farmDarkGreen],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .shadow(color: .farmGreen.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                    .background(
                        Color.farmBgGradientTop
                            .ignoresSafeArea()
                    )
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Color.farmBgGradientTop.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white.opacity(0.8))
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 1)
                    }
                }
            }
        }
    }
}

// Helper for rounded corners on specific sides
extension View {
    func cornerRadius(_ radius: CGFloat, corners: RoundedShape.RectCorner) -> some View {
        clipShape( RoundedShape(corners: corners, radius: radius) )
    }
}

