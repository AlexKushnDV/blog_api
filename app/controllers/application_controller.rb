# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable

  def not_found
    render plain: 'Not found.', status: :not_found
  end
end
