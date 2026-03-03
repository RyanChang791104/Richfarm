// CookingView.swift
// RichFarm - 態沃果園

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let ingredient: String
    let steps: [String]
    let difficulty: String
    let time: String
    let color: Color
}

struct CookingView: View {
    let recipes: [Recipe] = [
        Recipe(
            emoji: "🧴",
            title: "柚皮天然清潔劑",
            ingredient: "柚子第一層綠皮、酒精",
            steps: [
                "將柚子最外層的綠皮削下",
                "把綠皮切成細絲",
                "用酒精浸泡綠皮絲",
                "靜置數日後即可使用",
                "可用於洗碗、洗奶瓶，天然無化學添加"
            ],
            difficulty: "⭐",
            time: "3-7天",
            color: .farmGreen
        ),
        Recipe(
            emoji: "🍬",
            title: "柚皮天然軟糖",
            ingredient: "柚子第二層白囊、細白糖",
            steps: [
                "取出柚子第二層厚厚的白囊",
                "將白囊切成塊狀",
                "滾上細白糖",
                "就像法國軟糖一樣的台灣軟糖！",
                "純天然製作，最適合當孩子的零嘴",
                "也可當大人的下午茶點心"
            ],
            difficulty: "⭐⭐",
            time: "30分鐘",
            color: .farmOrange
        ),
        Recipe(
            emoji: "🍯",
            title: "柚子果醬",
            ingredient: "柚子果肉、糖",
            steps: [
                "取出柚子果肉，去籽",
                "將果肉與適量的糖一起熬煮",
                "小火慢熬至濃稠",
                "放涼裝瓶",
                "可塗吐司當早餐果醬",
                "也可泡成柚子茶飲用"
            ],
            difficulty: "⭐⭐",
            time: "1小時",
            color: .farmGold
        ),
        Recipe(
            emoji: "🍲",
            title: "仙草雞湯",
            ingredient: "整瓶仙草茶（不加水）、雞肉",
            steps: [
                "準備一整瓶仙草茶",
                "不加任何一滴水！",
                "將雞肉放入鍋中",
                "倒入整瓶仙草茶",
                "大火煮滾後轉小火燉煮",
                "客家爸媽的最愛料理！"
            ],
            difficulty: "⭐⭐⭐",
            time: "1.5小時",
            color: .farmBrown
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("👩‍🍳 私房料理教您做")
                            .font(.system(size: 26, weight: .heavy))
                            .foregroundColor(.farmDarkGreen)
                        Text("柚子全身都是寶 · 仙草創意料理")
                            .font(.system(size: 14))
                            .foregroundColor(.farmTextLight)
                    }
                    .padding(.top, 10)
                    
                    // Tip Banner
                    tipBanner
                    
                    // Recipe Cards
                    ForEach(recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                    
                    Spacer(minLength: 40)
                }
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
                    Text("私房料理")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.farmDarkGreen)
                }
            }
        }
    }
    
    private var tipBanner: some View {
        HStack(spacing: 12) {
            Text("💡")
                .font(.system(size: 28))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("小知識")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.farmBrown)
                Text("吃完柚子千萬不要把皮丟掉！不管是最外層的綠皮、第二層白囊、到最裡面的果肉，全都有用處！")
                    .font(.system(size: 12))
                    .foregroundColor(.farmTextLight)
                    .lineSpacing(4)
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.farmCream)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.farmGold.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(.horizontal, 20)
    }
}

// MARK: - Recipe Card
struct RecipeCardView: View {
    let recipe: Recipe
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Card Header
            Button(action: {
                withAnimation(.spring(response: 0.4)) {
                    isExpanded.toggle()
                }
            }) {
                HStack(spacing: 14) {
                    // Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(recipe.color.opacity(0.12))
                            .frame(width: 56, height: 56)
                        Text(recipe.emoji)
                            .font(.system(size: 28))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.title)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.farmBrown)
                        
                        HStack(spacing: 12) {
                            Label(recipe.difficulty, systemImage: "flame")
                                .font(.system(size: 11))
                            Label(recipe.time, systemImage: "clock")
                                .font(.system(size: 11))
                        }
                        .foregroundColor(.farmTextLight)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle")
                        .font(.title3)
                        .foregroundColor(recipe.color.opacity(0.6))
                }
                .padding(18)
            }
            
            // Expanded Content
            if isExpanded {
                VStack(alignment: .leading, spacing: 14) {
                    Divider()
                        .padding(.horizontal, 18)
                    
                    // Ingredients
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "basket.fill")
                            .foregroundColor(recipe.color)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("材料")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.farmBrown)
                            Text(recipe.ingredient)
                                .font(.system(size: 13))
                                .foregroundColor(.farmTextLight)
                        }
                    }
                    .padding(.horizontal, 18)
                    
                    // Steps
                    VStack(alignment: .leading, spacing: 10) {
                        Text("📝 作法步驟")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.farmBrown)
                            .padding(.horizontal, 18)
                        
                        ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                            HStack(alignment: .top, spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(recipe.color.opacity(0.15))
                                        .frame(width: 26, height: 26)
                                    Text("\(index + 1)")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(recipe.color)
                                }
                                
                                Text(step)
                                    .font(.system(size: 14))
                                    .foregroundColor(.farmTextLight)
                                    .lineSpacing(4)
                            }
                            .padding(.horizontal, 18)
                        }
                    }
                    .padding(.bottom, 18)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: recipe.color.opacity(0.1), radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(recipe.color.opacity(0.08), lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
}
