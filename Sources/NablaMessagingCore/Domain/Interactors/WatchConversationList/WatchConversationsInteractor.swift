import Foundation

protocol WatchConversationsInteractor {
    func execute(handler: ResultHandler<ConversationList, NablaWatchConversationsError>) -> PaginatedWatcher
}