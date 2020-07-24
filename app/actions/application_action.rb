# frozen_string_literal: true

class ApplicationAction
  def initialize(params = {})
    @skill_name = params[:skill_name] || ''
    @product_name = params[:query] || ''
  end
end
