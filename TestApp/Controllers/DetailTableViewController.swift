//
//  DetailTableViewController.swift
//  TestApp
//
//  Created by BEREZIN Stanislav on 06.10.2020.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    //MARK: - Properties
    var sample: TestData?
    private var image: UIImage? {
        var imageData: Data?
        var image: UIImage?
        guard let imageUrl = sample?.data?.url else { return UIImage(systemName: "photo")}
        
        DispatchQueue.global(qos: .background).async {
            imageData = NetworkService.shared.getImageData(fromUrlString: imageUrl)
            if imageData != nil {
                DispatchQueue.main.async {
                    image = UIImage(data: imageData!)
                    self.photo.image = image
                }
            }
        }
        return image
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = sample?.data?.text
        photo.image = image
    }
    
    //MARK: - Pass Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let variantVC = navigationVC.viewControllers.first as? VariantTableViewController else { return }
        variantVC.sample = sample
    }
}
