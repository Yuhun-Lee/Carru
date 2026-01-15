# Carru-iOS

<div align="center">

![iOS](https://img.shields.io/badge/iOS-14.0+-000000?style=flat-square&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-5.5+-F05138?style=flat-square&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-0081CB?style=flat-square&logo=swift&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

**AI 기반 화물 물류 매칭 플랫폼의 iOS 네이티브 애플리케이션**

[프로젝트 개요](#프로젝트-개요) • [주요 기능](#주요-기능) • [기술 스택](#기술-스택) • [아키텍처](#아키텍처) • [설치 방법](#설치-및-실행)

</div>

---

## 📱 프로젝트 개요

Carru-iOS는 화물 운송 산업의 비효율성을 해결하기 위해 개발된 **AI 기반 물류 매칭 플랫폼**의 iOS 클라이언트입니다. 화주(Owner), 기사(Driver), 관리자(Admin) 세 가지 역할을 하나의 애플리케이션에서 통합 지원하여 화물 운송의 전 과정을 디지털화합니다.

### 문제 정의
- 기사의 평균 40% 공차율 (빈 차량 운행)
- 화주와 기사 간 정보 비대칭
- 비효율적인 경로 계획으로 인한 시간/비용 낭비
- 중개인 의존적인 수동 매칭 프로세스

### 솔루션
- **AI 기반 최적 경로 추천**: XGBoost 모델을 활용한 3단계 경로 최적화
- **실시간 매칭 시스템**: 화주와 기사를 즉시 연결
- **멀티 스탑오버**: 한 번의 운행으로 최대 3개의 화물 운송
- **투명한 가격 책정**: 거리와 무게 기반 자동 가격 산정

---

## ✨ 주요 기능

### 🚛 기사(Driver) 모드

#### 1. 지능형 경로 찾기
- AI 추천 기반 최적 경로 탐색
- 출발지-도착지 간 경유지(Stopover) 자동 제안
- 실시간 지도 시각화 (Kakao Maps SDK)
- 예상 수익 및 거리 정보 제공

#### 2. 스마트 물류 매칭
- 조건별 필터링 (무게, 거리, 가격, 지역)
- 실시간 가용 화물 목록 조회
- 원터치 예약 시스템
- 화물 상태 실시간 추적

#### 3. 예약 관리
- 진행 중/완료된 예약 이력 관리
- 경로 기반 예약 (Route Matching)
- 물류 기반 예약 (Logistics Matching)
- 수익 통계 및 분석

#### 4. 프로필 & 설정
- 차량 정보 관리 (적재 용량, 차종)
- 차고지 위치 설정
- 선호도 설정 (수익 중심 vs 거리 중심)
- 푸시 알림 설정

---

### 📦 화주(Owner) 모드

#### 1. 물류 등록
- 간편한 화물 정보 입력
- 주소 자동 완성 및 지오코딩
- 무게, 가격, 배송 마감일 설정
- 사진 첨부 (선택)

#### 2. 물류 관리
- 승인 대기 중 물류 조회
- 승인된 물류 상태 추적
- 물류 정보 수정/삭제
- 매칭된 기사 정보 확인

#### 3. 창고 관리
- 다중 창고 등록 및 관리
- 창고별 재고 현황
- 창고 위치 지도 표시
- 자주 사용하는 창고 즐겨찾기

#### 4. 매칭 현황
- 내 물류에 매칭된 기사 목록
- 기사별 평가 및 이력
- 매칭 승인/거부
- 운송 진행 상황 실시간 모니터링

---

### 🛡️ 관리자(Admin) 모드

#### 1. 사용자 관리
- 신규 사용자 승인/거부
- 승인 대기 목록 관리
- 사용자 정보 조회 및 검증
- 역할별 사용자 통계

#### 2. 물류 승인
- 등록된 물류 검수
- 부적절한 물류 필터링
- 물류 정보 검증
- 승인/거부 사유 기록

#### 3. 매칭 모니터링
- 전체 매칭 현황 대시보드
- 기사-물류 매칭 상태 추적
- 경로 기반 매칭 분석
- 이상 거래 감지

#### 4. 통계 및 분석
- 플랫폼 전체 통계
- 사용자 활동 분석
- 수익 통계
- 지역별/시간대별 분석

---

## 🛠 기술 스택

### Core Technologies
```
iOS 14.0+  |  Swift 5.5+  |  SwiftUI 3.0+  |  Xcode 13.0+
```

### 프레임워크 & 라이브러리

| 카테고리 | 기술 | 버전 | 용도 |
|---------|------|------|------|
| **UI Framework** | SwiftUI | 3.0+ | 선언형 UI 구현 |
| **네트워킹** | Moya | 15.0.3 | 타입 세이프 네트워킹 |
| | Alamofire | 5.10.1 | HTTP 네트워킹 기반 |
| **지도** | Kakao Maps SDK | 2.12.0 | 지도 표시 및 상호작용 |
| **반응형 프로그래밍** | RxSwift | 6.8.0 | 비동기 처리 |
| | ReactiveSwift | 6.7.0 | 리액티브 데이터 흐름 |
| **보안** | Keychain | - | 토큰 안전 저장 |
| **위치** | CoreLocation | - | GPS 위치 추적 |

### 아키텍처 패턴

#### MVVM + Repository Pattern
```
View (SwiftUI)
    ↓
ViewModel (ObservableObject)
    ↓
Repository (Network Layer)
    ↓
NetworkManager (Moya/Alamofire)
    ↓
Backend API
```

#### 주요 설계 원칙
- **단일 책임 원칙**: 각 컴포넌트는 하나의 명확한 역할
- **의존성 역전**: Protocol 기반 추상화
- **관심사의 분리**: View-ViewModel-Model 명확한 분리
- **재사용 가능한 컴포넌트**: 공통 UI 컴포넌트 모듈화

---

## 📂 프로젝트 구조

```
CarruDriver/
├── 📱 App/                                    # 앱 진입점
│   ├── CarruDriverApp.swift                   # @main - SwiftUI App 구조
│   └── CarruAppDelegate.swift                 # UIKit Delegate (푸시, 백그라운드)
│
├── 📊 Models/                                 # 데이터 모델
│   ├── Admin/                                 # 관리자 전용 모델
│   │   ├── AdminUserType.swift
│   │   ├── ApprovedLogistics.swift
│   │   ├── DriverLogisticMatching.swift
│   │   └── UnApprovedLogistics.swift
│   ├── Owner/                                 # 화주 전용 모델
│   │   ├── OwnerApprovedLogistic.swift
│   │   ├── UnapprovedLogistics.swift
│   │   └── Warehouse.swift
│   ├── Reservation/                           # 예약 모델
│   │   ├── LogisticReservation.swift
│   │   └── RouteReservation.swift
│   ├── Errors/                                # 에러 타입 정의
│   ├── User.swift                             # 사용자 모델
│   ├── Logistic.swift                         # 물류 모델
│   ├── Address.swift                          # 주소 모델
│   └── AppType.swift                          # 앱 모드 열거형
│
├── 🎨 View/                                   # UI 레이어
│   ├── Main/                                  # 메인 화면
│   │   ├── MainView.swift                     # 기사 메인 화면
│   │   ├── Admin/                             # 관리자 화면들
│   │   │   ├── AdminMainView.swift
│   │   │   ├── AdminUserApprovalView.swift
│   │   │   └── AdminLogisticsApprovalView.swift
│   │   └── Owner/                             # 화주 화면들
│   │       ├── OwnerMainView.swift
│   │       ├── LogisticsRegisterView.swift
│   │       └── WarehouseManagementView.swift
│   ├── Tabs/                                  # 탭별 화면
│   │   ├── FindRoute/                         # 경로 찾기 탭
│   │   ├── MatchLogistics/                    # 물류 매칭 탭
│   │   ├── Reservations/                      # 예약 관리 탭
│   │   └── Setting/                           # 설정 탭
│   ├── Components/                            # 재사용 컴포넌트
│   │   ├── CRButton.swift                     # 커스텀 버튼
│   │   ├── CRTextField.swift                  # 커스텀 텍스트필드
│   │   ├── LoadingView.swift                  # 로딩 인디케이터
│   │   └── MapView.swift                      # 지도 래퍼 뷰
│   └── Sign/                                  # 인증 화면
│       ├── LoginView.swift
│       └── SignUpView.swift
│
├── 🔧 Utillity/                               # 유틸리티
│   ├── Network/                               # 네트워킹 레이어
│   │   ├── NetworkManager.swift               # 네트워크 매니저
│   │   ├── Targets/                           # Moya Target 정의
│   │   │   ├── UserTarget.swift
│   │   │   ├── DriverTarget.swift
│   │   │   ├── OwnerTarget.swift
│   │   │   └── AdminTarget.swift
│   │   ├── Repository/                        # 데이터 저장소
│   │   │   ├── UserRepository.swift
│   │   │   ├── DriverRepository.swift
│   │   │   ├── OwnerRepository.swift
│   │   │   └── AdminRepository.swift
│   │   └── DTO/                               # 데이터 전송 객체
│   │       ├── CommonResponse.swift
│   │       ├── CommonErrorResponse.swift
│   │       ├── DriverDTO/
│   │       ├── OwnerDTO/
│   │       └── AdminDTO/
│   ├── Extensions/                            # Swift 확장
│   │   ├── Color+CarruDriver.swift            # 커스텀 컬러
│   │   ├── Font+Pretendard.swift              # 커스텀 폰트
│   │   ├── Date+Format.swift                  # 날짜 포맷팅
│   │   └── String+Date_ISO_8601.swift         # ISO 8601 변환
│   ├── Navigation/                            # 네비게이션 관리
│   │   ├── Screen.swift                       # 화면 열거형
│   │   └── DefaultView.swift                  # 기본 네비게이션 뷰
│   ├── LocationManager.swift                  # 위치 관리 싱글톤
│   ├── MainViewManager.swift                  # 앱 상태 관리
│   ├── Keychain.swift                         # 키체인 래퍼
│   ├── Logger.swift                           # 로깅 유틸리티
│   └── InfoManager.swift                      # Info.plist 접근
│
└── 🎨 Resources/                              # 리소스
    ├── Assets.xcassets/                       # 이미지 에셋
    │   └── appIcon.appiconset/
    ├── Color.xcassets/                        # 색상 팔레트
    │   ├── Driver/                            # 기사 모드 색상 (Blue)
    │   ├── Owner/                             # 화주 모드 색상 (Red)
    │   ├── Admin/                             # 관리자 모드 색상 (Green)
    │   └── Main/                              # 공통 색상
    ├── Font/                                  # Pretendard 폰트 패밀리
    │   ├── Pretendard-Regular.otf
    │   ├── Pretendard-Medium.otf
    │   ├── Pretendard-SemiBold.otf
    │   ├── Pretendard-Bold.otf
    │   └── ...
    └── Info.plist                             # 앱 설정 및 환경 변수
```

---

## 🏗 아키텍처

### 1. MVVM + Repository Pattern

#### View Layer (SwiftUI)
- 선언형 UI 구현
- `@StateObject`, `@ObservedObject`를 통한 반응형 데이터 바인딩
- 재사용 가능한 컴포넌트 라이브러리

#### ViewModel Layer
- 비즈니스 로직 처리
- View와 Model 간 데이터 변환
- `@Published` 프로퍼티를 통한 상태 관리
- Repository를 통한 데이터 요청

#### Repository Layer
- 데이터 소스 추상화
- 네트워크 API 호출 캡슐화
- DTO ↔ Model 변환
- 에러 핸들링

#### Network Layer (Moya)
- 타입 세이프 API 정의
- `TargetType` 프로토콜 구현
- Alamofire 기반 HTTP 통신
- JWT 토큰 자동 주입

### 2. 역할 기반 아키텍처

```swift
enum AppType {
    case driver   // 기사 모드
    case owner    // 화주 모드
    case admin    // 관리자 모드
}
```

로그인 시 사용자 역할에 따라 적절한 UI와 기능 활성화:
- **Driver**: MainView → TabView (FindRoute, MatchLogistics, Reservations, Setting)
- **Owner**: OwnerMainView → TabView (Logistics, Warehouse, Matching, Setting)
- **Admin**: AdminMainView → TabView (UserApproval, LogisticsApproval, Dashboard)

### 3. 상태 관리

#### MainViewManager (Global State)
```swift
class MainViewManager: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false
    @Published var appType: AppType = .driver
}
```

#### 싱글톤 패턴
- `LocationManager`: GPS 위치 추적
- `Keychain`: 토큰 안전 저장
- `Logger`: 통합 로깅

---

## 🔐 보안 및 인증

### JWT 토큰 기반 인증
1. 로그인 시 서버로부터 JWT 토큰 수신
2. Keychain에 암호화 저장
3. 모든 API 요청 시 Header에 자동 포함 (`X-AUTH-TOKEN`)
4. 토큰 만료 시 자동 로그아웃

### Keychain 보안 저장소
```swift
Keychain.shared.save(key: "accessToken", value: token)
let token = Keychain.shared.load(key: "accessToken")
```

### 네트워크 보안
- HTTPS 통신 (App Transport Security)
- Certificate Pinning (선택적)
- 민감 정보 암호화

---

## 🌐 API 통신

### Moya를 활용한 타입 세이프 네트워킹

```swift
enum DriverTarget {
    case logisticsMatchingList(request: LogisticsMatchingRequest)
    case reserveLogistics(id: Int)
    case getReservationList
}

extension DriverTarget: TargetType {
    var baseURL: URL {
        return URL(string: InfoManager.shared.carruServerBaseURL)!
    }

    var path: String {
        switch self {
        case .logisticsMatchingList:
            return "/v1/driver/logisticsMatchingList"
        case .reserveLogistics(let id):
            return "/v1/driver/logisticsMatching/\(id)"
        case .getReservationList:
            return "/v1/driver/routeMatching/reservingList"
        }
    }

    var method: Moya.Method {
        switch self {
        case .logisticsMatchingList, .reserveLogistics:
            return .post
        case .getReservationList:
            return .get
        }
    }

    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if let token = Keychain.shared.load(key: "accessToken") {
            headers["X-AUTH-TOKEN"] = token
        }
        return headers
    }
}
```

### Repository 패턴 구현

```swift
class DriverRepository {
    private let provider = MoyaProvider<DriverTarget>()

    func fetchLogisticsMatchingList(
        request: LogisticsMatchingRequest
    ) async throws -> [Logistic] {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.logisticsMatchingList(request: request)) { result in
                switch result {
                case .success(let response):
                    // DTO → Model 변환
                    let logistics = self.parseResponse(response)
                    continuation.resume(returning: logistics)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
```

---

## 🗺 위치 기반 서비스

### LocationManager
- **실시간 GPS 추적**: CoreLocation 프레임워크 활용
- **권한 관리**: 위치 접근 권한 요청 및 처리
- **배터리 최적화**: 필요 시에만 위치 업데이트

### Kakao Maps SDK 통합
- 지도 표시 및 마커 추가
- 경로 드로잉 (Polyline)
- 클러스터링 (다중 마커)
- 주소 검색 및 지오코딩

### 주소 자동 완성
- Kakao 주소 검색 API 활용
- 실시간 검색어 제안
- 지번/도로명 주소 지원
- 좌표 변환 (Geocoding)

---

## 🎨 디자인 시스템

### 색상 팔레트 (Role-based)

#### Driver (기사 모드)
- **Primary**: `CRBlue` (#4A90E2)
- **Background**: Light Blue Tint

#### Owner (화주 모드)
- **Primary**: `CRRed` (#E74C3C)
- **Background**: `CRRedBackground` (Light Red Tint)

#### Admin (관리자 모드)
- **Primary**: `CRGreen` (#27AE60)
- **Background**: `CRGreenBackground` (Light Green Tint)

#### Common
- **Background**: `CRBackground` (#F8F9FA)
- **Text**: `CRText` (#212529)
- **Gray**: `CRGray` (#ADB5BD), `CRGray2` (#6C757D)

### 타이포그래피 (Pretendard Font)

| 용도 | Weight | Size |
|------|--------|------|
| **Heading 1** | Bold | 28pt |
| **Heading 2** | SemiBold | 24pt |
| **Heading 3** | SemiBold | 20pt |
| **Body** | Regular | 16pt |
| **Body Bold** | SemiBold | 16pt |
| **Caption** | Regular | 14pt |
| **Small** | Regular | 12pt |

### 컴포넌트 라이브러리
- **CRButton**: 역할별 색상 자동 적용
- **CRTextField**: 유효성 검사 내장
- **CRCard**: 그림자 및 라운드 코너
- **LoadingView**: 커스텀 로딩 애니메이션

---

## 🚀 설치 및 실행

### 1. 필수 요구사항
```
- macOS 12.0 (Monterey) 이상
- Xcode 13.0 이상
- iOS 14.0 이상 지원 디바이스
- CocoaPods 또는 Swift Package Manager
```

### 2. 레포지토리 클론
```bash
git clone https://github.com/Yuhun-Lee/Carru.git
cd Carru/Carru-iOS
```

### 3. 환경 변수 설정

`.xcconfig` 파일 생성 또는 Xcode Build Settings에 추가:

```
CARRU_SERVER_BASE_URL = https://api.carru.com
CARRU_AI_SERVER_BASE_URL = https://ai.carru.com
KAKAO_MAP_API_KEY = your_kakao_map_api_key
KAKAO_MAP_OWNER_API_KEY = your_kakao_map_owner_api_key
KAKAO_MAP_ADMIN_API_KEY = your_kakao_map_admin_api_key
ADDRESS_SEARCH_BASE_URL = https://dapi.kakao.com
ADDRESS_SEARCH_API_KEY = your_address_search_api_key
GEO_CODER_BASE_URL = https://dapi.kakao.com
GEO_CODER_API_KEY = your_geocoder_api_key
```

### 4. Xcode에서 프로젝트 열기
```bash
open CarruDriver/CarruDriver.xcodeproj
```

### 5. Swift Package Manager 의존성 자동 해결
Xcode가 자동으로 Package.resolved 파일을 기반으로 의존성을 다운로드합니다.

### 6. 빌드 및 실행
- Scheme 선택: `CarruDriver`
- 타겟 디바이스 선택 (시뮬레이터 또는 실제 디바이스)
- `Cmd + R` 실행 또는 Product → Run

---

## 📊 주요 화면 흐름

### 기사(Driver) 플로우
```
로그인 → 메인 탭 바 화면
    ├── 경로 찾기
    │   └── 출발/도착 입력 → AI 경로 추천 → 경유지 선택 → 예약 완료
    ├── 물류 매칭
    │   └── 필터 설정 → 물류 목록 조회 → 상세 보기 → 예약
    ├── 예약 관리
    │   └── 진행 중/완료 목록 → 상세 조회 → 상태 업데이트
    └── 설정
        └── 프로필 편집 → 차고지 설정 → 선호도 설정
```

### 화주(Owner) 플로우
```
로그인 → 메인 탭 바 화면
    ├── 물류 등록
    │   └── 화물 정보 입력 → 창고 선택 → 가격 설정 → 등록
    ├── 물류 관리
    │   ├── 미승인 목록 → 수정/삭제
    │   └── 승인 목록 → 상태 추적
    ├── 창고 관리
    │   └── 창고 추가/편집/삭제 → 지도에서 위치 선택
    └── 매칭 현황
        └── 매칭된 기사 목록 → 승인/거부
```

### 관리자(Admin) 플로우
```
로그인 → 메인 탭 바 화면
    ├── 사용자 승인
    │   └── 대기 목록 → 정보 확인 → 승인/거부
    ├── 물류 승인
    │   └── 대기 목록 → 검수 → 승인/거부
    ├── 매칭 모니터링
    │   └── 전체 현황 → 상세 조회
    └── 대시보드
        └── 통계 및 분석
```

---

## 🧪 테스트

### 단위 테스트
```bash
# Xcode에서 테스트 실행
Cmd + U

# 특정 테스트만 실행
xcodebuild test -scheme CarruDriver -destination 'platform=iOS Simulator,name=iPhone 14'
```

### UI 테스트
- SwiftUI Preview를 활용한 빠른 UI 검증
- 각 View 파일에 `#Preview` 매크로 포함

---

## 📈 성능 최적화

### 네트워킹 최적화
- **이미지 캐싱**: 다운로드한 이미지 메모리/디스크 캐싱
- **페이지네이션**: 대량 데이터 lazy loading
- **Debouncing**: 검색 입력 시 과도한 API 호출 방지

### UI 렌더링 최적화
- **LazyVStack/LazyHStack**: 화면에 보이는 항목만 렌더링
- **Image Resizing**: 화면 크기에 맞는 이미지 리사이징
- **ViewBuilder**: 불필요한 뷰 재생성 방지

### 메모리 관리
- **Weak/Unowned 참조**: 순환 참조 방지
- **Deallocation 확인**: 화면 전환 시 메모리 해제 검증

---

## 🔄 버전 관리

### Git Flow 전략
```
main (프로덕션)
  └── develop (개발)
        ├── feature/driver-route-finding
        ├── feature/owner-logistics-register
        └── feature/admin-approval-system
```

### 커밋 컨벤션
```
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷팅, 세미콜론 누락 등
refactor: 코드 리팩토링
test: 테스트 코드 추가
chore: 빌드 설정, 패키지 매니저 수정
```

---

## 🤝 기여 방법

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 라이선스

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 개발팀

- **iOS Developer**: [이주훈](https://github.com/Yuhun-Lee)
- **Backend Developer**: Capstone Team
- **AI/ML Engineer**: Capstone Team

---

## 📞 문의

프로젝트 관련 문의사항이나 버그 리포트는 [Issues](https://github.com/Yuhun-Lee/Carru/issues) 탭을 이용해주세요.

---

## 🔗 관련 프로젝트

- [Carru-Backend](../Carru-Backend/README.md) - Spring Boot 기반 백엔드 API 서버
- [Carru-AI](../Carru-AI-develop/README.md) - XGBoost 기반 경로 최적화 AI 서비스

---

<div align="center">

**Made with ❤️ by Carru Team**

[⬆ Back to Top](#carru-ios)

</div>
