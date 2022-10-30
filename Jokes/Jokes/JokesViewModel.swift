//
//  File.swift
//  Jokes
//
//  Created by Aklesh on 30/10/22.
//

import Foundation


protocol JokesViewModelProtocol {
    var jokesArray:[String] { get set}
    func fetchJokes()
    func startFetchingJokes()
    func fetchJokesFromDefault()
    func saveJokes()
    var timer: Timer? { get set}
    var jokesFetched:(() ->())? { get set}
}

class JokesViewModel: JokesViewModelProtocol {
    var jokesArray: [String] = []
    weak var timer: Timer?
    var jokesFetched:(() ->())?
    
    
    func startFetchingJokes() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] _ in
            self?.fetchJokes()
        }
        
    }
    
    func stopTimer() {
        print("timer stoped")
        timer?.invalidate()
    }
    
    func fetchJokes() {
        let url = URL(string: "https://geek-jokes.sameerkumar.website/api")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
              self.stopTimer()
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(response)")
              self.stopTimer()
            return
          }

          if let jsonData = data,
            let joke = String(data: jsonData, encoding: .utf8) {
              print("Joke is : \(joke)")
              self.updateJokesArray(joke: joke)
          }
        })
        task.resume()
    }
    
    func updateJokesArray(joke:String) {
        jokesArray.append(joke)
        if jokesArray.count > 10 {
            jokesArray.removeFirst()
        }
        jokesFetched?()
    }
    
    func saveJokes() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(jokesArray, forKey: "jokes")

    }
    
    func fetchJokesFromDefault()  {
        let userDefaults = UserDefaults.standard
        if let jokes = userDefaults.object(forKey: "jokes") as? [String] {
            jokesArray = jokes
            jokesFetched?()
        }
    }
    

    deinit {
        stopTimer()
    }
}





