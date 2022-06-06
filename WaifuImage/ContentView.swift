//
//  ContentView.swift
//  WaifuImage
//
//  Created by Gabriel Aderaldo on 06/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var harem:[WaifuInterable] = []
           let columns = [
                GridItem(.adaptive(minimum: 80))
           ]
    
    var body: some View {
        
        
        ScrollView{
            LazyVGrid(columns: columns,spacing: 20) {
                ForEach(harem, id: \.id) {waifu in
                    
                    let url = URL(string: waifu.url)
                    
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .frame(width: 120, height: 80, alignment: .topLeading)
                    } placeholder: {
                        ProgressView()
                    }

                    
                    
                }
            }.padding()
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
        
        
            
        .onAppear {
            WaifuViewModel.getWaifus(type: .fsw, category: .waifu, limit:10) { (waifus) in
               
                harem = waifus
                
            }
        }
        
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
