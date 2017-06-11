//
//  LibraryViewController.swift
//  OneTapMovie2
//
//  Created by Fhict on 11/06/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import TMDBSwift

class LibraryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //selected movie array
    var selectedMovieArray = [MovieMDB]()
    var titleArray = [String]()
    
    //user default 
    let userDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
         // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        //set up user default or set up array 
        if let defaultArray = userDefault.object(forKey: "movieArray") as? Array<Any>
        {
            if selectedMovieArray.count > 0 {
                titleArray = defaultArray as! [String]
                titleArray.append(selectedMovieArray[0].title!)
                userDefault.set(titleArray, forKey: "movieArray")
            } else {
                titleArray = defaultArray as! [String]
            }
            
        }
        else  {
            //titleArray.append(selectedMovieArray[0].title!)
            //userDefault.set(titleArray, forKey: "movieArray")
            titleArray.append("No movies watched")
        }
       
    }

    @IBAction func searchTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "toSearch", sender: self)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LibraryTableViewCell
        cell.titleLabel.text = titleArray[indexPath.row]
        
        return cell
    
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
