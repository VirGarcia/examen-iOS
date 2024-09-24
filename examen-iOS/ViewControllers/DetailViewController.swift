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
            
            self.navigationItem.title = movie.title
            avatarImageView.loadFrom(url: movie.poster)
        
            titleLabel.text = movie.title
            yearLabel.text = movie.year
            runtimeLabel.text = movie.runtime
            directorLabel.text = movie.director
            genreLabel.text = movie.genre
            countryLabel.text = movie.country
            plotLabel.text = movie.plot ?? "Sin información"
            
        } else {
            print("Error: No encuentro ninguna pelicula")
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
