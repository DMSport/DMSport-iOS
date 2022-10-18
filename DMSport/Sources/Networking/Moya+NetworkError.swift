//
//  Moya+NetworkError.swift
//  StudyOfStock
//
//  Created by 박준하 on 2022/10/07.
//

import Alamofire
import Moya
import Foundation

extension TargetType {
  static func converToURLError(_ error: Error) -> URLError? {
    switch error {
    case let MoyaError.underlying(afError as AFError, _):
      fallthrough
    case let afError as AFError:
      return afError.underlyingError as? URLError
    case let MoyaError.underlying(urlError as URLError, _):
      fallthrough
    case let urlError as URLError:
      return urlError
    default:
      return nil
    }
  }
  
  static func isNotConnection(error: Error) -> Bool {
    Self.converToURLError(error)?.code == .notConnectedToInternet
  }
  
  static func isLostConnection(error: Error) -> Bool {
    switch error {
    case let AFError.sessionTaskFailed(error: posixError as POSIXError)
      where posixError.code == .ECONNABORTED: // eConnAboarted: Software caused connection abort.
      break
    case let MoyaError.underlying(urlError as URLError, _):
      fallthrough
    case let urlError as URLError:
      guard urlError.code == URLError.networkConnectionLost else { fallthrough } // A client or server connection was severed in the middle of an in-progress load.
      break
    default:
      return false
    }
    return true
  }
}
