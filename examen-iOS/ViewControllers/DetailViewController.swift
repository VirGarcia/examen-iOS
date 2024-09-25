//
//  DetailViewController.swift
//  examen-iOS
//
//  Created by Mañanas on 24/9/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var runtimeLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            searchMovieById(movie.id) { result in
                DispatchQueue.main.async {
                    self.movie = result
                    self.updateUI()
                }
            }
        } else {
            print("Error: No encuentro ninguna película")
        }
    }
    
    func updateUI() {
        guard let movie = movie else { return }
        
        self.navigationItem.title = movie.title
        avatarImageView.loadFrom(url: movie.poster)
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        runtimeLabel.text = movie.runtime
        directorLabel.text = movie.director
        genreLabel.text = movie.genre
        countryLabel.text = movie.country
        plotLabel.text = movie.plot ?? "Sin información"
    }
    func searchMovieById(_ id: String, withResult result: @escaping (Movie) -> Void) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=fb7aca4&i=\(id)") else {
            print("URL not valid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                result(movie)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
    
    
    
    
    
}




