// HomeView.swift
// RichFarm - 態沃果園

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

struct HomeView: View {
    @State private var showBanner = false
    @State private var heroOffset: CGFloat = 0
    @State private var selectedStory: StoryItem?
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // MARK: - Hero Banner
                    heroSection
                    
                    // MARK: - Announcement Banner
                    announcementBanner
                        .padding(.top, -30)
                    
                    // MARK: - Season Highlight
                    seasonHighlightSection
                        .padding(.top, 20)
                    
                    // MARK: - Product Quick Cards
                    productQuickCards
                        .padding(.top, 30)
                    
                    // MARK: - Story Cards
                    storySection
                        .padding(.top, 30)
                    
                    // MARK: - Contact Footer
                    contactFooter
                        .padding(.top, 30)
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
                    HStack(spacing: 8) {
                        Image(systemName: "leaf.circle.fill")
                            .foregroundColor(.farmGreen)
                            .font(.title2)
                        Text("RichFarm")
                            .font(.custom("", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.farmDarkGreen)
                    }
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    showBanner = true
                }
            }
        }
    }
    
    // MARK: - Hero Section
    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Image
#if os(iOS)
            if UIImage(named: "img_11") != nil {
                Image("img_11")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .clipped()
                    .overlay(Color.black.opacity(0.4)) // Darken to make text readable
            } else {
                LinearGradient(
                    colors: [
                        Color(red: 0.12, green: 0.45, blue: 0.25),
                        Color(red: 0.22, green: 0.60, blue: 0.35),
                        Color(red: 0.35, green: 0.70, blue: 0.40)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 280)
                .overlay(
                    ZStack {
                        Circle()
                            .fill(Color.farmOrange.opacity(0.15))
                            .frame(width: 180, height: 180)
                            .offset(x: 100, y: -40)
                        Circle()
                            .fill(Color.farmGold.opacity(0.12))
                            .frame(width: 120, height: 120)
                            .offset(x: -80, y: 50)
                        
                        mountainSilhouette
                            .fill(Color.black.opacity(0.08))
                            .frame(height: 100)
                            .offset(y: 90)
                    }
                )
            }
#else
            LinearGradient(
                colors: [
                    Color(red: 0.12, green: 0.45, blue: 0.25),
                    Color(red: 0.22, green: 0.60, blue: 0.35),
                    Color(red: 0.35, green: 0.70, blue: 0.40)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: 280)
            .overlay(
                ZStack {
                    Circle()
                        .fill(Color.farmOrange.opacity(0.15))
                        .frame(width: 180, height: 180)
                        .offset(x: 100, y: -40)
                    Circle()
                        .fill(Color.farmGold.opacity(0.12))
                        .frame(width: 120, height: 120)
                        .offset(x: -80, y: 50)
                    
                    mountainSilhouette
                        .fill(Color.black.opacity(0.08))
                        .frame(height: 100)
                        .offset(y: 90)
                }
            )
#endif
            
            // Hero text
            VStack(alignment: .leading, spacing: 12) {
                Text("態沃果園")
                    .font(.system(size: 38, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                
                Text("新竹關西 · 支持小農 · 自產自銷")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.95))
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 1)
                
                HStack(spacing: 6) {
                    Image(systemName: "phone.fill")
                        .font(.caption)
                    Text("0911-897-739")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.farmGold)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(
                    Capsule()
                        .fill(Color.black.opacity(0.3))
                )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 50)
            .opacity(showBanner ? 1 : 0)
            .offset(x: showBanner ? 0 : -30)
        }
        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 30))
    }
    
    // MARK: - Mountain Silhouette
    private var mountainSilhouette: some Shape {
        MountainShape()
    }
    
    // MARK: - Announcement Banner
    private var announcementBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "megaphone.fill")
                .font(.title3)
                .foregroundColor(.farmOrange)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("🍊 香丁與蜜丁已開放預訂")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.farmBrown)
                Text("一周內即可出貨！")
                    .font(.system(size: 13))
                    .foregroundColor(.farmBrown.opacity(0.7))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.farmGreen)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .farmGreen.opacity(0.15), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
    }
    
    // MARK: - Season Highlight
    private var seasonHighlightSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.farmGold)
                Text("當季最鮮")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.farmDarkGreen)
            }
            .padding(.horizontal, 24)
            
            VStack(alignment: .leading, spacing: 14) {
                Text("柳丁香丁開採中！")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.farmBrown)
                
                Text("經過一年的灌溉與等待，辛勞的汗水，終結成甜美的果實。在張爸、張媽的細心栽培下，今年的香丁甜美收成！實實在在地打草，採取自然成熟工法，讓果物長出原有的酸甜滋味。")
                    .font(.system(size: 14))
                    .foregroundColor(.farmTextLight)
                    .lineSpacing(6)
                
                // Price tag
                HStack(spacing: 16) {
                    priceTag(weight: "10斤", price: "390元")
                    priceTag(weight: "20斤", price: "700元")
                }
                .padding(.top, 4)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 4)
            )
            .padding(.horizontal, 20)
        }
    }
    
    private func priceTag(weight: String, price: String) -> some View {
        VStack(spacing: 4) {
            Text(weight)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.farmGreen)
            Text(price)
                .font(.system(size: 20, weight: .heavy))
                .foregroundColor(.farmOrange)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.farmLightGreen.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.farmGreen.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Product Quick Cards
    private var productQuickCards: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("特色農產")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.farmDarkGreen)
                .padding(.horizontal, 24)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    productCard(imageName: "img_3", icon: "🍊", name: "日本種香丁", desc: "果肉細膩·入口沁甜", color: .farmOrange)
                    productCard(imageName: "img_6", icon: "🥝", name: "關西柚子", desc: "50年老樹·有溫度", color: .farmGreen)
                    productCard(imageName: "img_7", icon: "🫒", name: "苦茶油", desc: "自家栽種·純正天然", color: .farmBrown)
                    productCard(imageName: "img_8", icon: "🍵", name: "仙草茶", desc: "6小時熬煮·清熱退火", color: Color(red: 0.3, green: 0.3, blue: 0.3))
                    productCard(imageName: "img_10", icon: "🎃", name: "南瓜冬瓜", desc: "山上自種·新鮮直送", color: .farmGold)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
        }
    }
    
    private func productCard(imageName: String?, icon: String, name: String, desc: String, color: Color) -> some View {
        VStack(spacing: 12) {
#if os(iOS)
            if let img = imageName, UIImage(named: img) != nil {
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            } else {
                Text(icon)
                    .font(.system(size: 44))
            }
#else
            if let img = imageName {
                Image(img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            } else {
                Text(icon)
                    .font(.system(size: 44))
            }
#endif
            
            Text(name)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(color)
            
            Text(desc)
                .font(.system(size: 11))
                .foregroundColor(.farmTextLight)
                .multilineTextAlignment(.center)
        }
        .frame(width: 130, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: color.opacity(0.15), radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color.opacity(0.1), lineWidth: 1)
        )
    }
    
    // MARK: - Story Section
    private var storySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "book.fill")
                    .foregroundColor(.farmBrown)
                Text("農園故事")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.farmDarkGreen)
            }
            .padding(.horizontal, 24)
            
            VStack(spacing: 16) {
                storyCard(
                    story: StoryItem(
                        imageName: "img_9",
                        title: "客家老農靈魂人物",
                        preview: "張爸是純正的新竹關西客家人，年輕時北上台北打拼，後回到山上定居，成就了現在的態沃果園...",
                        fullContent: "張爸是純正的新竹關西客家人，年輕的時候北上台北打拼，依然不改率性的個性。幾乎三天兩頭就帶著家裡養的十幾條狗往山上打獵。因喜歡呼吸自由的空氣，不習慣都市的生活，後來就定居在果園山上，成就了現在的態沃果園。\n\n別看他滿臉鬍渣渣，這可是他的招牌！想當年老農爸也是「帥哥」一枚。\n\n或許是客家人本性關係，老農爸人很淳樸、很害羞，為人很客氣，但也很固執、很硬頸。",
                        icon: "person.fill",
                        color: .farmBrown
                    )
                )
                
                storyCard(
                    story: StoryItem(
                        imageName: "img_4",
                        title: "有溫度的柚子",
                        preview: "我們不僅賣柚子，也賣感情。重視每一位跟我們買水果的朋友...",
                        fullContent: "我們不僅賣柚子，也賣感情。重視每一位跟我們買水果的朋友。\n\n老爸種了50年以上的文旦柚，皮厚有水份，有酸有甜，就如同人生一般有溫度！\n\n柚子全身都是寶：\n・綠皮 → 自製清潔劑\n・白囊 → 柚皮糖\n・果肉 → 果醬/柚子茶",
                        icon: "heart.fill",
                        color: .farmOrange
                    )
                )
                
                storyCard(
                    story: StoryItem(
                        imageName: "img_5",
                        title: "是農人也是專家",
                        preview: "俗稱柳丁張博士，每天待在山上與果樹為伍，用鐵絲從橘子樹幹裡勾出毛毛蟲保護果樹...",
                        fullContent: "農事除了看天吃飯，也是要考驗農人的經驗及專業。我家老農爸爸，俗稱柳丁張博士，每天待在山上與果樹為伍，自然是經驗豐富！\n\n老農爸很得意地用鐵絲從橘子樹幹裡面勾出一條條的毛毛蟲，一邊勾蟲一邊開心的說：「這些蟲會吃樹幹，如果不勾出來，樹會死翹翹！你看！我已經勾出十幾條了...」\n\n這些經驗與專業，就跟老農爸滿是傷痕及細紋的手一樣，是歲月累積得來的。",
                        icon: "star.fill",
                        color: .farmGold
                    )
                )
            }
            .padding(.horizontal, 20)
        }
        .sheet(item: $selectedStory) { story in
            StoryDetailView(story: story)
        }
    }
    
    private func storyCard(story: StoryItem) -> some View {
        Button(action: {
            selectedStory = story
        }) {
            HStack(spacing: 16) {
#if os(iOS)
                if let img = story.imageName, UIImage(named: img) != nil {
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(story.color.opacity(0.15))
                            .frame(width: 60, height: 60)
                        Image(systemName: story.icon)
                            .font(.title3)
                            .foregroundColor(story.color)
                    }
                }
#else
                if let img = story.imageName {
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(story.color.opacity(0.15))
                            .frame(width: 60, height: 60)
                        Image(systemName: story.icon)
                            .font(.title3)
                            .foregroundColor(story.color)
                    }
                }
#endif
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(story.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.farmBrown)
                    Text(story.preview)
                        .font(.system(size: 12))
                        .foregroundColor(.farmTextLight)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.farmGreen.opacity(0.6))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - Contact Footer
    private var contactFooter: some View {
        VStack(spacing: 16) {
            Divider()
                .padding(.horizontal, 40)
            
            VStack(spacing: 12) {
                // Address - tappable to open Maps
                Button(action: {
                    if let url = URL(string: "https://maps.apple.com/?q=\("台北市文山區羅斯福路五段262號".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
                        openURL(url)
                    }
                }) {
                    Label("台北市文山區羅斯福路五段262號", systemImage: "mappin.circle.fill")
                        .font(.system(size: 13))
                        .foregroundColor(.farmTextLight)
                }
                
                // Phone numbers - tappable to call
                HStack(spacing: 20) {
                    Button(action: {
                        if let url = URL(string: "tel:0911897739") {
                            openURL(url)
                        }
                    }) {
                        Label("0911-897-739", systemImage: "phone.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.farmGreen)
                    }
                    
                    Button(action: {
                        if let url = URL(string: "tel:0229329378") {
                            openURL(url)
                        }
                    }) {
                        Label("(02) 2932-9378", systemImage: "phone.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.farmGreen)
                    }
                }
                
                // Line ID - tappable to open Line
                Button(action: {
                    if let url = URL(string: "https://line.me/ti/p/~jocy46520803") {
                        openURL(url)
                    }
                }) {
                    Label("Line ID: jocy46520803", systemImage: "message.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.farmGreen)
                }
                
                Text("© 2026 RichFarm 態沃果園")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.6))
                    .padding(.top, 4)
            }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Custom Shapes
struct MountainShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        path.move(to: CGPoint(x: 0, y: h))
        path.addLine(to: CGPoint(x: 0, y: h * 0.7))
        path.addCurve(
            to: CGPoint(x: w * 0.25, y: h * 0.2),
            control1: CGPoint(x: w * 0.08, y: h * 0.5),
            control2: CGPoint(x: w * 0.15, y: h * 0.15)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.5, y: h * 0.5),
            control1: CGPoint(x: w * 0.35, y: h * 0.25),
            control2: CGPoint(x: w * 0.42, y: h * 0.55)
        )
        path.addCurve(
            to: CGPoint(x: w * 0.75, y: h * 0.1),
            control1: CGPoint(x: w * 0.58, y: h * 0.45),
            control2: CGPoint(x: w * 0.65, y: h * 0.05)
        )
        path.addCurve(
            to: CGPoint(x: w, y: h * 0.6),
            control1: CGPoint(x: w * 0.85, y: h * 0.15),
            control2: CGPoint(x: w * 0.95, y: h * 0.5)
        )
        path.addLine(to: CGPoint(x: w, y: h))
        path.closeSubpath()
        
        return path
    }
}

struct RoundedShape: Shape {
    var corners: RectCorner
    var radius: CGFloat
    
    // Custom enum to replace UIRectCorner for cross-platform
    struct RectCorner: OptionSet {
        let rawValue: Int
        
        static let topLeft = RectCorner(rawValue: 1 << 0)
        static let topRight = RectCorner(rawValue: 1 << 1)
        static let bottomLeft = RectCorner(rawValue: 1 << 2)
        static let bottomRight = RectCorner(rawValue: 1 << 3)
        static let allCorners: RectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.width
        let h = rect.height
        let tr = min(min(self.radius, h/2), w/2)
        let tl = min(min(self.radius, h/2), w/2)
        let bl = min(min(self.radius, h/2), w/2)
        let br = min(min(self.radius, h/2), w/2)
        
        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        if corners.contains(.topRight) {
            path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: w, y: 0))
        }
        
        path.addLine(to: CGPoint(x: w, y: h - br))
        if corners.contains(.bottomRight) {
            path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: w, y: h))
        }
        
        path.addLine(to: CGPoint(x: bl, y: h))
        if corners.contains(.bottomLeft) {
            path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: h))
        }
        
        path.addLine(to: CGPoint(x: 0, y: tl))
        if corners.contains(.topLeft) {
            path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        path.closeSubpath()

        return path
    }
}
