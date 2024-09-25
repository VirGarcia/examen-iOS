//
//  ViewController.swift
//  examen-iOS
//
//  Created by Mañanas on 24/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var movieList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        configureRefreshControl()
        
        searchMovies("matrix")
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
        
        
       
            
            // Llama a la función para obtener más detalles de la película
            searchMovieById(movie.id)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailViewController = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            let movie = movieList[indexPath!.row]
            
            searchMovieById(movie.id) { detailedMovie in
                DispatchQueue.main.async {
                    detailViewController.movie = detailedMovie
                    detailViewController.titleLabel.text = detailedMovie?.title
                    detailViewController.yearLabel.text = detailedMovie?.year
                    detailViewController.genreLabel.text = detailedMovie?.genre
                    detailViewController.directorLabel.text = detailedMovie?.director
                }
            }
        }
    }*/
    
    
    
    
    
    
    func configureRefreshControl() {
       // Add the refresh control to your UIScrollView object.
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        // Update your content…
        searchMovies("a")
    }
    
    // MARK: SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchMovies(searchBar.text!)
    }
    
    /*func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.notFoundLabel.isHidden = true
        searchMovies("a")
    }*/
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         if (searchText.isEmpty) {
             searchMovies("a")
         }
     
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
    
    
    func searchMovieById(_ id: String) {
        Task {
            guard let url = URL(string: "https://www.omdbapi.com/?apikey=fb7aca4&i=\(id)") else {
                print("URL not valid")
                return
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            let result = try JSONDecoder().decode(Movie.self, from: data)
            
            DispatchQueue.main.async {
                // Aquí puedes actualizar tu UI con los detalles de la película
                print(result)
            }
        }
    }

}
