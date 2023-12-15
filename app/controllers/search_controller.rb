class SearchController < ApplicationController
  def index
    @nation = params[:nation]
    response = get_url("characters?affiliation=#{@nation}")

    @total_members = response['length']
    @members = response['characters'].first(25)
    render 'search'
  end

  private

  def conn
    Faraday.new(url: 'https://last-airbender-api.com/api/v1/') do |faraday|
      faraday.headers[:Authorization] = "Bearer #{Rails.application.credentials.tmdb[:key]}"
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end