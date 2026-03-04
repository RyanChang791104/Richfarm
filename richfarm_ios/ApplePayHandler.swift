// ApplePayHandler.swift
// RichFarm - 態沃果園

#if os(iOS)
import PassKit
import SwiftUI

// MARK: - Apple Pay Manager
class ApplePayHandler: NSObject, ObservableObject, PKPaymentAuthorizationViewControllerDelegate {
    @Published var paymentSuccess = false
    @Published var paymentError: String?
    
    // TODO: Replace with your real Merchant ID from Apple Developer Portal
    static let merchantID = "merchant.com.richfarm.app"
    
    // Supported payment networks
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa, .masterCard, .amex, .JCB
    ]
    
    // Check if Apple Pay is available on this device
    static var isAvailable: Bool {
        PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: supportedNetworks)
    }
    
    // Start Apple Pay payment
    func startPayment(amount: Double, productName: String, completion: @escaping (Bool) -> Void) {
        self.completionHandler = completion
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = ApplePayHandler.merchantID
        request.supportedNetworks = ApplePayHandler.supportedNetworks
        request.merchantCapabilities = .capability3DS
        request.countryCode = "TW"
        request.currencyCode = "TWD"
        
        // Payment items
        let item = PKPaymentSummaryItem(
            label: productName,
            amount: NSDecimalNumber(value: amount)
        )
        let shipping = PKPaymentSummaryItem(
            label: "運費",
            amount: NSDecimalNumber(value: 100)
        )
        let total = PKPaymentSummaryItem(
            label: "態沃果園 RichFarm",
            amount: NSDecimalNumber(value: amount + 100),
            type: .final
        )
        request.paymentSummaryItems = [item, shipping, total]
        
        // Required shipping fields
        request.requiredShippingContactFields = [.name, .phoneNumber, .postalAddress]
        
        guard let controller = PKPaymentAuthorizationViewController(paymentRequest: request) else {
            completion(false)
            return
        }
        controller.delegate = self
        
        // Present the Apple Pay sheet
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            var topController = rootViewController
            while let presented = topController.presentedViewController {
                topController = presented
            }
            topController.present(controller, animated: true)
        }
    }
    
    // MARK: - PKPaymentAuthorizationViewControllerDelegate
    
    private var completionHandler: ((Bool) -> Void)?
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }
    
    func paymentAuthorizationViewController(
        _ controller: PKPaymentAuthorizationViewController,
        didAuthorizePayment payment: PKPayment,
        handler completion: @escaping (PKPaymentAuthorizationResult) -> Void
    ) {
        // In production, send payment.token to your server for processing
        // For now, simulate a successful payment
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.paymentSuccess = true
            self?.completionHandler?(true)
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }
    }
}

// MARK: - Apple Pay Button (SwiftUI wrapper)
struct ApplePayButtonView: UIViewRepresentable {
    var action: () -> Void
    
    func makeUIView(context: Context) -> PKPaymentButton {
        let button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: PKPaymentButton, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    
    class Coordinator: NSObject {
        var action: () -> Void
        init(action: @escaping () -> Void) {
            self.action = action
        }
        @objc func buttonTapped() {
            action()
        }
    }
}
#endif
