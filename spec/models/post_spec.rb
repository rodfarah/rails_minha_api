require 'rails_helper'

RSpec.describe Post, type: :model do
  # testing validations
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    context 'when post is published, draft is false' do
      subject { build(:post, draft: false, body: nil) }
      it 'is invalid without body' do
        expect(subject).not_to be_valid
        expect(subject.errors[:body]).to include("can't be blank")
      end
    end
    context 'when post is draft, draft is true' do
      subject { build(:post, draft: true, body: nil) }
      it 'is valid without body' do
        expect(subject).to be_valid
      end
    end
  end
end
