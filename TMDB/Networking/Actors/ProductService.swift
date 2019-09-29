//
//  ProductService.swift
//  Sample MVP
//
//  Created by Bassem Abbas on 9/18/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import Foundation
import Moya

//swiftlint:disable  force_unwrapping

enum  ActorsService {
    case popular
    case search(text: String)
}

extension ActorsService: TargetType {
    var baseURL: URL {
        return URL(string: NetworkManager.shared.networkConfig.baseUrl)!
    }
    var searchURL: URL {
        return URL(string: NetworkManager.shared.networkConfig.baseUrl)!
    }
    var path: String {
        switch self {
        case .popular:
            return "/person/popular"
        case .search:
            return "/search/person"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .popular:
            return Data()
        case .search:
            return Data()
        }
    }
    
    var task: Task {        
        switch self {
        case .popular :
			return .requestParameters(
				parameters: ["api_key":NetworkManager.shared.networkConfig.apiKey],
				encoding: URLEncoding.default)
        case .search(let text):
            return .requestParameters(
                parameters: ["api_key":NetworkManager.shared.networkConfig.apiKey,
                             "query":text],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
