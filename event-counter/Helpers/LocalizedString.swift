import Foundation

extension String {
    var localized: String {
        return LanguageManager.shared.localizedString(self)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        let localizedString = LanguageManager.shared.localizedString(self)
        return String(format: localizedString, arguments: arguments)
    }
}

