//
//  HomeScreen.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var navigateToAddProduct : Bool = false
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("My Store")
                        .font(.title3)
                    Spacer()
                    Button {
                        navigateToAddProduct.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                .padding(.all)
                .background(.gray.opacity(0.1))
                
                ProductsListView()
                    .padding(.horizontal)
                Spacer()
                navigateToAddProductScreen
            }
            .hideNavigationBar
            .edgesIgnoringSafeArea(.bottom)
        }
        
        .hideNavigationBar
        
    }
}

extension HomeScreen{
    private var navigateToAddProductScreen : some View{
        NavigationLink(
            destination: AddProductScreen(),
            isActive: $navigateToAddProduct,
            label: {
                EmptyView() // Hidden view, NavigationLink is triggered by the binding
            }
        )
        .hidden()

    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(ProductModel(apiService: APIService()))
    }
}
