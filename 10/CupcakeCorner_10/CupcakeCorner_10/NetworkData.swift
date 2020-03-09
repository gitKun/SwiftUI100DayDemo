//
//  NetworkData.swift
//  CupcakeCorner_10
//
//  Created by DR_Kun on 2020/3/9.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI


struct NetworkData: View {
    @State private var results = [IResult]()
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let decodedResponse = try? decoder.decode(IResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
}
struct IResponse: Codable {
    var results: [IResult]
}

struct IResult: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    // var artworkUrl100: String
}

struct NetworkData_Previews: PreviewProvider {
    static var previews: some View {
        NetworkData()
    }
}

