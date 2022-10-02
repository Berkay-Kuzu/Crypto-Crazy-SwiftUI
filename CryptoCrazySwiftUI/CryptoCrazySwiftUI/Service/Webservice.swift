//
//  Webservice.swift
//  CryptoCrazySwiftUI
//
//  Created by Berkay Kuzu on 23.09.2022.
//

import Foundation

//@escaping: "iş bittikten sonra" geri döndüreceği şeyleri completion block içinde ve Result içinde bize veriyor.

class Webservice {
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoCurrency]?, DownloaderError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl)) // Hata var mı yok mu kontrol ettim.
            }
            
            //Data(veri) var mı kontrol ediyorum:
            guard let data = data, error == nil else { // guard let, else'den öncekini doğru kabul eder. Data var ve hata mesajı yok diyor. Bunu kabul ettikten sonra "else" burası doğru değilse ne yapacağım diyor. Yani data yoksa ne yapacağım diyor.
                return completion(.failure(.noData))
            }
            
            //Decoder kullanacağım:
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dateParseError)) // Veri gelmiş ama parse edemiyoruz, işleyemiyoruz. O zaman bu hatayı ver.
            }
            
            completion(.success(currencies)) // Bütün her şeyi geçerse veri geliyor.
            
        }.resume()
    }
}

enum DownloaderError : Error { // Buradakileri Result'ın error kısmına verdik.
    case badUrl // URL yanlışsa, internet yoksa bu hata çıkar.
    case noData
    case dateParseError
}
