module Spree
	class Spree::ContactController < Spree::StoreController
    before_filter :load_topics
    
    helper Spree::StoreHelper
    helper Spree::BaseHelper

    def show
      @message = Message.new
    end

    def create
      @message = Message.new(params[:message].permit(:name, :email, :topic_id, :message, :order_number)) unless spam?
      if @message.save
        ContactMailer.message_email(@message).deliver unless spam?
        flash[:notice] = t('contact_thank_you')
        redirect_to root_path
      else
        render :action => 'show'
      end
    end

	private
    def load_topics
      @topics = ContactTopic.all
    end
    
    def spam?
      params[:filter].present? || params[:filter].nil?
    end
	end	
end
