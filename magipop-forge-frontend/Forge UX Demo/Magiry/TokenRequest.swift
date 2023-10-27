//
//  TokenRequest.swift
//  Magiry
//
//  Created by Race Li on 2023/10/14.
//

import SwiftUI
import Combine

struct TokenRequest: View {
    @State private var inputText = ""
    @State private var score: Double = 0.0
    @State private var token = ""
    @State private var cancellable: AnyCancellable?

    var body: some View {
        VStack {
            TextField("Input", text: $inputText)
            TextField("Token", text: $token)
            Button("Send Request") {
                self.sendRequest()
            }
            Text("Score: \(score)")
        }
        .padding()
    }

    func sendRequest() {
        guard let url = URL(string: "https://api.openai.com/v2/engines/davinci-codex/completions") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = [
            "prompt": inputText,
            "max_tokens": 5
        ] as [String : Any]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        self.cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { response in
                self.score = response.score // Assuming there is a `score` in the response
            })
    }
}

struct Response: Codable {
    let score: Double
}


#Preview {
    TokenRequest()
}
