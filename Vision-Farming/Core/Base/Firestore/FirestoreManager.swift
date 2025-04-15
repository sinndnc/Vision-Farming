//
//  FirestoreManager.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/15/25.
//

import FirebaseFirestore

final class FirestoreManager {
    private let db = Firestore.firestore()
    
    func setDocument<T: Codable>(path: String, data: T) throws {
        let ref = db.document(path)
        try ref.setData(from: data)
    }

    func updateDocument(path: String, fields: [String: Any]) {
        db.document(path).updateData(fields)
    }

    func deleteDocument(path: String) {
        db.document(path).delete()
    }

    func addDocument<T: Codable>(collectionPath: String, data: T) throws {
        let ref = db.collection(collectionPath).document()
        try ref.setData(from: data)
    }

    func getDocument<T: Codable>(path: String, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        db.document(path).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            do {
                if let document = try snapshot?.data(as: T.self) {
                    completion(.success(document))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
