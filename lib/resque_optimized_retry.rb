require "resque_optimized_retry/version"

module ResqueOptimizedRetry
  class Jobs
    def initialize options = {}
      @redis = Resque.redis
      @retried_count = 0
      @options = options
    end
    
    def retry_and_clear
      while can_retry?
        failed_job = redis.lpop("failed")
        break if failed_job.blank?
        job = JSON.parse failed_job
        Resque::Job.create job['queue'], job['payload']['class'], *job['payload']['args']
        @retried_count += 1
      end
      @retried_count
    end
    
    def retry
      while can_retry?
        failed_job = redis.lrange("failed", @retried_count, @retried_count + 1)
        break if failed_job.blank?
        job = JSON.parse failed_job[0]
        Resque::Job.create job['queue'], job['payload']['class'], *job['payload']['args']
        @retried_count += 1
      end
      @retried_count
    end
    
    def clear
      Resque::Failure.clear
    end
    
    private
    
    def redis
      @redis
    end
    
    def can_retry?
      not_crossed_the_limit? || has_failed_jobs?
    end
    
    def not_crossed_the_limit?
      !(@options[:limit].present? && @options[:limit].to_i >= @retried_count && has_failed_jobs?)
    end
    
    def has_failed_jobs?
      redis.llen("failed") > 0
    end
  end
end