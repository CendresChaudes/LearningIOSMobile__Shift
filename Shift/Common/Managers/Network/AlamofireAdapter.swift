//
//  AlamofireAdapter.swift
//  Shift
//
//  Created by Роман on 05.07.2025.
//

import Alamofire
import Foundation

final class AlamofireAdapter {

    static func getHTTPMethod(from method: Shift.HTTPMethod) -> Alamofire.HTTPMethod {
        var result: Alamofire.HTTPMethod = .get

        switch method {
        case .get:
            result = .get
        case .post:
            result = .post
        case .put:
            result = .put
        case .patch:
            result = .patch
        case .delete:
            result = .delete
        case .options:
            result = .options
        case .head:
            result = .head
        case .trace:
            result = .trace
        case .connect:
            result = .connect
        }

        return result
    }
}
