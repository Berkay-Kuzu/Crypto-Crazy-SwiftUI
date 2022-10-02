//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Berkay Kuzu on 22.09.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel // : kullanarak tanımladım.
    
    init() { // görünüm oluşturulduğunda ilk çağırılacak şeylerden bir tanesi.
        self.cryptoListViewModel = CryptoListViewModel() // boş bir şekilde tanımladım.
    }
    
    var body: some View {
        // Verileri buradan çekeceğim:
        
        NavigationView {
            
            List(cryptoListViewModel.cryptoList, id:\.id) { crypto in
                
                VStack{
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(crypto.price)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.navigationTitle(Text("Crypto Crazy"))
        }.onAppear {
            cryptoListViewModel.downloadCyrptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
