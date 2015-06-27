class ConversationMapping < ActiveRecord::Base
  attr_accessible :conversation_id, :person1, :person2
end
