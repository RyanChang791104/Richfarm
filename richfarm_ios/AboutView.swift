// AboutView.swift
// RichFarm - 態沃果園

import SwiftUI

struct AboutView: View {
    @State private var expandedSection: Int? = nil
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    // MARK: - Farm Header
                    farmHeader
                    
                    // MARK: - Mission Statement
                    missionCard
                    
                    // MARK: - Story Sections
                    storySection(
                        index: 0,
                        imageName: "img_9",
                        icon: "👨‍🌾",
                        title: "客家老農靈魂人物",
                        subtitle: "張爸 · 圓球 · 柳丁張博士",
                        content: """
                        張爸是純正的新竹關西客家人，年輕的時候北上台北打拼，依然不改率性的個性。幾乎三天兩頭就帶著家裡養的十幾條狗往山上打獵。因喜歡呼吸自由的空氣，不習慣都市的生活，後來就定居在果園山上，成就了現在的態沃果園。

                        別看他滿臉鬍渣渣，這可是他的招牌！想當年老農爸也是「帥哥」一枚。

                        或許是客家人本性關係，老農爸人很淳樸、很害羞，為人很客氣，但也很固執、很硬頸。

                        為了讓果園的果樹結實壘壘又好吃，不但加入了柑橘產銷班，也親自與學校教授請益，後來便把一般肥料改成有機肥。

                        後來健康主義意識抬頭，老農爸把耕作方式改為自然農法——一般種植要撒十四次農藥，老爸只撒四次。所以我們的水果都醜醜的，但隨著經驗豐富，水果也越種越好吃！
                        """,
                        color: .farmBrown
                    )
                    
                    storySection(
                        index: 1,
                        imageName: "img_5",
                        icon: "🔬",
                        title: "是農人也是專家",
                        subtitle: "經驗就是最好的老師",
                        content: """
                        農事除了看天吃飯，也是要考驗農人的經驗及專業。我家老農爸爸，俗稱柳丁張博士，每天待在山上與果樹為伍，自然是經驗豐富！

                        老農爸很得意地用鐵絲從橘子樹幹裡面勾出一條條的毛毛蟲，一邊勾蟲一邊開心的說：「這些蟲會吃樹幹，如果不勾出來，樹會死翹翹！你看！我已經勾出十幾條了...」

                        這些經驗與專業，就跟老農爸滿是傷痕及細紋的手一樣，是歲月累積得來的。
                        """,
                        color: .farmGold
                    )
                    
                    storySection(
                        index: 2,
                        imageName: "img_4",
                        icon: "🌄",
                        title: "老農的背影",
                        subtitle: "一年一產的珍貴果實",
                        content: """
                        小編小學時讀過朱自清的背影，現在看到自己爸爸的背影，也跟朱自清有同樣的感受！

                        今年因為氣候關係，香丁產量不如往年，但依然香甜好吃。老農爸種植一年只有一產的香丁，付出了很大的精神與力氣。

                        農夫真的是個辛苦活兒，需要很大的體力，難怪從小就聽老農爸說三餐都要吃飯，還要吃好幾碗，才有體力工作！
                        """,
                        color: .farmGreen
                    )
                    
                    storySection(
                        index: 3,
                        imageName: "img_11",
                        icon: "☀️",
                        title: "豔陽高照",
                        subtitle: "每一天都是果園日常",
                        content: """
                        今天一樣豔陽高照，一大早老農爸爸就跑去照顧柚子朋友。老爸說要把枯枝剪掉，要不然會傳染給柚子長黑點點。

                        小編希望每一位柚子朋友都能夠頭好壯壯，又香又甜，才不會辜負老農爸爸辛苦的付出呢！
                        """,
                        color: .farmOrange
                    )
                    
                    // MARK: - Location
                    locationCard
                    
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
                    Text("關於我們")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.farmDarkGreen)
                }
            }
        }
    }
    
    // MARK: - Farm Header
    private var farmHeader: some View {
        ZStack {
            Image("img_3")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 30))
                .overlay(
                    RoundedShape(corners: [.bottomLeft, .bottomRight], radius: 30)
                        .fill(Color.black.opacity(0.5))
                )
            
            VStack(spacing: 12) {
                Text("態沃果園")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
                Text("新竹關西 · 自然農法 · 50年果園")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.95))
                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
            }
        }
    }
    
    // MARK: - Mission Card
    private var missionCard: some View {
        VStack(spacing: 12) {
            Text("💚 我們的理念")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.farmDarkGreen)
            
            Text("我們是來自新竹關西山上的小農果園，因為食安問題，我們選擇自己栽種苦茶籽，山上也種植了各式各樣的農作物。自己種植自己料理，不愛外食，希望能夠為家人也為大家健康把關！")
                .font(.system(size: 14))
                .foregroundColor(.farmTextLight)
                .lineSpacing(6)
                .multilineTextAlignment(.center)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .farmGreen.opacity(0.1), radius: 12, x: 0, y: 4)
        )
        .padding(.horizontal, 20)
    }
    
    // MARK: - Story Section
    private func storySection(index: Int, imageName: String?, icon: String, title: String, subtitle: String, content: String, color: Color) -> some View {
        VStack(spacing: 0) {
            // Header (tappable)
            Button(action: {
                withAnimation(.spring(response: 0.4)) {
                    expandedSection = expandedSection == index ? nil : index
                }
            }) {
                HStack(spacing: 14) {
                    if let img = imageName {
                        Image(img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 46, height: 46)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
                        Text(icon)
                            .font(.system(size: 32))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.farmBrown)
                        Text(subtitle)
                            .font(.system(size: 12))
                            .foregroundColor(.farmTextLight)
                    }
                    
                    Spacer()
                    
                    Image(systemName: expandedSection == index ? "chevron.up.circle.fill" : "chevron.down.circle")
                        .font(.title3)
                        .foregroundColor(color.opacity(0.6))
                }
                .padding(18)
            }
            
            // Expandable Content
            if expandedSection == index {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.horizontal, 18)
                    Text(content)
                        .font(.system(size: 14))
                        .foregroundColor(.farmTextLight)
                        .lineSpacing(7)
                        .padding(18)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .shadow(color: color.opacity(0.08), radius: 8, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(color.opacity(0.1), lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
    
    // MARK: - Location Card
    private var locationCard: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "map.fill")
                    .foregroundColor(.farmGreen)
                Text("果園位置")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.farmDarkGreen)
            }
            
            VStack(spacing: 8) {
                Text("🏔️ 果園：新竹縣關西鎮")
                    .font(.system(size: 14))
                Text("🏢 聯絡處：台北市文山區羅斯福路五段262號")
                    .font(.system(size: 14))
                Text("搜尋：「關西張爸香丁農園」")
                    .font(.system(size: 13))
                    .foregroundColor(.farmGreen)
                    .italic()
            }
            .foregroundColor(.farmTextLight)
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
        )
        .padding(.horizontal, 20)
    }
}
