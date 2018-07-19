module Sidekiq
  module CustomQueue
    class ClientMiddleware
      def call(worker_class, msg, _queue, _redis_pool)
        worker = worker_class.constantize
        worker = msg['wrapped'].constantize if msg['wrapped'].present?
        if worker.respond_to?(:custom_queue)
          msg['queue'] = worker.custom_queue(msg).to_s
        end
        yield
      end
    end
  end
end
