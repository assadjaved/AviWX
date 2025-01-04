//
//  LoadableState.swift
//  AviWX
//
//  Created by Asad Javed on 02/01/2025.
//


enum LoadableState<T: Decodable> {
    case loading
    case value(T)
    case error(Error)
}
