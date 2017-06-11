//
//  watchingMovieViewController.swift
//  OneTapMovie2
//
//  Created by Fhict on 11/06/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import TMDBSwift

class watchingMovieViewController: UIViewController {
    //create oulet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    //countdown data
    var count = 3600 * 2
    //watching title 
    var watchingTitle = String()
    //arrayMovie
    var selectedMovieArray = [MovieMDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create timer
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        titleLabel.text = watchingTitle
        //style
        self.view.addBackground(imageName: ("bg_one_tap_movie_circel@1x.png"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        
        if(count > 0){
            let minutes = String((count % 3600) / 60)
            let seconds = String(count % 60)
            let hours = String(count / 3600)
            countdownLabel.text = hours + ":" + minutes + ":" + seconds
            count -= 1
        }
        else {
            performSegue(withIdentifier: "goToLibrary", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let libraryView = segue.destination as! LibraryViewController
        libraryView.selectedMovieArray = selectedMovieArray
    }

    @IBAction func skipTapped(_ sender: Any) {
        count = 5
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
