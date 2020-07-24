# frozen_string_literal: true

module Response
  def success_response(params = {})
    return unless params[:data] || params[:model]

    render json: serializer(params[:model]).constantize.new(data).serialize,
           status: status
  end

  def serializer(model)
    "Api::V1::#{model}Serializer"
  end

  def error_response
    render json: {}, status: :unprocessable_entity
  end
end
