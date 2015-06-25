require 'rails_helper'

RSpec.describe Vote, type: :model do

  it { should belong_to :user }
  it { should belong_to :voteable }
  it { should validate_uniqueness_of(:like).scoped_to(:user_id, :voteable_id, :voteable_type) }

end
