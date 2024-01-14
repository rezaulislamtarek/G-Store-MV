//
//  String+Extension.swift
//  G Store MV
//
//  Created by Rezaul Islam on 14/1/24.
//

import Foundation

extension String{
    var truncateTitle : String {
            let words = self.components(separatedBy: " ")
            if words.count >= 3 {
                return words[0] + " " + words[1] + " " + words[2]
            } else {
                return self
            }
        }
}
