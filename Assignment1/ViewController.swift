//
//  ViewController.swift
//  Assignment1
//
//  Created by Rita Han on 9/21/21.
//

import UIKit
import AlamofireImage
//step 2, add UITableViewDataSource, UITableViewDelegate
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //step 1 link the table view
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]() //create a variable that has a dictionary inside an array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //step 4, add these 2 lines
        tableView.dataSource = self
        tableView.delegate = self
                
        //downlaod movie info and store into movies variable
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    self.movies = dataDictionary["results"] as! [[String:Any]] //to access a specific key in dictionary and cast it as an array of dictionary
                    
                    //step 5, reload data
                    self.tableView.reloadData() //call those functions again
                
                    print(dataDictionary)

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    //step 3, add these two funcitons
    //function is needed for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return number of rows
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //asssign each element of movies to variable called movie as each individual row
        let movie = movies[indexPath.row]
        //assign the title of the movie to title
        let title = movie["title"] as! String
        //assign synopsis to synopsis
        let synopsis = movie["overview"] as! String
        //put content and title in each row
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis

        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
        return cell
    }
    
    //preparation stage before navigation
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        //get the new view controller using segue.destination
        //pass the selected object to the new view controller
        print("Laoding up the details scree")
        
        //find selected movie
        let cell = sender as! UITableViewCell //casting
        let indexPath = tableView.indexPath(for:cell)! //ask tableView for the index of teh cell
        let movie = movies[indexPath.row] //find the movie using the index

//        //pass selected movie to the details view controller
        let detailViewController = segue.destination as! MovieDetailViewController
        detailViewController.movie = movie
//
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

