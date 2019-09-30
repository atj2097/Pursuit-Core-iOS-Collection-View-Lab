//
//  SecondViewController.swift
//  collectionViewLab
//
//  Created by God on 9/30/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryPop: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tempHigh: UILabel!
    @IBOutlet weak var lowtEMP: UILabel!
    
    @IBOutlet weak var currentCapitall: UILabel!
    
    var currentCountry: CountryElement!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
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

extension SecondViewController {
    func setUpLabels() {
        countryName.text = currentCountry.name
        countryPop.text = "\(currentCountry.population.withCommas())"
        currentCapitall.text = currentCountry.capital
        let alphaCode = currentCountry.alpha2Code
        let url = URL(string: "https://www.countryflags.io/\(alphaCode)/shiny/64.png")
        let data = try? Data(contentsOf: url!)
        //
        if let imageData = data {
           countryFlag.image = UIImage(data: imageData)
        }
    }
}


