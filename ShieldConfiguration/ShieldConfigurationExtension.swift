//
//  ShieldConfigurationExtension.swift
//  ShieldConfiguration
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    // Customize for individual apps
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        return customShieldConfiguration()
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        return customShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        return customShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        return customShieldConfiguration()
    }
    
    // MARK: - Custom Shield Configuration
    private func customShieldConfiguration() -> ShieldConfiguration {
        return ShieldConfiguration(
            backgroundBlurStyle: .systemMaterialDark,
            backgroundColor: UIColor(red: 12/255, green: 62/255, blue: 62/255, alpha: 1),
            icon: emojiToImage("🙏"),
            title: ShieldConfiguration.Label(text: "Pause and Pray!", color: .white),
            subtitle: ShieldConfiguration.Label(
                text: " Take a moment to reflect and reconnect with your faith before diving into PrayScreen.\n\nOpen PrayScreen to complete your daily prayer 🙏",
                color: .white
            ),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Ok", color: .black),
            primaryButtonBackgroundColor: .white
        )
    }
    
    // MARK: - Convert Emoji to UIImage
    private func emojiToImage(_ emoji: String, fontSize: CGFloat = 100) -> UIImage {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let attributedString = NSAttributedString(string: emoji, attributes: attributes)
        let size = attributedString.size()
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            attributedString.draw(at: .zero)
        }
        return image
    }
}

