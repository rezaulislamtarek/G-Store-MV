//
//  HomeScreen.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var navigateToAddProduct : Bool = false
    @State var tappedOnProduct : Bool = false
    var body: some View {
        NavigationView {
            VStack{
                toolBarView
                ScrollView {
                    VStack(spacing: 16){
                        productHorizontalList
                        productList
                        Spacer()
                        navigateToAddProductScreen
                        navigateToProductDetailsScreen
                    }
                }
            }
            .hideNavigationBar
        }
        .hideNavigationBar
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

extension HomeScreen{
    private var toolBarView : some View{
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
    }
    private var productHorizontalList : some View{
        ProductHorizontalList(tapped: $tappedOnProduct).padding(.horizontal)
    }
    private var productList : some View{
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Text("Popular")
                Spacer()
                Text("Show all")
                    .foregroundColor(.black.opacity(0.5))
            }
            ProductsListView(tapped: $tappedOnProduct)
        }.padding(.horizontal)
    }
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
    private var navigateToProductDetailsScreen : some View{
        NavigationLink(
            destination: ProductDetailsScreen(),
            isActive: $tappedOnProduct,
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
            .environmentObject(ProductModel(apiService: APIService( )))
    }
}
