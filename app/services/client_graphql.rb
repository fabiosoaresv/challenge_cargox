# frozen_string_literal: true
require 'graphlient'

class ClientGraphql
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    call_api(params)
  end

  private

  def call_api(params)
   client = Graphlient::Client.new(
      'http://localhost:3000/graphql',
      http_options: {
        read_timeout: 20,
        write_timeout: 30
      }
    )

    response = client.query <<~GRAPHQL
      #{params}
    GRAPHQL
  end
end
