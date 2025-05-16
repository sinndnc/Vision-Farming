//
//  DIContainer.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/7/25.
//

import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Supabase

struct DIContainer {
    static let shared = DIContainer()
    
    let rootViewModel: RootViewModel
    
    private let supabaseUrl = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String ?? ""
    private let supabaseKey =  Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as? String ?? ""

    private init() {
        
        let auth = Auth.auth()
        let settings = FirestoreSettings()
        let networkMonitor = NetworkMonitor()
        let firestore = Firestore.firestore()
        let client = SupabaseClient(
            supabaseURL: URL(string: supabaseUrl)!,
            supabaseKey: supabaseKey
        )
        let storage = StorageService(client: client)
        
        settings.cacheSettings = MemoryCacheSettings()
        firestore.settings = settings
        
        let userRepository = UserRepositoryImpl(
            local: LocalUserDataSourceImpl(),
            remote: RemoteUserDataSourceImpl(firestore: firestore, storage: storage,auth: auth),
            networkMonitor: networkMonitor
        )
        let cropRepository = CropRepositoryImpl(
            local: LocalCropDataSourceImpl(),
            remote: RemoteCropDataSourceImpl(firestore: firestore, storage: storage),
            networkMonitor: networkMonitor
        )
        let farmRepository = FarmRepositoryImpl(
            local: LocalFarmDataSourceImpl(),
            remote: RemoteFarmDataSourceImpl(firestore: firestore),
            networkMonitor: networkMonitor
        )
        let fieldRepository = FieldRepositoryImpl(
            local: LocalFieldDataSourceImpl(),
            remote: RemoteFieldDataSourceImpl(firestore: .firestore()),
            networkMonitor: networkMonitor
        )
        let sensorRepository = SensorRepositoryImpl(
            local: LocalSensorDataSourceImpl(),
            remote: RemoteSensorDataSourceImpl(firestore: firestore),
            networkMonitor: networkMonitor
        )
        let categoryRepository = CategoryRepositoryImpl(
            local: LocalCategoryDataSourceImpl(),
            remote: RemoteCategoryDataSourceImpl(firestore: firestore,storage: storage),
            networkMonitor: networkMonitor
        )
        let productRepository = ProductRepositoryImpl(
            remote: RemoteProductDataSourceImpl(firestore: firestore,storage: storage),
            networkMonitor: networkMonitor
        )
        let postRepository = PostRepositoryImpl(
            remote: RemotePostDataSourceImpl(firestore: firestore,storage: storage),
            networkMonitor: networkMonitor
        )
        
        let loader = DataLoader(
            userRepository: userRepository,
            cropRepository: cropRepository,
            farmRepository: farmRepository,
            postRepository: postRepository,
            fieldRepository: fieldRepository,
            sensorRepository: sensorRepository,
            productRepository: productRepository,
            categoryRepository: categoryRepository
        )
        
        self.rootViewModel = RootViewModel(loader: loader)
    }
    
}
