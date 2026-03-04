// OrderNotificationService.swift
// RichFarm - 態沃果園

import Foundation
import SwiftUI

// MARK: - Order Details Model
struct OrderDetails {
    let name: String
    let phone: String
    let address: String
    let product: String
    let quantity: Int
    let paymentMethod: String
    let notes: String
}

// MARK: - Order Notification Service (Google Sheets)
class OrderNotificationService: ObservableObject {
    @Published var isSending = false
    @Published var sendResult: SendResult?
    
    enum SendResult {
        case success
        case failure(String)
    }
    
    // ============================================================
    // TODO: 請將下方 URL 替換為您的 Google Apps Script 部署網址
    // 設定步驟請參考 GoogleAppsScript_OrderWebhook.js
    // ============================================================
    static let googleScriptURL = "https://script.google.com/macros/s/AKfycbxM1NOVy9eMRw6WSl25Fl7tEdT5WCZNDuaECNWXX-JeYSl6URfot-emPNwecQ21jgVr/exec"
    
    // MARK: - Send Order to Google Sheets
    func sendOrder(_ order: OrderDetails, completion: @escaping (Bool) -> Void) {
        isSending = true
        
        let baseURL = OrderNotificationService.googleScriptURL
        
        guard baseURL != "YOUR_GOOGLE_APPS_SCRIPT_URL_HERE" else {
            DispatchQueue.main.async {
                self.isSending = false
                self.sendResult = .failure("請先設定 Google Apps Script URL")
                completion(true)
            }
            return
        }
        
        // Build URL with query parameters (GET works reliably with Google Apps Script)
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "name", value: order.name),
            URLQueryItem(name: "phone", value: order.phone),
            URLQueryItem(name: "address", value: order.address),
            URLQueryItem(name: "product", value: order.product),
            URLQueryItem(name: "quantity", value: String(order.quantity)),
            URLQueryItem(name: "paymentMethod", value: order.paymentMethod),
            URLQueryItem(name: "notes", value: order.notes)
        ]
        
        guard let url = components.url else {
            DispatchQueue.main.async {
                self.isSending = false
                self.sendResult = .failure("URL 格式錯誤")
                completion(false)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isSending = false
                
                if let error = error {
                    self?.sendResult = .failure(error.localizedDescription)
                    completion(false)
                    return
                }
                
                // Any response means the request reached Google
                self?.sendResult = .success
                completion(true)
            }
        }.resume()
    }
}
