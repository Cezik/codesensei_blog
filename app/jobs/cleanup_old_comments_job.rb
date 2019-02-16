class CleanupOldCommentsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    destroyed = Comment.where('created_at < ?', 2.weeks.ago).destroy_all
    logger.info "Deleted #{destroyed.size} comment created before #{2.weeks.ago}"
  end
end
