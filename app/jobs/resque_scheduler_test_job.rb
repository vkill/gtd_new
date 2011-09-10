class ResqueSchedulerTestJob
  @queue = :resque_scheduler

  def self.perform
    Rails.logger.info "hello"
  end
end

