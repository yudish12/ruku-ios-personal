//
//  DateFieldView.swift
//  Ruku
//
//  Created by Vishal Singh on 22/12/25.
//

import SwiftUI

struct DateFieldView: View {
    @Binding var date: Date?
    let placeholder: String
    
    @State private var showPicker: Bool = false
    @State private var tempDate: Date = Date()
    
    var body: some View {
        HStack {
            if let date {
                Text(date.formatted(date: .numeric, time: .omitted))
                    .foregroundColor(.primary)
            } else {
                Text(placeholder)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Image(systemName: "calendar")
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.lightGrayColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .contentShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            showPicker = true
        }
        .sheet(isPresented: $showPicker) {
            NavigationStack {
                DatePicker(
                    "",
                    selection: $tempDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .navigationTitle("Select Date")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            showPicker = false
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            date = tempDate
                            showPicker = false
                        }
                    }
                }
            }
            .presentationDetents([.height(350)])
        }
    }
}

#Preview {
    DateFieldView(date: .constant(Date()), placeholder: "From")
}
