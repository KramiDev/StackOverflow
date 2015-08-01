class Api::V1::ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!
  authorize_resource class: User

  respond_to :json, only: [:index, :me]

  def index
    respond_with(User.where.not(id: current_resource_owner.id))
  end

  def me
    respond_with(current_resource_owner)
  end

  protected

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_ability
    @current_ability ||= Ability.new(current_resource_owner)
  end
end
