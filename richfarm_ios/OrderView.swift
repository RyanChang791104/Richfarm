// OrderView.swift
// RichFarm - 態沃果園

import SwiftUI

struct OrderView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var selectedProduct = "日本種香丁 (10斤 - 390元)"
    @State private var quantity = 1
    @State private var notes = ""
    @State private var paymentMethod = "貨到付款"
    @State private var isSubmitting = false
    @State private var showSuccessAlert = false
    
    let products = [
        "日本種香丁 (10斤 - 390元)",
        "日本種香丁 (20斤 - 700元)",
        "柳丁 (依季節報價)",
        "關西仙草茶 (瓶裝)",
        "純手工苦茶油 (瓶裝)",
        "關西柚子 (依產量)",
        "南瓜・冬瓜 (依產量)"
    ]
    
    let paymentMethods = ["貨到付款", "銀行轉帳", "面交自取"]
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Banner Section
                Section {
                    VStack(alignment: .center, spacing: 12) {
                        Image(systemName: "shippingbox.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.farmOrange)
                            .padding(.top, 10)
                        
                        Text("支持小農 · 產地直送")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.farmDarkGreen)
                        
                        Text("請填寫您的訂購資訊，我們將會在確認訂單後與您聯繫後續出貨事宜。")
                            .font(.system(size: 13))
                            .foregroundColor(.farmTextLight)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 10)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                
                // MARK: - Contact Info
                Section(header: Text("聯絡資訊").foregroundColor(.farmDarkGreen)) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.farmGreen)
                            .frame(width: 20)
                        TextField("收件人姓名", text: $name)
                    }
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.farmGreen)
                            .frame(width: 20)
                        TextField("聯絡電話", text: $phone)
#if os(iOS)
                            .keyboardType(.phonePad)
#endif
                    }
                    
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundColor(.farmGreen)
                            .frame(width: 20)
                        TextField("收件地址", text: $address)
                    }
                }
                
                // MARK: - Order Details
                Section(header: Text("訂購商品").foregroundColor(.farmDarkGreen),
                        footer: Text("運費說明：北北基100元 / 中南部150元").font(.caption)) {
                    
                    Picker(selection: $selectedProduct, label: HStack {
                        Image(systemName: "leaf.fill").foregroundColor(.farmGreen).frame(width: 20)
                        Text("選擇商品")
                    }) {
                        ForEach(products, id: \.self) { product in
                            Text(product).tag(product)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Stepper(value: $quantity, in: 1...20) {
                        HStack {
                            Image(systemName: "number.square.fill")
                                .foregroundColor(.farmGreen)
                                .frame(width: 20)
                            Text("數量: \(quantity)")
                        }
                    }
                    
                    Picker(selection: $paymentMethod, label: HStack {
                        Image(systemName: "creditcard.fill").foregroundColor(.farmGreen).frame(width: 20)
                        Text("付款方式")
                    }) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method).tag(method)
                        }
                    }
                }
                
                // MARK: - Notes
                Section(header: Text("備註").foregroundColor(.farmDarkGreen)) {
                    TextEditor(text: $notes)
                        .frame(height: 80)
                        .overlay(
                            VStack {
                                if notes.isEmpty {
                                    HStack {
                                        Text("指定送貨時間或其他需求...")
                                            .foregroundColor(.farmTextLight)
                                            .padding(.top, 8)
                                            .padding(.leading, 5)
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        )
                }
                
                // MARK: - Submit Button
                Section {
                    Button(action: submitOrder) {
                        HStack {
                            Spacer()
                            if isSubmitting {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("送出訂單")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            Spacer()
                        }
                        .foregroundColor(.white)
                    }
                    .listRowBackground(
                        name.isEmpty || phone.isEmpty || address.isEmpty ? 
                        Color.gray.opacity(0.5) : Color.farmGreen
                    )
                    .disabled(name.isEmpty || phone.isEmpty || address.isEmpty || isSubmitting)
                }
                
                // MARK: - Contact Info Alternative
                Section {
                    VStack(alignment: .center, spacing: 8) {
                        Text("您也可以直接來電訂購：")
                            .font(.system(size: 13))
                            .foregroundColor(.farmTextLight)
                        
                        Button(action: {
                            // Call action
                        }) {
                            Text("📞 0911-897-739 (張媽媽)")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.farmOrange)
                        }
                        
                        Text("Line ID: jocy46520803")
                            .font(.system(size: 13))
                            .foregroundColor(.farmBrown)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
            }
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("下訂單")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.farmDarkGreen)
                }
            }
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("訂單已送出"),
                    message: Text("感謝您的訂購！我們將會盡快與您聯繫確認訂單內容。\n\n如果有任何問題，歡迎隨時來電 0911-897-739。"),
                    dismissButton: .default(Text("確定")) {
                        // Reset form
                        name = ""
                        phone = ""
                        address = ""
                        quantity = 1
                        notes = ""
                    }
                )
            }
        }
    }
    
    private func submitOrder() {
        isSubmitting = true
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isSubmitting = false
            showSuccessAlert = true
        }
    }
}
