//
//  NetworkService.swift
//  TestApp
//
//  Created by BEREZIN Stanislav on 06.10.2020.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    //MARK: - Getting and pass JSON
    func getDataFromNetwork(withURL url: URL, completion: @escaping (TestModel) -> ()) {
        getJSON(fromURL: url) { (data) in
            self.parseJSON(fromData: data) { (testModel) in
                completion(testModel)
            }
        }
    }
    
    //MARK: - Getting image data
    func getImageData(fromUrlString url: String) -> Data? {
        guard let url = URL(string: url) else { return Data() }
        let imageData = try? Data(contentsOf: url)
        return imageData
    }
    
    //MARK: - Getting JSON
    private func getJSON(fromURL url: URL, completion: @escaping (Data) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
    
    //MARK: - Parsing JSON
    private func parseJSON(fromData jsonData: Data, completion: @escaping (TestModel) -> ()) {
        let jsonDecoder = JSONDecoder()
        
        do {
            let testModel = try jsonDecoder.decode(TestModel.self, from: jsonData)
            print(testModel)
            completion(testModel)
        } catch {
            print(error.localizedDescription)
        }
    }
}
