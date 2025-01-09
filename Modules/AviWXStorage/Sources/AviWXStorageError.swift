//
//  AviWXStorageError.swift
//  Pods
//
//  Created by Asad Javed on 10/01/2025.
//


enum AviWXStorageError: Error {
    case metarNotFound
    case metarAlreadyExists
    case metarsResourceNotFound
    case failedToSaveMetar
    case failedToDeleteMetar
}