//
//  APICaller.swift
//  ChatGPT
//
//  Created by Aligazy Kismetov on 09.01.2023.
//

import Foundation
import OpenAISwift

final class APICaller{
    static let shared = APICaller()
    
    @frozen enum Constants{
        static let key = "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"
    }
    public init(){}
    
    private var client: OpenAISwift?
    
    public func setup(){
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponce(input: String, completion: @escaping(Result<String, Error>) -> Void){
        client?.sendCompletion(with: input, model: .codex(.davinci), completionHandler: { result in
            switch result{
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
