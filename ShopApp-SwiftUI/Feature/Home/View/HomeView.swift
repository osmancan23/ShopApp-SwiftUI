import SwiftUI

struct HomeView: View {
    
    let viewModel : HomeViewModel = HomeViewModel()
    @State private var list: [Product] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns, spacing: 30) {
                    ForEach(list) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            ProductCard(product: product)
                                .frame(height: 250) // Kart yüksekliği
                            .background(Color.black.opacity(0.2))
                                .cornerRadius(10)                        }
                        
                        
                    }
                }
                    .padding()
            }.navigationTitle("Products").onAppear(perform: {
                
                    viewModel.fetchProducts { response in
                        list = response.products
                    } onFailed: { error in
                        print(error)
                    }
                
               

        })
        }
    }
}




// Preview
#Preview {
    HomeView()
}
