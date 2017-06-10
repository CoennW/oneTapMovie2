//
//  SearchPageViewController.swift
//  OneTapMovie2
//
//  Created by Fhict on 10/06/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import TMDBSwift

class SearchPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //textfield outlets
    @IBOutlet weak var fromYearField: UITextField!
    @IBOutlet weak var tillYearField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var totalVotesField: UITextField!
    @IBOutlet weak var voteAvarageField: UITextField!
    
    //pickers declaring
    let fromYearPicker = UIPickerView()
    let tillYearPicker = UIPickerView()
    let genrePicker = UIPickerView()
    let durationPicker = UIPickerView()
    
    //data for pickers
    var genreArray = [String]()
    var yearsArray = ["2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010" ,"2011", "", "2012", "2013", "2014" ,"2015" ,"2016" ,"2017"]
    
    //data for search and passing(optional other controllers)
    var selectedFromYear = String()
    var selectedTillYear = String()
    var selectedGenre = String()
    var selectedDuration = String()
    var selectedTotalVotes = Double()
    var selectedVoteAvarage = Double()
    
    //Selected from searchforMOvie
    var selectedMovieArray = [MovieMDB]()
    
    //api key for The Movie Database
    let apiKey = "279e6330590f5e8788be345bf87321ca"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set inputfield to correct state
        setInputFields()
        //set data to pickerviews
        fillPickerDataSource()
        
        
        
        
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        //var for movie genre code
        var movieCode = String()
        //make data ready for search
        selectedFromYear = fromYearField.text! + "-01-01"
        selectedTillYear = tillYearField.text! + "-01-01"
        selectedVoteAvarage = Double(voteAvarageField.text!)!
        
        if let movieGenre = MovieGenre(rawValue: selectedGenre) {
            print(movieGenre.code)
            movieCode = movieGenre.code
        }
        
        //search query
        DiscoverMovieMDB.discoverMovies(apikey: apiKey, language: "EN", page: 1, sort_by: DiscoverSortByMovie.vote_count_desc, year: nil, certification_country: nil, certification: nil, certification_lte: nil, include_adult: nil, include_video: nil, timezone: nil, primary_release_year: nil, primary_release_date_gte: selectedFromYear, primary_release_date_lte: selectedTillYear, release_date_gte: nil, release_date_lte: nil, vote_average_gte: selectedVoteAvarage, vote_average_lte: selectedVoteAvarage, vote_count_gte: nil, vote_count_lte: nil, with_genres: movieCode, with_cast: nil, with_crew: nil, with_companies: nil, with_keywords: nil, with_people: nil) { (data, movieArray) in
            if let movieArray = movieArray{
                print(movieArray[0].title!)
                //save movie array
                self.selectedMovieArray = movieArray
                self.performSegue(withIdentifier: "result", sender: self)
                
            }
        }
        
    }
    
    
    func setInputFields() {
        
        //set pickerview
        genrePicker.delegate = self
        fromYearPicker.delegate = self
        tillYearPicker.delegate = self
        genrePicker.tag = 1
        fromYearPicker.tag = 2
        tillYearPicker.tag = 3
        
        //set keyboard to numberpad for numberfields
        //totalVotesField.keyboardType = UIKeyboardType.numberPad
        //voteAvarageField.keyboardType = UIKeyboardType.numberPad
        
        //set textfields input to picker
        genreField.inputView = genrePicker
        fromYearField.inputView = fromYearPicker
        tillYearField.inputView = tillYearPicker
        
    
    }
    
    func fillPickerDataSource() {
        //fill genrePicker
        GenresMDB.genres(apiKey, listType: .movie, language: "en") { (apiReturn, genres) in
            if let genres = genres{
                genres.forEach{
                    print($0.name!)
                    self.genreArray.append($0.name!)
                }
            }
        }
        

    
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView.tag == 1 {
            return genreArray.count
        }else if pickerView.tag == 2 || pickerView.tag == 3 {
            return yearsArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return genreArray[row]
        }else if pickerView.tag == 2 || pickerView.tag == 3 {
            return yearsArray[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            //update field and variable
            genreField.text = genreArray[row]
            selectedGenre = genreArray[row]
        }else if pickerView.tag == 2 {
            //update field and variable
            fromYearField.text = yearsArray[row]
            selectedFromYear = yearsArray[row]
        }else if pickerView.tag == 3 {
            //update field and variable
            tillYearField.text = yearsArray[row]
            selectedTillYear = yearsArray[row]
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewcontroller = segue.destination as! ResultViewController
        resultViewcontroller.selectedMovieArray = self.selectedMovieArray
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
