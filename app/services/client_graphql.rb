# frozen_string_literal: true
require 'graphlient'

class ClientGraphql
  attr_reader :params, :endpoint, :data, :id

  def initialize(params)
    @id = params[:id]
    @endpoint = params[:endpoint]
    @data = params[:data]
  end

  def get_entries
    query = "query { fetch#{endpoint} { #{data} } }"
    response = call_api(query)

    response&.original_hash['data']["fetch#{endpoint}"]
  end

  def add
    query = "mutation {
      add#{endpoint}(input: {
        params: #{data}
      }) {
        #{endpoint.downcase} {
          #{data.scan(/\w+:/).join.split(':').join("\n")}
        }
      }
    }"

    call_api(query)
  end

  def remove
    query = "mutation {
      remove#{endpoint}(input: {
        id: #{id.to_i}
      }) {
        #{data}
      }
    }"

    response = call_api(query)

    response.original_hash['data']["fetch#{endpoint}"]
  end

  def update
    query = "mutation {
      update#{endpoint}(input: #{data}) {
        #{data.scan(/\w+:/).join.split(':').join("\n")}
      }
    }"

    call_api(query)
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

    return response if response

    rescue => e
      { 'success' => false, 'error_message' => e.message }
  end
end
