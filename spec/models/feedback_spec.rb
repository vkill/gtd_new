require 'spec_helper'

describe Feedback do
  let(:department) { _1_department }
  let(:user) { _1_user :department => department }
  let(:service) { _1_service :department => department }
  let(:business) { _1_business :user => user, :service => service }
  let(:feedback) { _1_feedback :issue => business }
  let(:handler) { _1_user :department => department }
  let :attrs_new do
    {}
  end
  let :attrs_processing do
    {
      :handler       => handler
    }
  end
  let :attrs_processed do
    {
      :handler       => handler,
      :result       => 'result'
    }
  end

  context "aasm" do
    it "should state is :pending on created" do
      feedback.state.should eq(:pending)
    end

    it "should build handle_at when enter processing!" do
      subject.state = :pending
      subject.processing!
      subject.handle_at.should be_kind_of(ActiveSupport::TimeWithZone)
    end

    it "should build handle_at when enter processed!" do
      subject.state = :processing
      subject.processed!
      subject.handle_at.should be_kind_of(ActiveSupport::TimeWithZone)
    end

    describe 'transitions' do
      describe 'from_pending' do
        before { subject.state = :pending }
        it {
          lambda { subject.processing! }.should_not raise_error(AASM::InvalidTransition)
        }
      end
      describe 'from_processing' do
        before { subject.state = :processing }
        it {
          lambda { subject.processed! }.should_not raise_error(AASM::InvalidTransition)
        }
      end
      describe 'from_processed' do
        before { subject.state = :processed }
      end
    end
  end


  context "valid_attribute" do
    it { should_not have_valid(:issue).when(nil) }
    it { should have_valid(:issue).when(issue) }
    it { should_not have_valid(:body).when(nil)  }
    it { should_not have_valid(:body).when('s'*9) }
    it { should have_valid(:body).when('s'*10) }
    describe 'processing?' do
      before { subject.state = :processing }
      it { should_not have_valid(:handler).when(nil) }
      it { should have_valid(:handler).when(handler) }
    end
    describe 'processed?' do
      before { subject.state = :processing }
      it { should_not have_valid(:handler).when(nil) }
      it { should have_valid(:handler).when(handler) }
      it { should_not have_valid(:result).when(nil)  }
      it { should_not have_valid(:result).when('s'*9) }
      it { should have_valid(:result).when('s'*10) }
    end
  end
end


# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer         not null, primary key
#  category   :string(255)     default("bad")
#  body       :text
#  state      :string(255)     default("pending")
#  result     :text
#  handler_id :integer
#  handle_at  :datetime
#  issue_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

