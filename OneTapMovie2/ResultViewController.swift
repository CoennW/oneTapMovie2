//
//  ResultViewController.swift
//  OneTapMovie2
//
//  Created by Fhict on 10/06/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import TMDBSwift

class ResultViewController: UIViewController {
    
    //Api key if needed
    let apiKey = "279e6330590f5e8788be345bf87321ca"
    
    //base poster url
    let basePosterURL = "https://image.tmdb.org/t/p/w500/"
    
    //movieID 
    var movieID = Int()
    
    //get outlets
    @IBOutlet weak var directedByLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var overviewTextField: UITextView!
    
    //Movie array for selected movie
    var selectedMovieArray = [MovieMDB]()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieID = selectedMovieArray[0].id!
        fillViewController()
        getMovieDetail()
        
    }
    
    func getMovieDetail() {
        
        MovieMDB.credits(apiKey, movieID: movieID){
            apiReturn, credits in
            
            var director = String()
            if let credits = credits {
                for crew in credits.crew {
                    if crew.job == "Director" {
                        director = crew.name
                        print(director)
                        self.directedByLabel.text = director
                        break
                    }
                }
            }
           
        }
        
    }
    

    
    func fillViewController(){
        //get data from movieArray and fill labels
        titleLabel.text = selectedMovieArray[0].title
        releaseDateLabel.text = String(describing: selectedMovieArray[0].release_date!)
        ratingLabel.text = String(describing: selectedMovieArray[0].vote_average!)
        overviewTextField.text = String(describing: selectedMovieArray[0].overview!)
        languageLabel.text = selectedMovieArray[0].original_language!
        
        //download poster and put in imageview(probeer te a-syncen)
        let posterPath = basePosterURL + selectedMovieArray[0].poster_path!
        print(posterPath)
        
        DispatchQueue.global().async {
         let imageUrl:URL = URL(string: posterPath)!
         let imageData:NSData = NSData(contentsOf: imageUrl)!
        
         DispatchQueue.main.async {
         let image = UIImage(data: imageData as Data)
         self.posterImage.image = image
         }
         
         }

        
        
        
        
        
    }

    @IBAction func searchAgainTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "searchAgain", sender: self)
        
    }
    
    @IBAction func watchThisMovieTapped(_ sender: Any) {
        
        
        performSegue(withIdentifier: "watchingMovie", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "searchAgain":
                let watchingView = segue.destination as! watchingMovieViewController
                //prepare data
                
            case "watchingMovie":
                let searchPageView = segue.destination as! SearchPageViewController
                //prepare data
                
            default:
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
