//
//  WebRouting.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 18/08/2016.
//  Copyright © 2016 Nicolas Gaulard-Querol. All rights reserved.
//

import Foundation

public typealias HNWebResult<T> = Result<T, HNWebError>

public typealias HNWebResultCallback<T> = (HNWebResult<T>) -> Void

public enum HNWebError: Error {
    case networkError(Error)
    case invalidHTTPStatus(Int)
    case expiredAuthentication(Date)
    case invalidAuthentication
    case missingAuthentication
    case requestTimedOut
    case unknown
}

extension HNWebError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .networkError(error):
            return error.localizedDescription
        case let .invalidHTTPStatus(status):
            return "The server's HTTP response status code was not expected: HTTP \(status)"
        case let .expiredAuthentication(expiry):
            return "The request's authentication has expired since \(expiry.debugDescription)"
        case .invalidAuthentication:
            return "The request is not authenticated"
        case .missingAuthentication:
            return "The request's authentication is missing"
        case .requestTimedOut:
            return "The request timed out"
        case .unknown:
            return nil
        }
    }
}

// MARK: - HackerNewsWebPage

protocol WebItem {
    var baseURL: URL { get }
    var path: URL { get }
}

public enum HackerNewsWebpage {
    case item(Int)
    case user(String)
    case login

    var name: String {
        switch self {
        case .item: return "item"
        case .user: return "user"
        case .login: return "login"
        }
    }
}

extension HackerNewsWebpage: WebItem {
    public var baseURL: URL { return URL(string: "https://news.ycombinator.com")! }

    public var path: URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!

        switch self {
        case let .item(id):
            components.queryItems = [URLQueryItem(name: "id", value: "\(id)")]
            return components.url!.appendingPathComponent(name)
        case let .user(id):
            components.queryItems = [URLQueryItem(name: "id", value: "\(id)")]
            return components.url!.appendingPathComponent(name)
        case .login:
            return components.url!.appendingPathComponent("login")
        }
    }
}

// MARK: - HNWebClient

public protocol HNWebClient {
    
    func login(
        withAccount account: String,
        andPassword password: String,
        completion: @escaping HNWebResultCallback<Void>
    )
    
    func logout(
        completion: @escaping HNWebResultCallback<Void>
    )
    
    func upvote(
        item: Int,
        completion: @escaping HNWebResultCallback<Void>
    )
    
    func downvote(
        item: Int,
        completion: @escaping HNWebResultCallback<Void>
    )
}
