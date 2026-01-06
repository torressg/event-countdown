import Foundation
import Combine

class CountdownClockViewModel: ObservableObject {

    @Published var targetDate: Date
    private let countdownViewModel: CountdownViewModel

    init(targetDate: Date) {
        self.targetDate = targetDate
        self.countdownViewModel = CountdownViewModel()
        setupTimer()
    }

    private(set) lazy var flipViewModels = { (0...7).map { _ in FlipViewModel() } }()

    private func setupTimer() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [weak self] _ in
                guard let self = self else { return "" }
                return self.countdownViewModel.differenceString(to: self.targetDate)
            }
            .removeDuplicates()
            .sink { [weak self] countdownString in
                self?.setTimeInViewModels(time: countdownString)
            }
            .store(in: &cancellables)
        
        $targetDate
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.updateCountdown()
            }
            .store(in: &cancellables)
        
        updateCountdown()
    }

    func updateCountdown() {
        let countdownString = countdownViewModel.differenceString(to: targetDate)
        setTimeInViewModels(time: countdownString)
    }

    func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.text = "\(number)"
        }
    }

    private var cancellables = Set<AnyCancellable>()
}


