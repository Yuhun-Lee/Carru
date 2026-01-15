# Carru: AI 기반 화물 물류 매칭 플랫폼

<div align="center">

![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Backend%20%7C%20AI-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)

**화물 운송 산업의 비효율성을 해결하는 종합 물류 플랫폼**

[프로젝트 개요](#-프로젝트-개요) • [주요 기능](#-주요-기능) • [기술 스택](#-기술-스택) • [아키텍처](#-시스템-아키텍처)

<img src="https://img.shields.io/badge/iOS-14.0+-000000?style=flat-square&logo=apple&logoColor=white" />
<img src="https://img.shields.io/badge/Swift-5.5+-F05138?style=flat-square&logo=swift&logoColor=white" />
<img src="https://img.shields.io/badge/Spring%20Boot-3.3.5-6DB33F?style=flat-square&logo=spring-boot&logoColor=white" />
<img src="https://img.shields.io/badge/Python-3.8+-3776AB?style=flat-square&logo=python&logoColor=white" />
<img src="https://img.shields.io/badge/XGBoost-1.7+-FF6600?style=flat-square" />
<img src="https://img.shields.io/badge/MySQL-8.0+-4479A1?style=flat-square&logo=mysql&logoColor=white" />

</div>

---

## 📋 목차

- [프로젝트 개요](#-프로젝트-개요)
- [문제 정의](#-문제-정의)
- [솔루션](#-솔루션)
- [주요 기능](#-주요-기능)
- [기술 스택](#-기술-스택)
- [시스템 아키텍처](#-시스템-아키텍처)
- [프로젝트 구조](#-프로젝트-구조)
- [시작하기](#-시작하기)
- [데모 및 스크린샷](#-데모-및-스크린샷)
- [성과 및 지표](#-성과-및-지표)
- [향후 계획](#-향후-계획)
- [기여하기](#-기여하기)
- [라이선스](#-라이선스)
- [팀](#-팀)

---

## 🎯 프로젝트 개요

**Carru**는 화물 운송 산업의 비효율성을 AI 기술로 해결하는 종합 물류 매칭 플랫폼입니다. 화주(Owner), 기사(Driver), 관리자(Manager) 세 가지 역할을 통합 지원하며, **XGBoost 머신러닝 모델**을 활용한 지능형 경로 최적화로 빈 차량 운행을 최소화하고 물류 비용을 절감합니다.

### 핵심 가치 제안

```
🚛 기사: AI 기반 경로 최적화로 경유지 활용 시 수익 증대 가능
📦 화주: 빠른 매칭, 투명한 정보 공유, 물류 상태 추적
🛡️ 관리자: 사용자 및 물류 승인 관리, 매칭 현황 모니터링
🤖 AI: 3단계 경로 최적화로 최대 3개 화물 동시 운송 추천
```

---

## 🔍 문제 정의

### 현재 화물 운송 산업의 문제점

| 문제 | 현황 | 영향 |
|------|------|------|
| **높은 공차율** | 평균 40% 빈 차량 운행 | 연간 수천억 원 손실 |
| **정보 비대칭** | 기사-화주 간 정보 단절 | 비효율적 매칭 |
| **수동 프로세스** | 중개인 의존 수동 매칭 | 2-3일 소요 |
| **비투명한 가격** | 불명확한 가격 책정 | 신뢰 부족 |
| **경로 비효율** | 단순 A-B 직선 운행 | 기회 비용 손실 |

### 실제 데이터

```
📊 국내 화물 운송 통계 (2023년 기준)
- 총 화물 차량: 약 420만 대
- 공차율: 평균 40%
- 연간 공차로 인한 손실: 약 8조 원
- 평균 매칭 소요 시간: 2-3일
```

---

## 💡 솔루션

### Carru의 3가지 핵심 솔루션

#### 1. AI 기반 경로 최적화

```
기존 방식:
서울 → 부산 (빈 차량) → 1개 화물, 15만원

Carru 방식:
서울 → [대전 경유] → [대구 경유] → 부산 → 3개 화물, 32만원
     ↓ AI 추천    ↓ AI 추천
   추가 12km    추가 20km

결과: +47km 추가 주행으로 수익 213% 증가
```

#### 2. 실시간 매칭 시스템

- **즉시 매칭**: 화주가 등록하면 즉시 가용 기사에게 노출
- **필터링**: 거리, 무게, 가격, 지역 기반 맞춤 검색
- **투명성**: 모든 정보 실시간 공개 (가격, 위치, 기사 평점)

#### 3. 통합 관리 플랫폼

- **멀티 롤**: 하나의 앱에서 기사/화주/관리자 모드 전환
- **승인 자동화**: AI 기반 신뢰도 평가로 승인 프로세스 간소화
- **실시간 대시보드**: 전체 매칭 현황 한눈에 파악

---

## ✨ 주요 기능

### 🚛 기사(Driver) 기능

<table>
<tr>
<td width="50%">

**경로 탐색 (Find Route)**
- 출발지/도착지 입력 (현재위치 버튼 제공)
- 무게 범위 설정 (최소/최대)
- 출발 시간 및 선호 비율 설정
- AI 기반 경로 예측 및 추천 결과 확인
- 경로별 상세 지도 시각화 (Kakao Maps)

</td>
<td width="50%">

**물류 매칭 (Match Logistics)**
- 무게 범위 기반 물류 검색
- 매칭된 물류 리스트 조회
- 물류별 상세 정보 확인
- 지도에서 물류 위치 확인
- 원터치 예약 기능

</td>
</tr>
<tr>
<td>

**예약 관리 (Reservations)**
- 물류 매칭 예약 목록
- 경로 탐색 예약 목록
- 배송 상태 변경 (TODO → 진행중 → 완료)
- 예약별 상세 정보 및 지도 확인

</td>
<td>

**설정 (Settings)**
- 프로필 조회 및 이름 변경
- 차고지 위치 변경
- 사용자 정보 확인

</td>
</tr>
</table>

### 📦 화주(Owner) 기능

<table>
<tr>
<td width="50%">

**물류 등록 (Logistic Register)**
- 물류 카테고리 선택 (물품 종류)
- 무게, 목적지(도시명), 마감시간 입력
- 창고 선택 (검색 기능)
- 신규 물류 등록 및 수정
- 미승인 물류 삭제

</td>
<td width="50%">

**미승인 물류 관리 (Unapproved)**
- 관리자 승인 대기 중인 물류 목록
- 물류 상세 정보 조회
- 지도에서 위치 확인
- 수정 및 삭제 기능

</td>
</tr>
<tr>
<td colspan="2">

**승인된 물류 관리 (Approved)**
- 상태별 필터링 (예약대기/진행중/완료)
- 승인된 물류 목록 조회
- 물류 상세 정보 및 진행 상황 확인
- 지도에서 물류 위치 확인

</td>
</tr>
</table>

### 🛡️ 관리자(Admin) 기능

<table>
<tr>
<td width="33%">

**사용자 관리**
- 신규 가입자 미승인 목록 조회 (기사/화주)
- 신규 가입자 승인 처리
- 승인된 사용자 목록 조회
- 화주별 등록 물류 목록 조회
- 기사별 매칭 이력 조회

</td>
<td width="33%">

**물류 관리**
- 미승인 물류 목록 조회
- 물류 승인 처리
- 승인된 물류 목록 조회
- 물류 상세 정보 조회
- 기사별 경로 탐색 내역 조회

</td>
<td width="33%">

**매칭 현황 조회**
- 기사의 물류 매칭 목록 조회
- 기사의 경로 탐색 목록 조회
- 물류 매칭 상세 정보 조회
- 경로 탐색 상세 정보 조회
- 전체 매칭 내역 모니터링

</td>
</tr>
</table>

---

## 🛠 기술 스택

### 📱 Frontend (iOS)

```
SwiftUI 3.0+ | Moya 15.0.3 | RxSwift 6.8.0 | Kakao Maps SDK 2.12.0
```

- **UI Framework**: SwiftUI 기반 선언형 UI
- **Architecture**: MVVM + Repository Pattern
- **Networking**: Moya + Combine을 활용한 타입 세이프 API 통신
- **Security**: Keychain 기반 JWT 토큰 안전 저장
- **Maps**: Kakao Maps SDK 지도 시각화
- **Location**: LocationManager를 통한 현재 위치 조회 및 권한 관리
- **Multi-Role**: 기사/화주/관리자 3가지 역할 통합 지원 (AppType enum)

### 🖥️ Backend (Server)

```
Spring Boot 3.3.5 | Java 17+ | MySQL 8.0+ | JWT | QueryDSL 5.0.0
```

- **Framework**: Spring Boot 3.3.5
- **Database**: MySQL 8.0+ with JPA/Hibernate
- **Security**: JWT 토큰 기반 인증 + Spring Security
- **Query**: QueryDSL을 활용한 복잡한 쿼리 처리
- **API Docs**: Swagger/OpenAPI 3.0 자동 문서화

### 🤖 AI/ML (Intelligence)

```
Python 3.8+ | XGBoost 1.7+ | Flask 2.0+ | scikit-learn 1.0+ | Pandas 1.5+
```

- **ML Model**: XGBoost 그래디언트 부스팅
- **API Server**: Flask REST API
- **Data Processing**: Pandas, NumPy
- **Preprocessing**: StandardScaler, MinMaxScaler
- **Geographic**: geopy (지오코딩, 거리 계산)

### 🔧 Development Tools

```
Git | Xcode 13+ | IntelliJ IDEA | Jupyter Notebook | Postman | MySQL Workbench
```

---

## 🔐 보안 (iOS Keychain 구현)

### Keychain 기반 토큰 관리

iOS 앱에서는 JWT AccessToken과 RefreshToken을 디바이스의 Keychain에 안전하게 저장합니다. Keychain은 iOS의 보안 저장소로, 암호화된 데이터베이스에 민감한 정보를 저장하는 Apple의 공식 보안 메커니즘입니다.

**구현 위치**: [Keychain.swift](Carru-iOS/CarruDriver/CarruDriver/Utillity/Keychain.swift)

**주요 기능**

1. **토큰 저장 및 업데이트**
```swift
// 토큰 추가 또는 업데이트 (중복 체크 후 자동 처리)
try Keychain.addOrUpdateToken(kind: .accessToken, token: "eyJhbGc...")
try Keychain.addOrUpdateToken(kind: .refreshToken, token: "eyJhbGc...")
```

2. **토큰 조회**
```swift
// Keychain에서 토큰 읽기
let accessToken = try Keychain.searchToken(kind: .accessToken)
```

3. **토큰 삭제**
```swift
// 로그아웃 시 토큰 삭제
try Keychain.deleteToken(kind: .accessToken)
try Keychain.deleteToken(kind: .refreshToken)
```

**보안 특징**

- **암호화 저장**: iOS 시스템 레벨에서 자동 암호화
- **앱 샌드박스**: 다른 앱에서 접근 불가
- **재설치 후 유지**: 앱 삭제 시에만 데이터 제거
- **에러 핸들링**: KeychainError enum으로 명확한 에러 처리
  - `encodingFailed`: 토큰 인코딩 실패
  - `decodingFailed`: 토큰 디코딩 실패
  - `notFound`: 토큰을 찾을 수 없음
  - `unhandledError`: 예상치 못한 에러

**사용 예시**

```swift
// 로그인 성공 후 토큰 저장
do {
    try Keychain.addOrUpdateToken(kind: .accessToken, token: response.accessToken)
    try Keychain.addOrUpdateToken(kind: .refreshToken, token: response.refreshToken)
    print("✅ 토큰 저장 완료")
} catch {
    print("❌ 토큰 저장 실패: \(error.localizedDescription)")
}

// API 요청 시 토큰 조회
do {
    let token = try Keychain.searchToken(kind: .accessToken)
    // Moya Plugin에서 자동으로 Header에 주입
} catch KeychainError.notFound {
    // 로그인 화면으로 이동
}
```

---

## 🏗 시스템 아키텍처

### 전체 시스템 구성

**Client Layer (iOS 앱)**
- SwiftUI 기반 네이티브 iOS 애플리케이션
- 기사(Driver), 화주(Owner), 관리자(Admin) 3가지 모드 통합 지원
- HTTPS/REST API를 통한 Backend 서버 통신
- JWT 기반 인증

**Application Layer (Spring Boot Backend)**
- Port 8080에서 실행되는 REST API 서버
- Controllers: UserController, DriverController, ShipperController, ManagerController
- Services: JWT 인증, 매칭 알고리즘, 가격 계산 등 비즈니스 로직 처리
- Repositories: JPA + QueryDSL을 활용한 데이터 접근 계층

**Database Layer**
- MySQL 8.0+ 사용
- 주요 테이블: users, products, warehouses, reservations, prices

**AI Service Layer**
- Flask 기반 AI 서버 (Port 5000)
- XGBoost 기반 3단계 경로 최적화 모델
  - First Route Model: 메인 화물 예측
  - First Stopover Model: 1차 경유지 Top 3 추천
  - Second Stopover Model: 2차 경유지 추천
- 데이터 전처리 및 매칭 알고리즘 파이프라인

---

### iOS 앱 아키텍처

**MVVM + Repository Pattern**

```
View (SwiftUI)
  ├─ 사용자 인터랙션 처리
  ├─ UI 상태 변경 반영
  └─ @ObservedObject, @StateObject를 통한 ViewModel 바인딩
      ↓
ViewModel
  ├─ 비즈니스 로직 처리
  ├─ View에 표시할 데이터 가공
  ├─ Combine으로 비동기 이벤트 처리
  └─ Repository와 통신
      ↓
Repository (7개 구현)
  ├─ BaseRepository (공통 디코딩 로직)
  ├─ UserRepository (인증, 프로필)
  ├─ OwnerRepository (화주 물류 CRUD)
  ├─ AdminRepository (관리자 승인)
  ├─ LogisticMatchingRepository (물류/경로 매칭)
  ├─ ReservationRepository (예약 상태 관리)
  └─ AddressRepository (주소 검색)
      ↓
Network Layer (Moya + Combine)
  ├─ API 엔드포인트 정의 (TargetType)
  ├─ JWT 토큰 자동 주입 (Authorization Header)
  ├─ 응답 자동 파싱 (Codable)
  ├─ AnyPublisher 반환
  └─ 에러 핸들링
      ↓
Backend API (40+ 엔드포인트)
```

**주요 컴포넌트**

- **Keychain**: JWT 토큰 안전 저장 및 관리 (X-AUTH-TOKEN)
- **LocationManager**: 현재 위치 조회 및 권한 관리 (ObservableObject)
- **MainViewManager**: 로그인 상태 관리 (isLoggedIn)
- **InfoManager**: 환경 변수 및 설정 관리 (Base URL, API Keys)
- **AppType**: 역할 분리 (Driver/Owner/Admin)
- **Extensions**: Swift 확장을 통한 유틸리티 함수 제공
- **Custom Components**: 재사용 가능한 SwiftUI 컴포넌트

### 데이터 흐름

**1. 사용자 인증 플로우**
```
iOS 앱에서 로그인 시도 (역할 선택: 기사/화주/관리자)
  ↓
Moya + Combine을 통해 POST /v1/user/login 요청
  ↓
Backend에서 JWT Token 발급 (X-AUTH-TOKEN)
  ↓
iOS Keychain에 토큰 안전 저장 (Keychain.addOrUpdateToken())
  ↓
MainViewManager의 isLoggedIn 플래그 업데이트
  ↓
역할별 메인 화면으로 이동 (MainView/OwnerMainView/AdminMainView)
  ↓
이후 모든 API 요청 시 Keychain에서 토큰 조회하여 Authorization Header에 자동 삽입
```

**2. 경로 최적화 요청 플로우 (기사 모드)**
```
1. 기사가 FindRouteView에서 정보 입력
   - 출발지 입력 (현재위치 버튼으로 자동 입력 가능)
   - 도착지 입력
   - 무게 범위, 출발 시간, 선호 비율 설정
   ↓
2. iOS 앱이 AI 서버에 POST /predict 요청
   - LogisticMatchingRepository 사용
   - Moya + Combine으로 비동기 처리
   ↓
3. Flask AI 서버가 3단계 XGBoost 모델 실행
   - 메인 화물 + 경유지 2개 추천
   ↓
4. iOS 앱이 JSON 응답 수신
   - Combine Publisher로 비동기 처리
   - Codable로 RoutePredict 모델로 변환
   ↓
5. FindRouteViewModel이 @Published 프로퍼티 업데이트
   ↓
6. SwiftUI View 자동 업데이트
   - RouteListView에 추천 경로 표시
   - 선택 시 SuggestRouteMapView로 이동
   - Kakao Maps로 경로 시각화
```

**3. 물류 예약 플로우 (기사 모드)**
```
기사가 물류 선택 및 예약 버튼 탭
  ↓
ReservationRepository를 통해 예약 요청
  - POST /v1/driver/logisticsMatching/{id} (물류 매칭)
  - POST /v1/driver/routeMatching (경로 탐색)
  ↓
Backend에서 예약 처리
  ↓
iOS 앱에 예약 완료 응답
  ↓
ReservationsView에서 예약 목록 자동 갱신
  - GET /v1/driver/logisticsMatching/reservingList
  - GET /v1/driver/routeMatching/reservingList
  ↓
배송 상태 변경 가능 (TODO → 진행중 → 완료)
```

**4. 물류 등록 플로우 (화주 모드)**
```
화주가 LogisticRegisterView에서 물류 정보 입력
  - 카테고리, 무게, 목적지, 마감시간, 창고 선택
  ↓
OwnerRepository를 통해 POST /v1/shipper/logistics 요청
  ↓
Backend에서 물류 등록 (미승인 상태)
  ↓
UnapprovedLogisticsView에 새 물류 표시
  ↓
관리자가 승인하면 ApprovedLogisticsView로 이동
```

---

## 🚀 시작하기

### iOS 앱 실행

**개발 환경 요구사항**
- macOS 13.0 이상
- Xcode 14.0 이상
- iOS 14.0 이상 타겟 디바이스
- Swift 5.5+

**프로젝트 설정**

```bash
# 레포지토리 클론
git clone https://github.com/Yuhun-Lee/Carru.git
cd Carru/Carru-iOS

# Xcode에서 프로젝트 열기
open CarruDriver/CarruDriver.xcodeproj
```

**환경 변수 설정 (Info.plist)**
```xml
<key>CARRU_SERVER_BASE_URL</key>
<string>https://api.carru.com</string>
<key>KAKAO_MAP_API_KEY</key>
<string>your_kakao_api_key_here</string>
```

**주요 기능 구현 사항**

1. **역할 기반 아키텍처 (Multi-Role System)**
   - `AppType` enum으로 역할 구분 (Driver/Owner/Admin)
   - 역할별 독립적인 메인 화면 및 탭 구조
   - 191개 Swift 파일로 구성된 프로덕션 레벨 아키텍처

2. **인증 시스템 (Keychain 기반)**
   - JWT 토큰(X-AUTH-TOKEN)을 iOS Keychain에 안전 저장
   - `Keychain.swift`에서 토큰 CRUD 작업 처리
   - 주요 메서드:
     - `addOrUpdateToken()`: 토큰 추가 또는 업데이트
     - `searchToken()`: 저장된 토큰 조회
     - `deleteToken()`: 토큰 삭제
   - `MainViewManager`로 로그인 상태 관리

3. **네트워킹 (Moya + Combine)**
   - 타입 세이프한 API 통신 (40+ 엔드포인트)
   - Combine Publisher를 통한 반응형 비동기 처리
   - 7개 Repository 패턴 구현 (BaseRepository 기반)
   - JWT 토큰 자동 헤더 삽입 (Authorization)

4. **UI/UX**
   - SwiftUI 기반 선언형 UI (라이트 모드 전용)
   - Pretendard 폰트 적용
   - 역할별 커스텀 색상 팔레트 (Blue/Red/Green)
   - 재사용 가능한 커스텀 컴포넌트

5. **지도 및 위치**
   - Kakao Maps SDK 통합
   - LocationManager를 통한 현재 위치 조회 및 권한 관리
   - 경로 및 경유지 시각화
   - 물류 위치 지도 표시

**실행**
```bash
# Xcode에서 Cmd+R로 실행
# 또는 Product > Run
```

📖 자세한 내용: [Carru-iOS README](Carru-iOS/README.md)

---

### Backend 서버 실행 (참고)

Backend 서버는 Spring Boot 기반으로 구동됩니다. iOS 앱 개발 시 로컬 테스트를 위해 필요합니다.

```bash
cd Carru/Carru-Backend

# MySQL 데이터베이스 생성
mysql -u root -p
CREATE DATABASE carru_db;

# Gradle 빌드 및 실행
./gradlew bootRun

# 서버 확인: http://localhost:8080
# Swagger UI: http://localhost:8080/swagger-ui/index.html
```

📖 자세한 내용: [Carru-Backend README](Carru-Backend/README.md)

---

### AI 서버 실행 (참고)

AI 서버는 Flask 기반으로 XGBoost 모델을 서빙합니다.

```bash
cd Carru/Carru-AI-develop

# 의존성 설치 및 Flask 서버 실행
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py

# AI 서버 확인: http://localhost:5000
```

📖 자세한 내용: [Carru-AI README](Carru-AI-develop/README.md)

---

## 📈 프로젝트 성과

### 기술 구현 성과

**AI 경로 최적화 시스템**
- XGBoost 기반 3단계 경로 추천 모델 구현
- 메인 화물 + 경유지 2개를 통한 최대 3개 화물 동시 운송 가능
- AI 모델을 통한 지능형 매칭 알고리즘

**iOS 네이티브 앱**
- SwiftUI + MVVM + Repository Pattern (191개 Swift 파일)
- 3가지 역할 통합 지원 (기사/화주/관리자)
- Keychain을 활용한 보안 인증 시스템 (JWT)
- Moya + Combine 기반 반응형 네트워킹 (40+ API)
- 데이터 네트워킹 계층 추상화
- Kakao Maps SDK 통합 및 경로 시각화

**Backend API 서버**
- Spring Boot + JPA/QueryDSL 기반 REST API
- JWT 기반 인증 및 역할별 권한 관리 (기사/화주/관리자)
- MySQL 데이터베이스 설계 및 구현

**기대 효과**
- 기존 단일 화물 운송 대비 경유지 활용 시 수익 증대 가능
- 즉시 매칭을 통한 시간 절약 (기존 중개 프로세스 대비)
- AI 추천을 통한 공차 구간 최소화

---

## 🎯 향후 확장 가능성

### Phase 1: 기능 확장
- [ ] Android 앱 개발
- [ ] 웹 대시보드 (React)
- [ ] 실시간 채팅 기능
- [ ] 평가 및 리뷰 시스템

### Phase 2: AI 고도화
- [ ] Deep Learning 모델 도입 (LSTM, Transformer)
- [ ] 실시간 학습 (Online Learning)
- [ ] 교통 정보 통합 (실시간 도로 상황)
- [ ] 날씨 데이터 반영

### Phase 3: 플랫폼 확장
- [ ] 결제 시스템 통합
- [ ] 보험 연동
- [ ] 블록체인 기반 스마트 계약
- [ ] 글로벌 확장 (영문 지원)

### Phase 4: 비즈니스 모델
- [ ] 프리미엄 구독 서비스
- [ ] 기업 전용 대시보드
- [ ] API 외부 공개 (Carru API Marketplace)
- [ ] 파트너십 확대

---

## 👥 팀
<table>
<tr>
<td align="center" width="33%">
<b>iOS Developer</b><br/>
<a href="https://github.com/Yuhun-Lee">이주훈</a><br/>
<sub>SwiftUI, MVVM, Moya</sub>
</td>
<td align="center" width="33%">
<b>Backend Developer</b><br/>
Capstone Team<br/>
<sub>Spring Boot, JPA, MySQL</sub>
</td>
<td align="center" width="33%">
<b>AI/ML Engineer</b><br/>
Capstone Team<br/>
<sub>XGBoost, Flask, Python</sub>
</td>
</tr>
</table>

### 연락처

- **프로젝트 문의**: [Issues](https://github.com/Yuhun-Lee/Carru/issues)
- **버그 리포트**: [Bug Report](https://github.com/Yuhun-Lee/Carru/issues/new?template=bug_report.md)
- **기능 제안**: [Feature Request](https://github.com/Yuhun-Lee/Carru/issues/new?template=feature_request.md)

---

## 🔗 관련 링크

### 프로젝트 문서
- [Carru-iOS 상세 문서](Carru-iOS/README.md)
- [Carru-Backend 상세 문서](Carru-Backend/README.md)
- [Carru-AI 상세 문서](Carru-AI-develop/README.md)

### 외부 리소스
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [XGBoost Documentation](https://xgboost.readthedocs.io/)
- [Kakao Maps SDK](https://apis.map.kakao.com/)

---

## 📊 프로젝트 통계

![GitHub Stars](https://img.shields.io/github/stars/Yuhun-Lee/Carru?style=social)
![GitHub Forks](https://img.shields.io/github/forks/Yuhun-Lee/Carru?style=social)
![GitHub Issues](https://img.shields.io/github/issues/Yuhun-Lee/Carru)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/Yuhun-Lee/Carru)
![Last Commit](https://img.shields.io/github/last-commit/Yuhun-Lee/Carru)

---

<div align="center">


**Made with by Carru Team**

[⬆ Back to Top](#carru-ai-기반-화물-물류-매칭-플랫폼)

</div>
