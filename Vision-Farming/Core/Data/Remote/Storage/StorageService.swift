//
//  StorageService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/19/25.
//

import Foundation
import Supabase
import Combine
import UIKit

class StorageService {
    
    private let client : SupabaseClient
    
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func loadProfileImage(for path : String) -> AnyPublisher<Data?, Error> {
        return Future { promise in
            Task {
                do {
                    let path = "users/\(path).jpg"
                    let data = try await self.client.storage
                        .from("vision-farming")
                        .download(path: path)
                    promise(.success(data))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func downloadList(in path: String) async throws -> [FileObject] {
        return try await client.storage.from("vision-farming").list(path: path)
    }
    
    func downloadImage(subPath: String,path: String) ->  AnyPublisher<Data?, Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        let data =  try await self.client.storage
                            .from("vision-farming")
                            .download(path: "\(subPath.lowercased())/\(path).jpg")
                        promise(.success(data))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func loadCategories() -> AnyPublisher<[UIImage], Error> {
//        return Future{ promise in
//            Task{
//                do{
//                    var images : [UIImage] = []
//                    let files = try await self.downloadList(in: SupabaseConstant.categories)
//                    for file in files{
//                        self.downloadImage(path: "\(SupabaseConstant.categories)\(file.name)")
//                            .receive(on: DispatchQueue.main)
//                            .sink { error in
//                                print(error)
//                            } receiveValue: { data in
//                                guard let data = data else { return }
//                                guard let uiImage = UIImage(data: data) else { return }
//                                images.append(uiImage)
//                            }
//                            .store(in: )
//                    }
//                    promise(.success(images))
//                }catch(let error){
//                    print(error,"category")
//                    promise(.failure(error))
//                }
//            }
//        }
//        .eraseToAnyPublisher()
//    }
    
}
