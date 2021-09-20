# frozen_string_literal: true

module Authenticable
  def current_user
    return @current_user if @current_user

    pattern = /^Bearer /
    header  = request.authorization
    header.gsub!(pattern, '') if header&.match(pattern)
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    return nil if decoded.nil?

    @current_user = begin
      User.find(decoded[:user_id])
    rescue StandardError
      ActiveRecord::RecordNotFound
    end
  end

  protected

  def check_login
    head :unauthorized unless current_user
  end
end
