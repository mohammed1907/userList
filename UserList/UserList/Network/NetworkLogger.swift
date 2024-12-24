//
//  Untitled.swift
//  UserList
//
//  Created by mohamed hassan on 24/12/2024.
//

import SwiftUI
import Alamofire

class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.networklogger.queue")

    func requestDidResume(_ request: Request) {
        print("\n===== REQUEST STARTED =====")
        print("URL: \(request.request?.url?.absoluteString ?? "No URL")")
        print("Method: \(request.request?.httpMethod ?? "No HTTP Method")")
        print("Headers: \(request.request?.allHTTPHeaderFields ?? [:])")

        if let httpBody = request.request?.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            print("Parameters: \(bodyString)")
        } else {
            print("Parameters: None")
        }
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("\n===== RESPONSE RECEIVED =====")
        print("URL: \(request.request?.url?.absoluteString ?? "No URL")")
        print("Status Code: \(response.response?.statusCode ?? 0)")
        print("Headers: \(response.response?.allHeaderFields ?? [:])")

        switch response.result {
        case .success(let value):
            print("Response: \(value)")
        case .failure(let error):
            print("Error: \(error)")
        }

        if let data = response.data,
           let jsonString = String(data: data, encoding: .utf8) {
            print("Raw Response Data: \(jsonString)")
        }
        print("=============================\n")
    }
}
