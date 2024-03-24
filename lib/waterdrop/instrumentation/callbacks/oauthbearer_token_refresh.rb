# frozen_string_literal: true

module WaterDrop
  module Instrumentation
    module Callbacks
      # Callback that is triggered when oauth token needs to be refreshed.
      class OauthbearerTokenRefresh
        # @param bearer [Rdkafka::Producer] given rdkafka instance. It is needed as
        #   we need to have a reference to call `#oauthbearer_set_token` or
        #   `#oauthbearer_set_token_failure` upon the event.
        # @param monitor [WaterDrop::Instrumentation::Monitor] monitor we are using
        def initialize(bearer, monitor)
          @bearer = bearer
          @monitor = monitor
        end

        # Upon receiving of this event, user is required to invoke either `#oauthbearer_set_token`
        # or `#oauthbearer_set_token_failure` on the `event[:bearer]` depending whether token
        # obtaining was successful or not.
        #
        # Please refer to WaterDrop and Karafka documentation or `Rdkafka::Helpers::OAuth`
        # documentation directly for exact parameters of those methods.
        #
        # @param _rd_config [Rdkafka::Config]
        # @param bearer_name [String] name of the bearer for which we refresh
        def call(_rd_config, bearer_name)
          return unless @bearer.name == bearer_name

          @monitor.instrument(
            'oauthbearer.token_refresh',
            bearer: @bearer,
            caller: self
          )
        end
      end
    end
  end
end
