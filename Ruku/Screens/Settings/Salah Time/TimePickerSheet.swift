//
//  TimePickerSheet.swift
//  Ruku
//
//  Created by Vishal Singh on 17/12/25.
//

import SwiftUI

struct TimePickerSheet: View {
    @Binding var time: Date
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .font(.inter(weight: .bold, size: 16))
                        .foregroundStyle(.black)
                }

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.inter(weight: .bold, size: 16))
                        .foregroundStyle(.black)
                }
            }
            .padding()

            Divider()

            DatePicker(
                "",
                selection: $time,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
        }
        .presentationDetents([.height(300)])
    }
}

#Preview {
    TimePickerSheet(time: .constant(Date()))
}
