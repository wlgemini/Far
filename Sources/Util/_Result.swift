//
//  _Result.swift
//  


enum _Result<Success, Failure> where Failure : Error {
    
    /// A success, storing a `Success` value.
    case success(Success)
    
    /// A failure, storing a `Failure` value.
    case failure(Failure)
    
    /// Return value if success
    var value: Success? {
        switch self {
            case .success(let value): return value
            case .failure: return nil
        }
    }
}
