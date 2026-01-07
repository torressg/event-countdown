import SwiftUI

struct CountdownClockView: View {

    @ObservedObject var viewModel: CountdownClockViewModel
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[0])
                        FlipView(viewModel: viewModel.flipViewModels[1])
                    }
                    Text("month_text".localized,)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[2])
                        FlipView(viewModel: viewModel.flipViewModels[3])
                    }
                    Text("day_text".localized,)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[4])
                        FlipView(viewModel: viewModel.flipViewModels[5])
                    }
                    Text("hour_text".localized,)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[6])
                        FlipView(viewModel: viewModel.flipViewModels[7])
                    }
                    Text("Min")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

