//
//  CountryController.swift
//  collectionViewLab
//
//  Created by God on 9/26/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

private let reuseIdentifier = "countryCell"

class CountryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    private var country = [CountryElement]() {
        didSet {
            countryCollectionViewPleaseWork.reloadData()
        }
        
    }
    var countrySearchResults:[CountryElement] {
        get {
            
            //when we have no search term, return the value of the initial set of people
            guard let searchString = searchString else {
                return country
            }
            guard searchString != ""  else {
                return country
            }
            return country
        }
    }
    
    var searchString: String? = nil {
        didSet {
            print(searchString)
            self.countryCollectionViewPleaseWork.reloadData()
        }
    }

    
    
    @IBOutlet weak var countryCollectionViewPleaseWork: UICollectionView!
    
    
    override func viewDidLoad() {
        print("ViewLoaded")
        super.viewDidLoad()
        print("Data Loaded")
        loadData()
        countryCollectionViewPleaseWork.dataSource = self
        countryCollectionViewPleaseWork.delegate = self
    
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//self.countryCollectionViewPleaseWork!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    func loadData() {
        CountryAPIClient.manager.getCountries(completionHandler: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let countryFromOnline):
                    self.country = countryFromOnline
                case .failure(let error):
                    print(error)
                }
            }
            
        })
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return country.count
    }

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CountryCell) else { return UICollectionViewCell() }
    
    let currentCountry = country[indexPath.item]
    cell.countryName.text = currentCountry.name
    cell.countryPop.text! = "\(currentCountry.population.withCommas() ?? "")"
    cell.countryCapital.text = currentCountry.capital
  let alphaCode = currentCountry.alpha2Code
  let url = URL(string: "https://www.countryflags.io/\(alphaCode)/shiny/64.png")
    let data = try? Data(contentsOf: url!)
//
    if let imageData = data {
        cell.countryImage.image = UIImage(data: imageData)
    }
//    getFlag(flagImage: cell.countryImage.image!, alphaCode: currentCountry.alpha2Code)
    
    
    
    
    //cell.countryPop.text = "\(currentCountry.population)" ?? "no population"
    //cell.countryCapital.text = currentCountry.capital ?? "no capital"
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CountryController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchString = searchBar.text
        
        
        
        
    }
}
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension CountryController {
    func getFlag(flagImage: UIImage, alphaCode: String) -> UIImage {
        var image = flagImage
        let url = URL(string: "https://www.countryflags.io/\(alphaCode)/shiny/64.png")
        let data = try? Data(contentsOf: url!)
        //
        if let imageData = data {
            image = UIImage(data: imageData)!
    }
        return image
    }
}

extension CountryController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  
            let newCountry = country[indexPath.row]
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SecondController") as! SecondViewController
            nextViewController.currentCountry = newCountry
            self.present(nextViewController, animated:true, completion:nil)
        
    }
    
}
