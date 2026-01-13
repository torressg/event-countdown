import Foundation
import SwiftUI
import Combine

enum AppLanguage: String, CaseIterable {
    case system = "system"
    case portuguese = "pt-BR"
    case english = "en"
    
    var displayName: String {
        switch self {
        case .system:
            return "language_system".localized
        case .portuguese:
            return "language_portuguese".localized
        case .english:
            return "language_english".localized
        }
    }
    
    var code: String? {
        switch self {
        case .system:
            return nil
        case .portuguese:
            return "pt-BR"
        case .english:
            return "en"
        }
    }
}

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: AppLanguage {
        didSet {
            saveLanguagePreference()
            updateBundle()
        }
    }
    
    private var bundle: Bundle = Bundle.main
    private let userDefaultsKey = "user_selected_language"
    
    init() {
        if let savedLanguage = UserDefaults.standard.string(forKey: userDefaultsKey),
           let language = AppLanguage(rawValue: savedLanguage) {
            self.currentLanguage = language
        } else {
            self.currentLanguage = .system
        }
        updateBundle()
    }
    
    private func saveLanguagePreference() {
        UserDefaults.standard.set(currentLanguage.rawValue, forKey: userDefaultsKey)
    }
    
    private func updateBundle() {
        let languageCode: String
        
        if currentLanguage == .system {
            let systemLanguage = Locale.current.language.languageCode?.identifier ?? "en"
            languageCode = mapSystemLanguageToAppLanguage(systemLanguage)
        } else {
            languageCode = currentLanguage.code ?? "en"
        }
        
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let newBundle = Bundle(path: path) {
            bundle = newBundle
        } else if let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
                  let fallbackBundle = Bundle(path: path) {
            bundle = fallbackBundle
        } else {
            bundle = Bundle.main
        }
    }
    
    private func mapSystemLanguageToAppLanguage(_ systemCode: String) -> String {
        switch systemCode {
        case "pt":
            return "pt-BR"
        case "en":
            return "en"
        default:
            return "en"
        }
    }
    
    func localizedString(_ key: String) -> String {
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    func setLanguage(_ language: AppLanguage) {
        currentLanguage = language
    }
    
    var currentLocale: Locale {
        let languageCode: String
        
        if currentLanguage == .system {
            return Locale.current
        } else {
            languageCode = currentLanguage.code ?? "en"
            return Locale(identifier: languageCode)
        }
    }
}

