class HomeController < ApplicationController
  layout 'landing'

  before_action :get_event

  def index
    if !@event
      render 'not_found' and return
    end

    completed_users = @event.participations.map { |p| p.user.id }

    @users = User.where.not(id: completed_users).order(:name)
  end

  def confirmation
    @user = User.find(params[:user_id])
  end

  def confirm
    #remove as participações não preenchidas
    params = event_params

    params[:participations_attributes].each do |i, att|
      if att[:name].empty?
        params[:participations_attributes].delete i
      end
    end

    #adiciona os ítems obrigatórios
    @event.event_items.where(:required_per_person => 1).each do |item|
      params[:participations_attributes].each do |i, att|
        att[:event_item_ids] << item.id.to_s
      end
    end

    @event.update(params)

    redirect_to root_path , notice: 'Confirmação concluída. Obrigado'
  end

  def payment_summary

  end

  def get_event
    @event = Event.where("date >= now()").first
  end

  private
    def event_params
      params.required(:event).permit(:id, participations_attributes: [:user_id, :event_id, :name, :kind, event_item_ids: []])
    end
end
