//
//  View+Extension.swift
//  G Store MV
//
//  Created by Rezaul Islam on 13/1/24.
//

import Foundation
import SwiftUI

extension View{
    var hideNavigationBar : some View{
        self.navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}
