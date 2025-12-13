//
//  AvatarPickerView.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI

struct AvatarPickerView: View {
    let image: Image?
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Group {
                if let selectedImage = image {
                    selectedImage
                        .resizable()
                } else {
                    Image("camera")
                        .resizable()
                }
            }
            .scaledToFill()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            
            Button(action: action) {
                Text(image == nil ? "Upload Avatar" : "Change Avatar")
                    .font(.inter(weight: .bold, size: 16))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .foregroundStyle(Color.backgroundTealColor)
                    .background(.white)
                    .cornerRadius(12)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AvatarPickerView(image: nil, action: {})
}
