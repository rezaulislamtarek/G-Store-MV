//
//  APIService.swift
//  RateHammer
//
//  Created by Rezaul Islam on 17/7/23.
//  


import Foundation
import UIKit


struct APIService {
     
    
    let urlString: String = "https://fakestoreapi.com/"
    //let urlString: String = "https://corestg.ratehammer.com/api/"
    
    
    private func getHeaders() -> [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["Platform"] = "iOS"
 
        return headers
    }
    
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               endPoint: String
    ) async throws -> T {
        guard
            let url = URL(string: urlString+endPoint)
        else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = getHeaders()
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    
    func postJSON<T: Decodable, U: Encodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                              endPoint: String,
                                              requestBody: U
    ) async throws -> T {
        guard let url = URL(string: urlString + endPoint) else {
            throw APIError.invalidURL
        }
        
       
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = getHeaders()
        
        // Encode the request body as JSON data
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .deferredToDate
        encoder.keyEncodingStrategy = .useDefaultKeys
        
        do {
            let jsonData = try encoder.encode(requestBody)
            request.httpBody = jsonData
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response is not an HTTPURLResponse")
                throw APIError.invalidResponseStatus
            }
            
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw APIError.decodingError(error.localizedDescription)
                }
            } else {
                // Parse the error response body
                let decoder = JSONDecoder()
                do {
                    let errorBody = try decoder.decode(ErrorBody.self, from: data)
                    throw APIError.customError(body: errorBody)
                } catch {
                    throw APIError.dataTaskError(error.localizedDescription)
                }
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    func putJSON<T: Decodable, U: Encodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                              endPoint: String,
                                              requestBody: U
    ) async throws -> T {
        guard let url = URL(string: urlString + endPoint) else {
            throw APIError.invalidURL
        }
        
    
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.allHTTPHeaderFields = getHeaders()
        
        // Encode the request body as JSON data
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .deferredToDate
        encoder.keyEncodingStrategy = .useDefaultKeys
        
        do {
            let jsonData = try encoder.encode(requestBody)
            request.httpBody = jsonData
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response is not an HTTPURLResponse")
                throw APIError.invalidResponseStatus
            }
            
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw APIError.decodingError(error.localizedDescription)
                }
            } else {
                // Parse the error response body
                let decoder = JSONDecoder()
                do {
                    let errorBody = try decoder.decode(ErrorBody.self, from: data)
                    throw APIError.customError(body: errorBody)
                } catch {
                    throw APIError.dataTaskError(error.localizedDescription)
                }
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    func uploadMultipartFormData<T: Codable>(endPoint: String, object: T, image: UIImage, keyForImage: String) async throws ->T {
        
        guard let url = URL(string: urlString + endPoint) else {
            throw APIError.invalidURL
        }
            let mirror = Mirror(reflecting: object)
            
            var formDataFields = [(String, String)]()
            
            for (label, value) in mirror.children {
                if let label = label, let value = value as? String {
                    formDataFields.append((label, value))
                }
            }
            
            guard !formDataFields.isEmpty else {
                throw APIError.customError(body: ErrorBody(message: "Invalid Form Data", errors: .none))
            }
            
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw APIError.corruptData
            }
            
            let boundary = UUID().uuidString
            let contentType = "multipart/form-data; boundary=\(boundary)"
        
      
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
             
           
             
            var body = Data()
            
            // Generate a unique filename for the image
             let uniqueFilename = "\(UUID().uuidString).jpg"
            
            // Append image data
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(keyForImage)\"; filename=\"\(uniqueFilename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            
            // Append other form data fields
            for (key, value) in formDataFields {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append(value.data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            // Close the multipart form data body
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
        
            print(body)
            print(request)
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                print("DATA \(data)")
                // Process the response data
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .deferredToDate
                decoder.keyDecodingStrategy = .useDefaultKeys
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw APIError.decodingError(error.localizedDescription)
                }
                
                
                
            } catch let error {
                throw APIError.dataTaskError(error.localizedDescription)
            }
        }

    func deleteJSON<T: Decodable, U: Encodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                              endPoint: String,
                                              requestBody: U
    ) async throws -> T {
        guard let url = URL(string: urlString + endPoint) else {
            throw APIError.invalidURL
        }
        
       
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = getHeaders()
        
        // Encode the request body as JSON data
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .deferredToDate
        encoder.keyEncodingStrategy = .useDefaultKeys
        
        do {
            let jsonData = try encoder.encode(requestBody)
            request.httpBody = jsonData
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response is not an HTTPURLResponse")
                throw APIError.invalidResponseStatus
            }
            
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw APIError.decodingError(error.localizedDescription)
                }
            } else {
                // Parse the error response body
                let decoder = JSONDecoder()
                do {
                    let errorBody = try decoder.decode(ErrorBody.self, from: data)
                    throw APIError.customError(body: errorBody)
                } catch {
                    throw APIError.dataTaskError(error.localizedDescription)
                }
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
    
    
}



enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    case customError(body: ErrorBody)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return   NSLocalizedString("The endpoint URL is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("The API failed to issue a valid response.", comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("The data provided appears to be corrupt", comment: "")
        case .decodingError(let string):
            return string
            
        case .customError(let body):
            // Customize the error description based on the parsed error body
            var description = ""
            print(body)
            if let message = body.message {
                description += message
             }
            return serializeErrorBody(body)
        }
        
        
        
    }
}


struct ErrorBody: Codable {
    let message: String?
    let errors: Errors?
}

struct Errors: Codable {
    let email: [String]?
    let password: [String]?
    let current_password: [String]?
    let password_confirmation: [String]?
    let contact_no : [String]?
    let national_id : [String]?
    let dob : [String]?
    let otp : [String]?
}


func serializeErrorBody(_ errorBody: ErrorBody) -> String? {
    do {
        let encoder = JSONEncoder()
        //encoder.keyEncodingStrategy = .convertToSnakeCase  // Adjust if needed
        let jsonData = try encoder.encode(errorBody)
        return String(data: jsonData, encoding: .utf8)
    } catch {
        print("Error while serializing ErrorBody: \(error)")
        return nil
    }
}

func deserializeErrorBody(from jsonString: String) -> ErrorBody? {
    guard let jsonData = jsonString.data(using: .utf8) else {
        return nil
    }

    do {
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase  // Adjust if needed
        let errorBody = try decoder.decode(ErrorBody.self, from: jsonData)
        return errorBody
    } catch {
        print("Error while deserializing ErrorBody: \(error)")
        return nil
    }
}
