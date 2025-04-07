import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button("Tekrar Dene") {
                            viewModel.fetchProducts()
                        }
                        .buttonStyle(.bordered)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: viewModel.columns, spacing: 30) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductCard(product: product)
                                        .frame(height: 250)
                                        .background(Color.black.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Products")
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

// Preview
#Preview {
    HomeView()
}
