class ExpiredIssueWorker
  @queue = :resque_scheduler

  def self.perform
    Issue.expired!
  end
end

