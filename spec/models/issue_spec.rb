require 'spec_helper'

describe Issue do
  it "should succeed creating a new :business from the Factory" do
    _1_business
  end

  it "should succeed creating a new :task from the Factory" do
    _1_task
  end

  let :attrs_new do
    {}
  end
  let(:d_s_u) { _1_department_with_1_service_and_1_user }
  let(:business) { _1_business :user => d_s_u[2], :service => d_s_u[1] }
  let(:assigner) { _1_user :department => d_s_u[0] }
  let(:accepter) { _1_user :department => d_s_u[0] }
  let(:task) { _1_task :user => d_s_u[2], :service => d_s_u[1], :assigner => assigner,  :accepter => accepter }
  let :attrs_assigned do
    {
      :assigner       => assigner,
      :accepter       => accepter,
      :assign_remark  => 'remark'
    }
  end


  context "creations" do
    it "should require a body" do
      Business.new(attrs_new).should be_invalid
    end

    it "shoule reject a body that is too short" do
      Business.new(attrs_new.merge(:body => "body")).should be_invalid
    end

    it "should create expired_date field on create" do
      business.expired_date.should be_true
    end

    it "should business state is :pending on create" do
      business.state.should eq(:pending)
    end

    it "should task state is :assigned on create" do
      task.state.should eq(:assigned)
    end

    it "should create expired_date field on create" do
      business.expired_date.should be_true
    end

  end


  context "change state validations" do
    it "should reject change state on current time gt expired_date" do
      assign_at = business.expired_date + 1.minutes
      business.load attrs_assigned.merge(:assign_at => assign_at) rescue
          attrs_assigned.merge(:assign_at => assign_at).map {|k,v| business.update_attribute k,v}
      business.assigned!.should be_false
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

