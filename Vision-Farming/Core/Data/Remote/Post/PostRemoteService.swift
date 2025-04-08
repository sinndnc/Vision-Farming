//
//  PostRemoteService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/7/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class PostRemoteService : PostRemoteServiceProtocol{
    
    let auth: Auth
    let firestore : Firestore
    private let collection = "PRODUCTS"

    @Inject private var localService : PostLocalServiceProtocol
    
    init(auth: Auth,firestore: Firestore) {
        self.auth = auth
        self.firestore = firestore
    }
    
    func fetchAllPosts() -> AnyPublisher<[Post], Error> {
        let ref = firestore.collection(collection).order(by: "createdAt", descending: true)
        return Future { promise in
            ref.getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    let posts = snapshot?.documents.compactMap { try? $0.data(as: Post.self) } ?? []
                    promise(.success(posts))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addPost(_ post: Post) -> AnyPublisher<Void, Error> {
        let ref = firestore.collection(collection).document(post.id ?? UUID().uuidString)
        return Future { promise in
            do {
                try ref.setData(from: post) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func updatePost(_ post: Post) -> AnyPublisher<Void, Error> {
        guard let id = post.id else {
            return Fail(error: NSError(domain: "PostRepository", code: 0, userInfo: [NSLocalizedDescriptionKey: "Post ID is missing"])).eraseToAnyPublisher()
        }
        let ref = firestore.collection(collection).document(id)
        return Future { promise in
            do {
                try ref.setData(from: post, merge: true) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func deletePost(byId id: String) -> AnyPublisher<Void, Error> {
        let ref = firestore.collection(collection).document(id)
        return Future { promise in
            ref.delete { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
}
