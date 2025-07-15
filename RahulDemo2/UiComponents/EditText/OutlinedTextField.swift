//
//  OutlinedTextField.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 15/07/25.
//

import SwiftUI



import SwiftUI



import SwiftUI

struct OutlinedTextField: View {
    let placeholder: String
    @Binding var text: String
    
    @FocusState private var isFocused: Bool
    
    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }
    
    private var activeColor: Color {
        isFocused ? .blue : .gray
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            // Layer 1: The Border
            RoundedRectangle(cornerRadius: 8)
                .stroke(activeColor, lineWidth: isFocused ? 2 : 1)
            
            // Layer 2: The Label
            Text(placeholder)
                .foregroundColor(activeColor)
                .font(shouldFloat ? .caption : .body)
                // --- THE ROBUST FIX IS HERE ---
                // 1. Add horizontal padding ONLY when the label is floating.
                //    This creates the wide gap in the border.
                .padding(.horizontal, shouldFloat ? 6 : 0)
                // 2. Apply a background ONLY when floating to complete the cutout.
                .background(shouldFloat ? Color(UIColor.systemBackground) : Color.clear)
                .scaleEffect(shouldFloat ? 0.8 : 1.0, anchor: .leading)
                .offset(y: shouldFloat ? -28 : 0)
                .padding(.leading, 12)

            // Layer 3: The Text Field
            TextField("", text: $text)
                .focused($isFocused)
                .padding(.horizontal, 10)
        }
        .animation(.easeInOut(duration: 0.2), value: shouldFloat)
        .frame(height: 56)
    }
}

//#Preview {
//    OutlinedTextField()
//}
#Preview {
    // A simple container view to demonstrate the component in different states.
    struct PreviewWrapper: View {
        @State private var emptyText: String = ""
        @State private var filledText: String = "hello@example.com"
        
        var body: some View {
            VStack(spacing: 40) {
                Text("OutlinedTextField Preview")
                    .font(.title)
                
                // State 1: Empty field
                OutlinedTextField(
                    placeholder: "First Name",
                    text: $emptyText
                )
                
                // State 2: Pre-filled field
                OutlinedTextField(
                    placeholder: "Email Address",
                    text: $filledText
                )
            }
            .padding()
        }
    }
    
    // Return the wrapper view for previewing.
    return PreviewWrapper()
}
