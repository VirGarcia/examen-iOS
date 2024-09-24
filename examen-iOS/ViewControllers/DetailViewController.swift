//
//  DetailViewController.swift
//  examen-iOS
//
//  Created by Mañanas on 24/9/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            movieImageView.loadFrom(url: movie.poster)
            
            self.navigationItem.title = movie.title
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
