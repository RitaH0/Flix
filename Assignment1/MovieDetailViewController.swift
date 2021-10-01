//
//  MovieDetailViewController.swift
//  Assignment1
//
//  Created by Rita Han on 10/1/21.
//

import UIKit
import AlamofireImage
class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    var movie: [String:Any]!
    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        dateLabel.text = movie["release_date"] as? String
        dateLabel.sizeToFit()

        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        
        posterView.af_setImage(withURL: posterUrl)
    
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        
        backdropView.af_setImage(withURL: backdropUrl)
    
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
