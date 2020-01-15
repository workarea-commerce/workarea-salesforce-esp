module Workarea
  module SalesforceEsp
    class SaveEmailSignup
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: { Workarea::Email::Signup => :create },
        queue: 'low'
      )

      def perform(id)
        signup = Workarea::Email::Signup.find(id)
        add_subscription(signup.email, {}, list_id)
      end

      private

      def add_subscription(email, attrs = {}, list_ids = nil)
        Workarea::SalesforceEsp.gateway.subscribe(email, attrs, list_ids)
      end

      def list_id
        Workarea::config.salesforce[:default_list]
      end
    end
  end
end
