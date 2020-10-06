//
//  VariantTableViewController.swift
//  TestApp
//
//  Created by BEREZIN Stanislav on 06.10.2020.
//

import UIKit

class VariantTableViewController: UITableViewController {
    
    //MARK: - Properties
    var sample: TestData?
    
    //MARK: - Actions
    @IBAction func closeController(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample?.data?.variants?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "variantCell", for: indexPath)
        let variant = sample?.data?.variants?[indexPath.row]
        cell.textLabel?.text = variant?.text
        return cell
    }
}
