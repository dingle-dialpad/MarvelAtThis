
import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

extension DependencyValues {

    public var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}

extension APIClient: TestDependencyKey {

    public static let previewValue = APIClient(
        resolve: { _ in try await Task.never() },
        dispatch: { _ in try await Task.never() },
        setAuthentication: { _ in },
        setBaseURL: { _ in }
    )

    public static let testValue = APIClient(
        resolve: unimplemented("\(Self.self).resolve"),
        dispatch: unimplemented("\(Self.self).dispatch"),
        setAuthentication: unimplemented("\(Self.self).setAuthentication"),
        setBaseURL: unimplemented("\(Self.self).setBaseURL")
    )
}
