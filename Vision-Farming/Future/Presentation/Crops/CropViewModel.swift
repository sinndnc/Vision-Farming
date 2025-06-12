//
//  CropViewModel.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 6/12/25.
//

import Foundation


final class CropViewModel : BaseViewModel{
    
    @Published public var user : User?
    @Published public var crops : [Crop] = []
    @Published public var fields: [Field] = []
    
    private var cropRepository : CropRepository
    
    init(rootViewModel : RootViewModel){
        self.cropRepository = rootViewModel.loader.cropRepository
        super.init()
        rootViewModel.$user
            .assign(to: &$user)
        rootViewModel.$crops
            .assign(to: &$crops)
        rootViewModel.$fields
            .assign(to: &$fields)
    }
    
    func addCrop(for crop : Crop){
        cropRepository.add(crop)
    }
}
