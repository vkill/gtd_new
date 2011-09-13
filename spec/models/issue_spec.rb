require 'spec_helper'

describe Issue do

  let(:department) { _1_department }
  let(:user) { _1_user :department => department }
  let(:service) { _1_service :department => department }
  let(:business) { _1_business :user => user, :service => service }
  let(:assigner) { _1_user :department => department }
  let(:accepter) { _1_user :department => department }
  let(:task) { _1_task :user => user, :service => service, :assigner => assigner,  :accepter => accepter }
  let :attrs_new do
    {}
  end
  let :attrs_assigned do
    {
      :assigner       => assigner,
      :accepter       => accepter,
      :assign_remark  => 'remark'
    }
  end
  let :attrs_accepted do
    {
      :solution       => 'solution'
    }
  end
  let :attrs_finished do
    {
      :result         => 'result'
    }
  end


  context "aasm" do
    it "should state is :pending on created a business" do
      business.state.should eq(:pending)
    end

    it "should state is :assigned on created a task" do
      task.state.should eq(:assigned)
    end

    it "should build expired_date when enter pending!" do
      old_expired_date = business.expired_date
      Timecop.freeze(business.expired_date + 1.hours) do
        business.expired!
        business.pending!
        business.expired_date.should_not eq(old_expired_date)
      end
    end

    it "should build assign_at when enter assigned!" do
      subject.state = :pending
      subject.assigned!
      subject.assign_at.should be_kind_of(ActiveSupport::TimeWithZone)
    end

    it "should build accept_at when enter accepted!" do
      subject.state = :assigned
      subject.accepted!
      subject.accept_at.should be_kind_of(ActiveSupport::TimeWithZone)
    end

    it "should build finish_at when enter finished!" do
      subject.state = :accepted
      subject.finished!
      subject.finish_at.should be_kind_of(ActiveSupport::TimeWithZone)
    end

    it "should build state_before_expired when enter expired!" do
      subject.state = :pending
      subject.expired!
      subject.state_before_expired.should eq(:pending)
    end

    describe 'transitions' do
      describe 'from_pending' do
        before { subject.state = :pending }
        it {
          lambda { subject.assigned! }.should_not raise_error(AASM::InvalidTransition)
          lambda { subject.expired! }.should_not raise_error(AASM::InvalidTransition)
        }
      end

      describe 'from_assigned' do
        before { subject.state = :assigned }
        it {
          lambda { subject.accepted! }.should_not raise_error(AASM::InvalidTransition)
          lambda { subject.expired! }.should_not raise_error(AASM::InvalidTransition)
        }
      end

      describe 'from_accepted' do
        before { subject.state = :accepted }
        it {
          lambda { subject.finished! }.should_not raise_error(AASM::InvalidTransition)
          lambda { subject.expired! }.should_not raise_error(AASM::InvalidTransition)
        }
      end

      describe 'from_finished' do
        before { subject.state = :finished }
      end

      describe 'from_expired' do
        before { subject.state = :expired }
        it {
          lambda { subject.pending! }.should_not raise_error(AASM::InvalidTransition)
        }
      end
    end
  end

  context "valid_attribute" do
    before { subject.expired_date = Time.zone.now + 1.hours }
    it { should_not have_valid(:user).when(nil) }
    it { should have_valid(:user).when(user) }
    it { should_not have_valid(:service).when(nil) }
    it { should have_valid(:service).when(service) }
    it { should_not have_valid(:body).when(nil)  }
    it { should_not have_valid(:body).when('s'*9) }
    it { should have_valid(:body).when('s'*10) }
    describe 'assigned?' do
      before { subject.state = :assigned }
      it { should_not have_valid(:assigner).when(nil) }
      it { should have_valid(:assigner).when(assigner) }
      it { should_not have_valid(:accepter).when(nil) }
      it { should have_valid(:accepter).when(accepter) }
      describe 'business' do
        before { subject.type = 'Business' }
        it { should_not have_valid(:assign_at).when(Time.zone.now + 2.hours) }
        it { should have_valid(:assign_at).when(Time.zone.now) }
      end
    end
    describe 'accepted?' do
      before { subject.state = :accepted }
      it { should_not have_valid(:solution).when(nil) }
      it { should have_valid(:solution).when('s') }
      it { should_not have_valid(:accept_at).when(Time.zone.now + 2.hours) }
      it { should have_valid(:accept_at).when(Time.zone.now) }
    end
    describe 'finished?' do
      before { subject.state = :finished }
      it { should_not have_valid(:result).when(nil) }
      it { should have_valid(:result).when('s') }
      it { should_not have_valid(:finish_at).when(Time.zone.now + 2.hours) }
      it { should have_valid(:finish_at).when(Time.zone.now) }
    end
    describe 'expired?' do
      before { subject.state = :expired }
      it { should_not have_valid(:expired_date) }
      it {
        Timecop.freeze(Time.zone.now + 2.hours) do
          should have_valid(:expired_date)
        end
      }
    end
  end

  context "callbacks" do
    before {
      subject.type = 'Task'
      subject.service = service
      subject.state = :assigned
      subject.save! :validate => false
    }
    describe 'before create' do
      it "should build user" do
        subject.expired_date.should be_true
      end
    end
    describe 'after create' do
      it "should build expired_date" do
        subject.expired_date.to_s.should eq((subject.created_at + subject.expired_date_hours.hours).to_s)
      end

      it "should build assign_at if assigned?" do
        subject.assign_at.to_s.should eq(subject.created_at.to_s)
      end
    end

  end


  context "creations" do
    it "should business workflow succeed" do
      attrs_assigned.map {|k,v| business.update_attribute k,v}
      business.assigned!.should be_true

      attrs_accepted.map {|k,v| business.update_attribute k,v}
      business.accepted!.should be_true

      attrs_finished.map {|k,v| business.update_attribute k,v}
      business.finished!.should be_true
    end

    it "should task workflow succeed" do
      attrs_accepted.map {|k,v| task.update_attribute k,v}
      task.accepted!.should be_true

      attrs_finished.map {|k,v| task.update_attribute k,v}
      task.finished!.should be_true
    end
  end
end


# == Schema Information
#
# Table name: issues
#
#  id            :integer         not null, primary key
#  body          :text
#  state         :string(255)     default("pending")
#  assigner_id   :integer
#  accepter_id   :integer
#  assign_remark :text
#  assign_at     :datetime
#  solution      :text
#  accept_at     :datetime
#  result        :text
#  finish_at     :datetime
#  user_id       :integer
#  service_id    :integer
#  type          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  expired_date  :datetime
#  name          :string(255)
#  start_at      :datetime
#  end_at        :datetime
#

