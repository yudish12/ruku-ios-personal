import SwiftUI
import PhotosUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject { 
    // MARK: - Login Fields
    @Published var loginEmail = ""
    @Published var loginPassword = ""
    
    // MARK: - Create Profile Fields
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var selectedGender: Gender = .male
    @Published var avatarData: Data?
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var isPickerPresented = false
    
    // MARK: - OTP
    @Published var otp = ""
    
    // MARK: - State
    @Published var isSubmitting: Bool = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    var canSubmit: Bool {
        !name.isEmpty && !email.isEmpty && !password.isEmpty
    }

    
    // MARK: - Computed
    var avatarImage: Image? {
        if let data = avatarData,
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
    
    // MARK: - Image Loader
    func loadImage(from item: PhotosPickerItem?) async {
        guard let item else { return }
        if let data = try? await item.loadTransferable(type: Data.self) {
            withAnimation(.easeInOut(duration: 0.25)) {
                self.avatarData = data
            }
        }
    }
    
    // MARK: - Login API
    func login() async throws {
        isLoading = true
        errorMessage = nil
        
        try await Task.sleep(nanoseconds: 600_000_000)
        // call login API
        
        isLoading = false
    }
    
    // MARK: - Create Profile API
    func createProfile() async throws {
        isLoading = true
        errorMessage = nil
        
        try await Task.sleep(nanoseconds: 600_000_000)
        // call profile API
        
        isLoading = false
    }
    
    // MARK: - OTP API
    func verifyOTP() async throws {
        isLoading = true
        errorMessage = nil
        
        try await Task.sleep(nanoseconds: 600_000_000)
        // call OTP API
        
        isLoading = false
    }
}

