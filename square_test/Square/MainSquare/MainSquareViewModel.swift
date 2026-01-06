//
//  MainSquareViewModel.swift
//  square_test
//
//  Created by Ihar Tsimafeyeu on 5.01.26.
//

final class MainSquareViewModel: UIFeatureViewModel<MainSquareFeature> {
    
    struct Dependencies {
        let networkService: MainSquareNetworkServiceProtocol
    }
    
    private let router: MainSquareRouterProtocol
    private let inputData: MainSquareInputData
    private let dependencies: MainSquareViewModel.Dependencies
    
    init(
        state: MainSquareFeature.State,
        router: MainSquareRouterProtocol,
        inputData: MainSquareInputData,
        dependencies: MainSquareViewModel.Dependencies
    ) {
        self.router = router
        self.inputData = inputData
        self.dependencies = dependencies
        super.init(initialState: state)
    }
    
    override func handle(action: MainSquareFeature.Action) {
        switch action {
            
        case .fetchData:
            fetchData()
        }
    }
    
    private func fetchData() {
        Task { try await getRepos() }
    }
    
    private func getRepos() async throws {
        postEffect(.loading(true))
        defer { postEffect(.loading(false)) }
        
        do {
            let result = try await dependencies.networkService.getRepos()
            await handleResponse(result)
        } catch let networkError {
            postEffect(.error(networkError))
        }
    }
    
    @MainActor
    private func handleResponse(_ repos: [RepositoryModel.Response]) {
        state.items = repos.map {
            MainSquareRepoViewItem(
                id: $0.id,
                title: $0.name,
                subtitle: $0.description ?? "No description"
            )
        }
    }
}
