# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable

  def not_found
    head :not_found
  end
end
