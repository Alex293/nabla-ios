import NablaCore
import NablaMessagingCore
import NablaMessagingUI
import UIKit

class ViewController: DemoViewController {
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = "dummy_user_id" // In a real scenario, you need to replace it with your own stable user id.
        NablaClient.shared.authenticate(userId: userId, provider: FakeAuthenticator.shared)
        let view = NablaClient.shared.messaging.views.createConversationListView(delegate: self)
        setContentView(view)
    }
    
    // MARK: Handlers
    
    override func createConversationButtonHandler() {
        let conversation = NablaMessagingClient.shared.startConversation()
        let destination = NablaClient.shared.messaging.views.createConversationViewController(conversation)
        navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: - Private
    
    private var createConversationAction: Any?
}

extension ViewController: ConversationListDelegate {
    func conversationList(didSelect conversation: Conversation) {
        let destination = NablaClient.shared.messaging.views.createConversationViewController(conversation)
        navigationController?.pushViewController(destination, animated: true)
    }
}
