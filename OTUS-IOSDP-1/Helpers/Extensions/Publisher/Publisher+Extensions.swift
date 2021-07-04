//
//  Publisher+Extensions.swift
//  OTUS-IOSDP-1
//
//  Created by Vladislav Dorfman on 04/07/2021.
//

import Combine

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}
