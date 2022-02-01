# frozen_string_literal: true

require 'date'

class MetricsController < ApplicationController

  # /metrics returns basic telemetry data on Conjur's usage
  #
  # This is intended to be the scrape target for Prometheus telemetry.
  def index
    audit_success

    render(json: {
      client_ip: request.ip,
      user_agent: request.user_agent,
      custom_metric: "Here is my metric"
    })
  end

  def audit_success
    Audit.logger.log(
      Audit::Event::Metrics.new(
        client_ip: request.ip,
        success: true
      )
    )
  end
end
