//
//  MainTableViewController.swift
//  TestApp
//
//  Created by BEREZIN Stanislav on 06.10.2020.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    //MARK: - Properties
    let urlString = "https://pryaniky.com/static/json/sample.json"
    var testModel: TestModel?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getDataFromNetwork(withURL: url) { (testModel) in
            
            DispatchQueue.main.async {
                self.testModel = testModel
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testModel?.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sample = testModel?.data?[indexPath.row]
        self.image = self.getImage(fromSource: sample?.data?.url)
        cell.textLabel?.text = sample?.name
        cell.imageView?.image = self.image
        return cell
    }
    
    //MARK: - Pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailTableViewController = segue.destination as? DetailTableViewController else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        guard let selectedSample = testModel?.data?[selectedIndex.row] else { return }
        detailTableViewController.sample = selectedSample
    }
    
    private func getImage(fromSource source: String?) -> UIImage? {
        guard
            let imageUrl = source,
            let imageData = NetworkService.shared.getImageData(fromUrlString: imageUrl),
            let image = UIImage(data: imageData) else { return UIImage(systemName: "photo")}
        return image
    }
}
