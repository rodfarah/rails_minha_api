require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }

    context 'when trying to change comment post_id after creation' do
      let(:user) { create(:user) }
      let(:post1) { create(:post, user: user) }
      let(:post2) { create(:post, user: user) }
      let(:comment) { create(:comment, post: post1, user: user) }

      it 'is not valid if post_id is changed' do
        comment.post = post2
        expect(comment).not_to be_valid
        expect(comment.errors[:base]).to include("A comment belongs to the original and specific post")
      end
    end
  end
end
