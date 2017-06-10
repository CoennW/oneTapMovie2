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
    
    //Api key
    let apiKey = ""
    
    //get outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directedByLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var overviewTextField: UITextView!
    
    //Movie array
    var selectedMovieArray = [MovieMDB]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillViewController()
        getMovieDetail()
        // Do any additional setup after loading the view.
    }
    
    func getMovieDetail() {
        
        
        ratingLabel.text = String(describing: selectedMovieArray[0].id)
    }
    
    func fillViewController(){
        titleLabel.text = selectedMovieArray[0].title
        directedByLabel.text = String(describing: selectedMovieArray[0].vote_average)
        ratingLabel.text = String(describing: selectedMovieArray[0].vote_count)
        overviewTextField.text = String(describing: selectedMovieArray[0].overview!)
        
        
        
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
