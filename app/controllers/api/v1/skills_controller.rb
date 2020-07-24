# frozen_string_literal: true

module Api
  module V1
    class SkillsController < ApplicationController
      def index
        success_response(SkillsIndex.new(index_params).execute)
      end

      private

      def index_params
        { skill_name: params[:alexa_skill_name], query: params[:query] }
      end
    end
  end
end
