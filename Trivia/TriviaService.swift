//
//  TriviaService.swift
//  Trivia
//
//  Created by Jason Morales on 10/10/23.
//

import Foundation

struct TriviaResponse: Decodable {
    var results: [Question]
}

class TriviaService {
    static func fetchTrivia(completion: @escaping ([Question]) -> Void) {
        let url = URL(string: "https://opentdb.com/api.php?amount=10")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaResponse.self, from: data)
            DispatchQueue.main.async {
                completion(response.results)
            }
        }
        task.resume()
    }
}
