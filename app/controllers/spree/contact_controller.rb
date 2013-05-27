module Spree
	class ContactController < BaseController
    before_filter :load_topics

    def show
      @message = Message.new
    end

    def create
      @message = Message.new(params[:message] || {}) unless spam?
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
      params[:message][:filter].present? || params[:message][:filter].nil?
	end	
end