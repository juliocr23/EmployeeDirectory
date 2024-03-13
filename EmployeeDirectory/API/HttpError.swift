//
//  HttpResult.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import Foundation

enum HttpError: Error {
    case Unowned
    case ClientError
    case ServerError
    case ParsingError
}
