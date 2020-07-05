import Combine
import SwiftUI

// This is only used for showing actual data in the preview of
// CircularCheckmarkProgressViewStyle.swift. It's not public API.

class PreviewLoadingObject: ObservableObject {
    @Published var progress: Progress
    @Published var finished = false
    private var timer: AnyCancellable?

    init() {
        progress = Progress(totalUnitCount: 100)
    }

    func start() {
        timer = Timer.publish(every: 0.025, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.progress.completedUnitCount += 1
                if self.progress.isFinished {
                    self.timer = nil
                    self.finished = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.finished = false
                        self.progress.completedUnitCount = 0
                        self.start()
                    }
                }
            }
    }
}
