//
//  GRResult.swift
//  Assignment
//
//  Created by Lukas Kubaliak on 05/11/2025.
//

public enum GRResult<V, E> {

    case idle
    case loading
    case success(V)
    case failure(E)

    public func map<V2>(_ transform: (V) -> V2) -> GRResult<V2, E> {
        switch self {
        case .idle:
            return GRResult<V2, E>.idle
            
        case .loading:
            return GRResult<V2, E>.loading

        case let .failure(value):
            return GRResult<V2, E>.failure(value)

        case let .success(value):
            return GRResult<V2, E>.success(transform(value))
        }
    }

    public func mapError<E2>(_ transform: (E) -> E2) -> GRResult<V, E2> {
        switch self {
        case .idle:
            return GRResult<V, E2>.idle
            
        case .loading:
            return GRResult<V, E2>.loading

        case let .failure(value):
            return GRResult<V, E2>.failure(transform(value))

        case let .success(value):
            return GRResult<V, E2>.success(value)
        }
    }

    public func flatMap<V2>(_ transform: (V) -> GRResult<V2, E>) -> GRResult<V2, E> {
        switch self {
        case .idle:
            return GRResult<V2, E>.idle
            
        case .loading:
            return GRResult<V2, E>.loading

        case let .failure(value):
            return GRResult<V2, E>.failure(value)

        case let .success(value):
            return transform(value)
        }
    }

    public var isSuccess: Bool {
        switch self {
        case .success:
            return true

        case .idle, .loading, .failure:
            return false
        }
    }

    public var isLoading: Bool {
        switch self {
        case .loading:
            return true

        case .idle, .success, .failure:
            return false
        }
    }

    public var isFailure: Bool {
        switch self {
        case .failure:
            return true

        case .idle, .loading, .success:
            return false
        }
    }

    public func unwrapSuccess() throws -> V {
        switch self {
        case .success(let value):
            return value

        default:
            throw AppError.unknownErrorMessage("Could not unwrap the value.")
        }
    }

    public func unwrapFailure() throws -> E {
        switch self {
        case .failure(let value):
            return value

        default:
            throw AppError.unknownErrorMessage("Could not unwrap the error.")
        }
    }

}

extension GRResult: Equatable where E: Equatable, V: Equatable {

    public static func ==(left: GRResult<V, E>, right: GRResult<V, E>) -> Bool {
        if case let .success(leftValue) = left, case let  .success(rightValue) = right {
            return leftValue == rightValue
        }

        if case let .failure(leftError) = left, case let .failure(rightError) = right {
            return leftError == rightError
        }
        
        if case .idle = left, case .idle = right {
            return true
        }

        if case .loading = left, case .loading = right {
            return true
        }

        return false
    }

}
