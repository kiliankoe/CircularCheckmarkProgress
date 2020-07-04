import SwiftUI

extension ProgressViewStyleConfiguration {
    var isFinished: Bool {
        (fractionCompleted ?? 0) >= 1.0
    }
}
