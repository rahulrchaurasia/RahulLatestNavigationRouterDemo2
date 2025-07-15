//
//  FloatingLabelTextField.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI

import SwiftUI

struct FloatingLabelTextField: View {
    // The placeholder text to show
    let placeholder: String
    
    // The binding to the text value
    @Binding var text: String
    
    // Tracks the focus state of the TextField
    @FocusState private var isFocused: Bool
    
    // A computed property to decide if the label should float
    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }
    
    var body: some View {
        // ZStack layers the TextField and the placeholder Text
        ZStack(alignment: .leading) {
            // The placeholder Text view
            Text(placeholder)
                .font(shouldFloat ? .caption : .body) // Smaller font when floating
                .foregroundColor(.gray)
                .offset(y: shouldFloat ? -25 : 0) // Move up when floating
            
            // The actual TextField for text input
            TextField("", text: $text)
                .focused($isFocused) // Bind the focus state
                .font(.body)
        }
        .padding(.top, 15) // Add padding to make space for the floating label
        .animation(.easeInOut(duration: 0.2), value: shouldFloat) // Animate the change
        .overlay(
            // Add a bottom line for styling
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isFocused ? .blue : .gray),
            alignment: .bottom
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
            @State private var emptyText: String = ""
            @State private var filledText: String = "hello@example.com"
            
            var body: some View {
                VStack(spacing: 40) {
                    FloatingLabelTextField(
                        placeholder: "Empty Field",
                        text: $emptyText
                    )
                    
                    FloatingLabelTextField(
                        placeholder: "Filled Field",
                        text: $filledText
                    )
                }
                .padding()
            }
        }
        return PreviewWrapper()
}
