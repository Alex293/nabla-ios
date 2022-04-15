import Foundation

struct URLRequestMapper {
    private let baseUrl: URL

    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    func map(httpRequest: HTTPRequest) -> URLRequest? {
        let endpointUrl = baseUrl.appendingPathComponent(httpRequest.endPoint)
        guard var urlComponents = URLComponents(url: endpointUrl, resolvingAgainstBaseURL: false) else { return nil }

        var request: URLRequest
        switch httpRequest.method.parametersEncoding {
        case .queryString:
            urlComponents.queryItems = httpRequest.parameters.compactMap {
                guard let value = $0.value as? String else { return nil }
                return URLQueryItem(name: $0.key, value: value)
            }

            guard let url = urlComponents.url else { return nil }

            request = URLRequest(url: url)
        case .httpBody:
            guard let url = urlComponents.url else { return nil }

            request = URLRequest(url: url)
            request.httpBody = try? JSONSerialization.data(withJSONObject: httpRequest.parameters)
        }

        request.httpMethod = httpRequest.method.rawValue

        var headers = [
            HTTPHeaders.Accept: "application/json",
        ].merging(HTTPHeaders.extra, uniquingKeysWith: { lhs, _ in lhs })

        for (key, value) in httpRequest.headers {
            headers.updateValue(value, forKey: key)
        }

        headers.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }

        return request
    }
}

private extension HTTPRequest.Method {
    var parametersEncoding: HTTPRequest.ParametersEncoding {
        switch self {
        case .get, .delete:
            return .queryString
        case .post, .put:
            return .httpBody
        }
    }
}
