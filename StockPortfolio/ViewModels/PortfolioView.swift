import SwiftUI

struct PortfolioView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    
    var body: some View {
        VStack(spacing: 12) {
            // Range Picker
            Picker("Range", selection: $viewModel.selectedRange) {
                ForEach(PortfolioViewModel.DateRange.allCases) { range in
                    Text(range.rawValue).tag(range)
                }
            }
            .pickerStyle(.segmented)
            
            // Simple representation of the performance data
            if viewModel.isLoading {
                ProgressView("Loading portfolio…")
            } else if viewModel.filteredPerformanceData.isEmpty {
                ContentUnavailableView("No Data", systemImage: "chart.line.uptrend.xyaxis", description: Text("Try a different range or add holdings."))
            } else {
                List(viewModel.filteredPerformanceData, id: \.date) { point in
                    HStack {
                        Text(point.date, style: .date)
                        Spacer()
                        Text(point.series)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(String(format: "%.2f", point.value))
                            .monospacedDigit()
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding()
        .task {
            await viewModel.loadPortfolio()
        }
        .navigationTitle("Portfolio")
    }
}

#Preview {
    NavigationStack { PortfolioView() }
}
