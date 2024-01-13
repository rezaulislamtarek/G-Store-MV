//
//  AddProductScreen.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

struct AddProductScreenState{
    var title : String = ""
    var desctiption: String = ""
    var price : String = ""
    var category : String = ""
}

struct AddProductScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model : ProductModel
    @State var aps : AddProductScreenState = AddProductScreenState()
    
    
    private func addProduct() async {
            try? await model.addNewProduct(
                Product(
                    id: 0121, title:  aps.title, price: Double(aps.price), description: aps.desctiption, category:aps.category, image: "https://cdn1.arogga.com/eyJidWNrZXQiOiJhcm9nZ2EiLCJrZXkiOiJtZWRpY2luZVwvMzJcLzMyNjc4LUlNR18yMDIzMDUxNV8xOTQ1MzAtMWRkd2M3LmpwZWciLCJlZGl0cyI6eyJyZXNpemUiOnsid2lkdGgiOjEwMDAsImhlaWdodCI6MTAwMCwiZml0Ijoib3V0c2lkZSJ9LCJvdmVybGF5V2l0aCI6eyJidWNrZXQiOiJhcm9nZ2EiLCJrZXkiOiJtaXNjXC93bS5wbmciLCJhbHBoYSI6OTB9fX0="))
    }
    
    
    var body: some View {
        VStack{
            Form{
                TextField("Product Name", text: $aps.title)
                TextField("Description", text: $aps.desctiption)
                TextField("Price", text: $aps.price)
                TextField("Category", text: $aps.category)
            }
            
            Button("Add Product") {
                Task{
                    await addProduct()
                }
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductScreen()
    }
}
