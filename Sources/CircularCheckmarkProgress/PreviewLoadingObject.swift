import Combine
import SwiftUI

// This is only used for showing actual data in the preview of
// CircularCheckmarkProgressViewStyle.swift. It's not public API.

class PreviewLoadingObject: ObservableObject {
    @Published var progress: Progress
    @Published var finished = false
    private var timer: AnyCancellable?

    var timerIteration: TimeInterval
    let totalUnitCount: Int64 = 100

    init(period: TimeInterval) {
        progress = Progress(totalUnitCount: totalUnitCount)
        timerIteration = period / Double(totalUnitCount)
    }

    func start() {
        timer = Timer.publish(every: timerIteration, on: .main, in: .common)
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
