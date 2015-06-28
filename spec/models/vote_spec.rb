require 'rails_helper'

RSpec.describe Vote, type: :model do

  it { should belong_to :user }
  it { should belong_to :voteable }
  it { should validate_uniqueness_of(:user_id).scoped_to(:voteable_id, :voteable_type) }

end
