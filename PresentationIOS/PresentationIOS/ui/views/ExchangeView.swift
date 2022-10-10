//
//  ExchangeView.swift
//  PresentationIOS
//
//  Created by 0x384c0 on 9/10/22.
//

import SwiftUI

struct ExchangeView:View{

    let exchangeType:ExchangeViewType
    let editable: Bool
    @Binding var currencies: [String]
    @Binding var currency: String?
    @Binding var amount: Double?
    @FocusState var isFocused: Bool

    @State private var showingAlert = false
    private let IMAGE_SIZE:CGFloat = 40
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencyCode = ""
        formatter.currencySymbol = ""
        return formatter
    }()

    var body: some View {
        VStack {
            HStack {
                Image(systemName: exchangeType.viewData.image)
                    .resizable()
                    .frame(width: IMAGE_SIZE,height: IMAGE_SIZE)
                    .foregroundColor(exchangeType.viewData.color)
                Text(exchangeType.viewData.text)
                    .font(.system(size: FontSize.medum, weight: .medium))
                    .padding([.leading], Padding.small)
                Spacer()
                TextField("", value: $amount, formatter: formatter)
                    .multilineTextAlignment(.trailing)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .allowsHitTesting(editable)
                    .foregroundColor(isFocused ? Color.primary : exchangeType.viewData.color)
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                        if let textField = obj.object as? UITextField {
                            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                        }
                    }
                Text(currency ?? "")
                    .onTapGesture { showingAlert = true }
                Image(systemName: "chevron.down")
                    .padding([.trailing], Padding.medum)
                    .confirmationDialog("SELECT_CURRENCY_FOR".localized + " " + exchangeType.viewData.text, isPresented: $showingAlert, titleVisibility: .visible) {
                        ForEach(currencies.filter{$0 != currency}, id: \.self) { text in
                            Button(text) { currency = text }
                        }
                    }
                    .onTapGesture { showingAlert = true }
            }
            .frame(maxWidth: .infinity)
            Divider().padding([.leading],IMAGE_SIZE + Padding.medum)
        }
    }
}

enum ExchangeViewType {
    case sell, receive

    var viewData:(
        image:String,
        color:Color,
        text:String
    ){
        switch self {
        case .sell:
            return (image:"arrow.up.circle.fill",
                    color: .red,
                    text:"SELL".localized)
        case .receive:
            return (image:"arrow.down.circle.fill",
                    color: .green,
                    text:"RECEIVE".localized)
        }
    }
}
