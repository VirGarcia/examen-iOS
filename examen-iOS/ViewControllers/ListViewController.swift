//
//  ViewController.swift
//  examen-iOS
//
//  Created by Mañanas on 24/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        searchMovies("batman")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieViewCell
        let movie = movieList[indexPath.row]
        cell.render(movie)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        let movie = movieList[indexPath!.row]
        detailViewController.movie = movie
    }
    
    // MARK: API call
    func searchMovies(_ query: String) {
        Task {
            guard let url = URL(string: "https://www.omdbapi.com/?apikey=fb7aca4&s=\(query)") else {
                print("URL not valid")
                movieList = []
                return
            }
            
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let result = try JSONDecoder().decode(Movies.self, from: data)
            movieList = result.movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
}
