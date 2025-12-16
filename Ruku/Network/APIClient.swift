import Foundation

import Foundation

final class APIClient {

    static let shared = APIClient()
    private init() {}

    private let baseURL = "http://localhost:8000/api/v1"
//    private let baseURL = "https://ruku-backend-personal.onrender.com/api/v1"
 
    func request<T: Decodable>(
        _ endpoint: Endpoints,
        method: HTTPMethod,
        params: [String: String]? = nil,
        body: [String: Any]? = nil,
        response: T.Type
    ) async throws -> T {

        guard var components = URLComponents(
            string: baseURL + "/" + endpoint.rawValue
        ) else {
            throw URLError(.badURL)
        }

        // Params → URL
        if let params {
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Attach token if available
        if let token = TokenStorage.shared.get() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        // Body → JSON
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
        }

        // ======================
        // MARK: - LOG REQUEST
        // ======================
        print("\n──────────── API REQUEST ────────────")
        print("URL: \(request.url?.absoluteString ?? "N/A")")
        print("Method: \(request.httpMethod ?? "N/A")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let bodyData = request.httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8) {
            print("Body: \(bodyString)")
        } else {
            print("Body: None")
        }
        if let params {
            print("Query Params: \(params)")
        }
        print("─────────────────────────────────────\n")

        let (data, response) = try await URLSession.shared.data(for: request)

        // ======================
        // MARK: - LOG RESPONSE
        // ======================
        if let httpResponse = response as? HTTPURLResponse {
            print("\n──────────── API RESPONSE ────────────")
            print("URL: \(request.url?.absoluteString ?? "N/A")")
            print("Status Code: \(httpResponse.statusCode)")
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response Body: \(dataString)")
            } else {
                print("Response Body: cannot decode")
            }
            print("──────────────────────────────────────\n")
        }

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
