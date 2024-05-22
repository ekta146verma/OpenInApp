import Foundation

class NetworkManager: ObservableObject {
    @Published var responseData: ApiResponse?
    
    func fetchData() {
        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self.responseData = decodedResponse
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
