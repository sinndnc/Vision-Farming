//
//  MockService.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/10/25.
//

import Foundation
import Supabase


final class MockService{
    
    private let url = URL(string:"https://cvqqoglxwzrakkkjplnq.supabase.co")!
    private let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN2cXFvZ2x4d3pyYWtra2pwbG5xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5NzIxMDUsImV4cCI6MjA2MDU0ODEwNX0.EoRHqKVweshs_g47r0lCinkZfHUqCc_sjcFRfUkP0jM"
    
    func mockLoader() -> DataLoader {
        let storage = StorageService(client: SupabaseClient(supabaseURL:url,supabaseKey: key))
        let cropRepo =  CropRepositoryImpl(
            local: LocalCropDataSourceImpl(),
            remote: RemoteCropDataSourceImpl(firestore: .firestore(), storage: storage),
            networkMonitor: NetworkMonitor()
        )
        let userRepo = UserRepositoryImpl(
            local: LocalUserDataSourceImpl(),
            remote: RemoteUserDataSourceImpl(firestore: .firestore(), storage: storage,auth: .auth()),
            networkMonitor: NetworkMonitor()
        )
        let farmRepo = FarmRepositoryImpl(
            local: LocalFarmDataSourceImpl(),
            remote: RemoteFarmDataSourceImpl(firestore: .firestore()),
            networkMonitor: NetworkMonitor()
        )
        let fieldRepo = FieldRepositoryImpl(
            local: LocalFieldDataSourceImpl(),
            remote: RemoteFieldDataSourceImpl(firestore: .firestore()),
            networkMonitor: NetworkMonitor()
        )
        let sensorRepo = SensorRepositoryImpl(
            local: LocalSensorDataSourceImpl(),
            remote: RemoteSensorDataSourceImpl(firestore: .firestore()),
            networkMonitor: NetworkMonitor()
        )
        let categoryRepo = CategoryRepositoryImpl(
            local: LocalCategoryDataSourceImpl(),
            remote: RemoteCategoryDataSourceImpl(firestore: .firestore(), storage: storage),
            networkMonitor: NetworkMonitor())
        let productRepo = ProductRepositoryImpl(
            remote: RemoteProductDataSourceImpl(firestore: .firestore(), storage: storage),
            networkMonitor: NetworkMonitor())
        let postRepo = PostRepositoryImpl(
            remote: RemotePostDataSourceImpl(firestore: .firestore(), storage: storage),
            networkMonitor: NetworkMonitor()
        )
        return DataLoader(
            userRepository: userRepo,
            cropRepository: cropRepo,
            farmRepository: farmRepo,
            postRepository: postRepo,
            fieldRepository: fieldRepo,
            sensorRepository: sensorRepo,
            productRepository: productRepo,
            categoryRepository: categoryRepo
        )
    }
}
