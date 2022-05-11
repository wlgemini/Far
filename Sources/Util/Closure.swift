//
//  Closure.swift
//


/// A closure for compute value
public typealias Compute<Value> = () -> Value

/// A closure for available value
public typealias Available<Value> = (Value) -> Void

/// A closure for mutating available value
public typealias MutatingAvailable<Value> = (inout Value) throws -> Void
