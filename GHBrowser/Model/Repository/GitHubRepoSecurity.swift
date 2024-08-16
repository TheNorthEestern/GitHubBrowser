import Foundation

struct GitHubRepoSecurity: Codable {
    struct AdvancedSecurity: Codable {
        let status: String
    }
    struct SecretScanning: Codable {
        let status: String
    }
    struct SecretScanningPushProtection: Codable {
        let status: String
    }
    struct SecretScanningNonProviderPatterns: Codable {
        let status: String
    }

    let advancedSecurity: AdvancedSecurity
    let secretScanning: SecretScanning
    let secretScanningPushProtection: SecretScanningPushProtection
    let secretScanningNonProviderPatterns: SecretScanningNonProviderPatterns

    enum CodingKeys: String, CodingKey {
        case advancedSecurity = "advanced_security"
        case secretScanning = "secret_scanning"
        case secretScanningPushProtection = "secret_scanning_push_protection"
        case secretScanningNonProviderPatterns = "secret_scanning_non_provider_patterns"
    }
}
