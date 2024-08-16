import Foundation

enum LoadingState: Equatable {
    case done
    case failure(Error)
    case loading

    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.done, .done), (.loading, .loading):
            return true
        case (.failure, .failure):
            return true // Ignoring the actual Error comparison
        default:
            return false
        }
    }
}
