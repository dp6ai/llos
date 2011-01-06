class MessagesController < ApplicationController
  def index
    redirect_to :action => :brochure_request
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  def brochure_request
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def contact_us
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save

        #logger.debug("MSP about to send message")
        Notifier.deliver_contact(@message) # sends the email
        #logger.debug("MSP message sent")

        format.html { redirect_to(@message) }
      else
        format.html { render :action => "brochure_request" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def mailer
      @from = params[:from]
      Notifier.deliver_contact(params[:from], params[:message]) # sends the email
      render :action => "mailer"
  end

end
