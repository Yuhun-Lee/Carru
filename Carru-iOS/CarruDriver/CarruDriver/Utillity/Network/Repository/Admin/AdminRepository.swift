//
//  AdminRepository.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Combine
import Moya
import CombineMoya
import Foundation

class AdminRepository: BaseRepository {
    private let provider = MoyaProvider<AdminAPI>()
    
    /// 미승인 유저 목록 조회
    func unApprovedUserList(type: AdminAPI.listType) -> AnyPublisher<[UnApprovedUser], Error> {
        provider.requestPublisher(.unApprovedUserList(type: type))
            .tryMap {
                try self.decodeResponse(UnApprovedUserListResponseDTO.self, from: $0)
            }
            .map{ $0.toUnApprovedUserList()}
            .eraseToAnyPublisher()
    }
    
    /// 유저 가입 승인
    func userSignUpRegister(userId: Int) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.userSignUpRegister(userId: userId))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 미승인 물류 조회
    func unApprovedLogisticsList() -> AnyPublisher<[UnApprovedLogistics], Error> {
        provider.requestPublisher(.unApprovedLogisticsList)
            .tryMap {
                try self.decodeResponse(UnApprovedLogisticsListResponseDTO.self, from: $0)
            }
            .map { $0.toUnApprovedLogisticsList() }
            .eraseToAnyPublisher()
    }

    
    /// 물류 승인
    func approveLogistics(logisticId: Int) -> AnyPublisher<CommonResponse, Error> {
        provider.requestPublisher(.approveLogistics(logisticId: logisticId))
            .tryMap {
                try self.decodeResponse(CommonResponse.self, from: $0)
            }
            .eraseToAnyPublisher()
    }
    
    /// 22. 관리자 - 물류 승인 리스트 조회
    func approvedLogisticsList() -> AnyPublisher<[ApprovedLogistics], Error> {
        provider.requestPublisher(.approvedLogisticsList)
            .tryMap {
                try self.decodeResponse(ApprovedLogisticsListResponseDTO.self, from: $0)
            }
            .map { $0.toApprovedLogisticsList() }
            .eraseToAnyPublisher()
    }

    
    /// 23. 관리자 - 물류 승인 리스트 상세 조회
    func approvedLogisticsDetail(logisticId: Int) -> AnyPublisher<ApprovedLogisticsDetail, Error> {
        provider.requestPublisher(.approvedLogisticsDetail(logisticId: logisticId))
            .tryMap {
                try self.decodeResponse(ApprovedLogisticsDetailResponseDTO.self, from: $0)
            }
            .map { $0.toApprovedLogisticsDetail() }
            .eraseToAnyPublisher()
    }

    /// 24-1 승인된 사용자 목록 조회
    func approvedUserList(type: AdminAPI.listType) -> AnyPublisher<[ApprovedUser], Error> {
        provider.requestPublisher(.approvedUserList(type: type))
            .tryMap {
                try self.decodeResponse(ApprovedUserListResponseDTO.self, from: $0)
            }
            .map { $0.toApprovedUserList() }
            .eraseToAnyPublisher()
    }

    
    /// 24-2. 관리자 - 화주 승인 리스트 상세 조회(화주의 승인된 물류 리스트 조회)
    func ownerApprovedList(userId: Int) -> AnyPublisher<[OwnerApprovedLogistics], Error> {
        provider.requestPublisher(.ownerApprovedList(userId: userId))
            .tryMap {
                try self.decodeResponse(OwnerApprovedListResponseDTO.self, from: $0)
            }
            .map { $0.toOwnerApprovedLogisticsList() }
            .eraseToAnyPublisher()
    }
    
    /// 25. 관리자 - 화물기사 승인 목록 조회(물류 매칭 목록 조회)
    func driverLogisticMatchingListDetail(userId: Int) -> AnyPublisher<[DriverLogisticMatching], Error> {
        provider.requestPublisher(.driverLogisticMatchingListDetail(userId: userId))
            .tryMap {
                try self.decodeResponse(DriverLogisticMatchingListResponseDTO.self, from: $0)
            }
            .map { $0.toDriverLogisticMatchingList() }
            .eraseToAnyPublisher()
    }
    
    /// 26. 관리자 - 화물기사 승인 목록 조회(경로 탐색 목록 조회)
    func driverRouteMatchingListDetail(userId: Int) -> AnyPublisher<[DriverRouteMatching], Error> {
        provider.requestPublisher(.driverRouteMatchingListDetail(userId: userId))
            .tryMap {
                try self.decodeResponse(DriverRouteMatchingListDetailResponseDTO.self, from: $0)
            }
            .map { $0.toDriverRouteMatchingDetails() }
            .eraseToAnyPublisher()
    }

    /// 27. 관리자 - 화물기사 승인 목록 상세 조회(화물기사의 물류 매칭 상세 조회)
    func driverLogisticMatchingDetail(logisticId: Int) -> AnyPublisher<DriverLogisticMatchingDetail, Error> {
        provider.requestPublisher(.driverLogisticMatchingDetail(logisticId: logisticId))
            .tryMap {
                try self.decodeResponse(DriverLogisticMatchingDetailResponseDTO.self, from: $0)
            }
            .map { $0.toDriverLogisticMatchingDetail() }
            .eraseToAnyPublisher()
    }

    /// 28. 관리자 - 화물기사 승인 목록 상세 조회(화물기사의 경로 탐색 상세)
    func driverRouteMatchingDetail(listId: Int) -> AnyPublisher<DriverRouteMatchingDetail, Error> {
        provider.requestPublisher(.driverRouteMatchingDetail(listId: listId))
            .tryMap {
                try self.decodeResponse(DriverRouteMatchingDetailResponseDTO.self, from: $0)
            }
            .map { $0.toDriverRouteMatchingDetail() }
            .eraseToAnyPublisher()
    }

}
