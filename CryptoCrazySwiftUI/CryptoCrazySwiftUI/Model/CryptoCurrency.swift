//
//  CryptoCurrency.swift
//  CryptoCrazySwiftUI
//
//  Created by Berkay Kuzu on 22.09.2022.
//

import Foundation

// Burada uygulamanın modelini yazıyorum.

struct CryptoCurrency : Hashable, Decodable, Identifiable {
    
    let id = UUID()
    var currency : String
    var price : String
    
    private enum CodingKeys : String, CodingKey { // coding anahtar kelimleri kullandım, hashable ile kullanmak tavsiye ediliyor.
        case currency = "currency" // Değişken ismi bu olduğu için böyle yazdım.
        case price = "price" // Değişken ismi bu olduğu için böyle yazdım.
    }
    
}
