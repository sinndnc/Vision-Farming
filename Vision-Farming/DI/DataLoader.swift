//
//  UserDataLoader.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import Combine
import Foundation


final class DataLoader {
    
    let userRepository: UserRepository
    let cropRepository: CropRepository
    let farmRepository: FarmRepository
    let postRepository: PostRepository
    let fieldRepository: FieldRepository
    let sensorRepository: SensorRepository
    let productRepository: ProductRepository
    let transactionRepository: TransactionRepository
    
    init(
        userRepository: UserRepository,
        cropRepository: CropRepository,
        farmRepository: FarmRepository,
        postRepository: PostRepository,
        fieldRepository: FieldRepository,
        sensorRepository: SensorRepository,
        productRepository: ProductRepository,
        transactionRepository : TransactionRepository
    ) {
        self.userRepository = userRepository
        self.cropRepository = cropRepository
        self.farmRepository = farmRepository
        self.postRepository = postRepository
        self.fieldRepository = fieldRepository
        self.sensorRepository = sensorRepository
        self.productRepository = productRepository
        self.transactionRepository = transactionRepository
    }
    
    func loadAndListenUserData() -> AnyPublisher<(User?, [Transaction], [Crop], [Farm], [Field], [Sensor]), NetworkErrorCallback> {
        return userRepository.listen(policy: .staleWhileRevalidate())
            .flatMap { user -> AnyPublisher<(User?, [Transaction], [Crop], [Farm], [Field], [Sensor]), NetworkErrorCallback> in
                guard let user = user, let userId = user.id else {
                    Logger.log("❌ Kullanıcı bulunamadı veya ID eksik, akış kesiliyor.")
                    return Fail(
                        error: NetworkErrorCallback.local(NSError(domain: "UserNotFound", code: -1, userInfo: nil))
                    )
                    .eraseToAnyPublisher()
                }
                return Publishers.Zip3(
                    self.cropRepository.listen(owner_id: userId, policy: .staleWhileRevalidate()),
                    self.farmRepository.listen(owner_id: userId, policy: .staleWhileRevalidate()),
                    self.transactionRepository.listen(for: userId, policy: .staleWhileRevalidate())
                )
                .flatMap { crops, farms , transactions -> AnyPublisher<(User?, [Transaction], [Crop], [Farm], [Field], [Sensor]), NetworkErrorCallback> in
                    
                    let fieldPublishers = farms.compactMap { farm -> AnyPublisher<[Field], NetworkErrorCallback>? in
                        guard let farmId = farm.id else {
                            Logger.log("❌ Farm ID eksik, akış kesiliyor.")
                            return Fail(
                                error: NetworkErrorCallback.local(NSError(domain: "FarmIDNotFound", code: -2, userInfo: nil))
                            )
                            .eraseToAnyPublisher()
                        }
                        return self.fieldRepository.listen(owner_farm: farmId, policy: .staleWhileRevalidate())
                    }
                    return Publishers.MergeMany(fieldPublishers)
                        .flatMap { allFields -> AnyPublisher<(User?, [Transaction], [Crop], [Farm], [Field], [Sensor]), NetworkErrorCallback> in
                            let sensorPublishers = allFields.compactMap { field -> AnyPublisher<[Sensor], NetworkErrorCallback>? in
                                guard let fieldId = field.id else {
                                    Logger.log("❌ Field ID eksik, akış kesiliyor.")
                                    return Fail(
                                        error: NetworkErrorCallback.local(NSError(domain: "FieldIDNotFound", code: -3, userInfo: nil))
                                    )
                                    .eraseToAnyPublisher()
                                }
                                return self.sensorRepository.listen(owner_field: fieldId, policy: .staleWhileRevalidate())
                                    .map{ sensors ->[Sensor] in
                                        return Array(Set(sensors))
                                    }
                                    .eraseToAnyPublisher()
                                    
                            }
                            return Publishers.MergeMany(sensorPublishers)
                                .collect()
                                .map { allSensors in
                                    let flattenedSensors = allSensors.flatMap { $0 }
                                    
                                    let uniqueSensorsDict = Dictionary(grouping: flattenedSensors, by: { $0.id })
                                    let uniqueSensors = uniqueSensorsDict.compactMap { $0.value.first }
                                    
                                    return (user, transactions, crops, farms, allFields, uniqueSensors)
                                }
                                .eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func loadAndListenProductsAndPostsData() -> AnyPublisher<([Post],[MarketProduct]),NetworkErrorCallback> {
        let productPublisher = productRepository.listen(policy: .staleWhileRevalidate())
        let postPublisher = postRepository.listen(policy: .staleWhileRevalidate())
        return Publishers.Zip(
            postPublisher,
            productPublisher
        )
        .eraseToAnyPublisher()
    }
}
