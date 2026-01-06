import SwiftUI

struct CountdownClockView: View {

    @ObservedObject var viewModel: CountdownClockViewModel

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[0])
                        FlipView(viewModel: viewModel.flipViewModels[1])
                    }
                    Text("MESES")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[2])
                        FlipView(viewModel: viewModel.flipViewModels[3])
                    }
                    Text("DIAS")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[4])
                        FlipView(viewModel: viewModel.flipViewModels[5])
                    }
                    Text("HORAS")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }

                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        FlipView(viewModel: viewModel.flipViewModels[6])
                        FlipView(viewModel: viewModel.flipViewModels[7])
                    }
                    Text("MIN")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

