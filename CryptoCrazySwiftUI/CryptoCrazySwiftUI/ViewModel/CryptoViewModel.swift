//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Berkay Kuzu on 23.09.2022.
//

import Foundation
import Combine

// İki tane ViewModel var: CryptoViewModel ve CyrptoListViewModel
// CryptoViewModel: Modelimizi ViewModel içerisinde işleyeceğiz

class CryptoListViewModel : ObservableObject {
    
    //@Published dedikten sonra cyptoList içinde herhangi bir değişiklik olursa MainView kendini otomatik olarak güncelliyor, yeniliyor.
    
    @Published var cryptoList = [CryptoViewModel]() // İçerisinde CryptoViewModel olan boş bir liste.

    let webservice = Webservice() // Webservice'ten bir tane obje oluşturuyorum.
    
    func downloadCyrptos (url: URL) {
        
        webservice.downloadCurrencies(url: url) { result in
            switch result {
                
            case .failure(let error):
                print(error)
                
            case.success(let cryptos):
                if let cryptos = cryptos { // if let yaparak cyrptos'u optional olmaktan çıkardım.
                    
                    DispatchQueue.main.async { // cryptoList artık kullanıcı arayüzünü etkiliyor, bu yüzden DispatchQueue.main.async içerisine aldım.
                        self.cryptoList = cryptos.map(CryptoViewModel.init) // Bir yapıyı bir yapıya çevirirken .map kullanıyoruz. Neredeyse bütün dillerde var.
                    }
                    
                    
                }
            }
        }
    }
}



struct CryptoViewModel { // Bu struct içinde sadece modeli alıp işliyorum.
    
    let crypto : CryptoCurrency // crypto artık bir CryptoCurrency modeli.
 
    var id : UUID? { // Optional yapıyorum çünkü servisten gelmeyecek.
        crypto.id
    }
 
    var currency : String {
        crypto.currency
    }
    
    var price : String {
        crypto.price // crypto.price'dan price'ı alıyoruz.
    }
    
}
