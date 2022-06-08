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
            LazyVGrid(columns: columns) {
                ForEach(harem, id: \.id) {waifu in
                    
                    let url = URL(string: waifu.url)
                    
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)

                    
                    
                }
            }.padding()
        }.frame(maxWidth:.infinity,maxHeight: .infinity)
        
        
            
        .onAppear {
            
            WaifuViewModel.getWaifusFsw(category:.cringe, limit: 10) { waifus in
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
