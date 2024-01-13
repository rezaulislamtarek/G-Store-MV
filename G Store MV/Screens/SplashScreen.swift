//
//  SplashScreen.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import SwiftUI

struct SplashScreen: View {
    @State var isToggled: Bool = false
    @State var navigateHome : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "quote.opening")
                    .resizable()
                    .frame(width: 100, height: 60)
                    .foregroundColor( isToggled ? .green : .red)
                
                navigateToHomeScreen
                
            }
            .onAppear{
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                    withAnimation {
                        navigateHome.toggle()
                    }
                }
            }
            .padding()
            .hideNavigationBar
        }
       
    }
    
    
}

extension SplashScreen{
    private var navigateToHomeScreen : some View {
        NavigationLink(
            destination: HomeScreen(),
            isActive: $navigateHome,
            label: {
                EmptyView() // Hidden view, NavigationLink is triggered by the binding
            }
        )
        .hidden()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
            .environmentObject(ProductModel(apiService: APIService()))
    }
}
