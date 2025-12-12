//
//  CreateProfileViewModel.swift
//  Ruku
//
//  Created by Vishal Singh on 10/12/25.
//

import SwiftUI
import PhotosUI

@MainActor
@Observable
final class CreateProfileViewModel {
    var name = ""
    var selectedGender: Gender = .male
    var email = ""
    var password = ""
    var avatarData: Data?
    var selectedPhoto: PhotosPickerItem? = nil
    var isPickerPresented = false
    
    var isSubmitting = false
    var submitError: String?
    
    var avatarImage: Image? {
        if let data = avatarData,
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
    var canSubmit: Bool {
        !isSubmitting && !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        if let data = try? await item.loadTransferable(type: Data.self) {
            await MainActor.run {
                withAnimation(.easeInOut(duration: 0.25)) {
                    self.avatarData = data
                }
            }
        }
    }
    
    func submit() async throws {
        guard canSubmit else { return }
        isSubmitting = true
        submitError = nil
        do {
            try await Task.sleep(nanoseconds: 600_000_000)
            // api call here
        } catch {
            submitError = error.localizedDescription
            throw error
        }
        isSubmitting = false
    }
}
