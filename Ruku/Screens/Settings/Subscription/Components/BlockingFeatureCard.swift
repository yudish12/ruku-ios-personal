//
//  BlockingFeatureCard.swift
//  Ruku
//
//  Created by Vishal Singh on 22/12/25.
//

import SwiftUI

struct BlockingFeatureCard: View {
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Blocking Feature")
                .font(.inter(weight: .medium, size: 18))
                .foregroundStyle(Color.textSecondaryColor)
            
            HStack(spacing: 16) {
                
                // MARK: Start Date
                VStack(alignment: .leading, spacing: 6) {
                    Text("Start Date")
                        .font(.inter(weight: .medium, size: 12))
                        .foregroundStyle(Color.textSecondaryColor)
                    
                    DateFieldView(date: $startDate, placeholder: "From")
                }
                
                // MARK: End Date
                VStack(alignment: .leading, spacing: 6) {
                    Text("End Date")
                        .font(.inter(weight: .medium, size: 12))
                        .foregroundStyle(Color.textSecondaryColor)
                    
                    DateFieldView(date: $endDate, placeholder: "To")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 25)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        
    }
}


#Preview {
    BlockingFeatureCard()
}
