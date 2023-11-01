//
//  MathpixManager.swift
//  MathSolver

import Foundation
import Alamofire
import UIKit

struct MathpixResponse: Decodable {
    let latex: String?
    let error: String?
}

class ApiService {
    
    static let shared = ApiService()
    private let apiKey = "56e83bd220dc8fea9c65d7e4e86c84cb416df984dcb75fd1b560380c80fa17bf"
    private let apiUrlString = "https://api.mathpix.com/v3/latex"
    private let appID = "kv_sharpforksapps_com_797bd6_b5ecc4"
    
    func sendImageToMathpix(image: UIImage, completion: @escaping (String?) -> Void) {
        guard let imageData = image.pngData() else {
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "app_id": appID,
            "app_key": apiKey
        ]
        
        let baseImage = imageData.base64EncodedString()
        let json: [String: Any] = ["src": "data:image/png;base64,\(baseImage)"]
        
        AF.request(apiUrlString, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: MathpixResponse.self) { response in
                switch response.result {
                case .success(let data):
                    print("Full JSON Response: \(data)")
                    if let error = data.error {
                        print("API Error: \(error)")
                    }
                    completion(data.latex)
                case .failure(let error):
                    print("Error: \(error)")
                    if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                        print("Response Data: \(responseString)")
                    }
                    completion(nil)
                }
            }
    }
}

