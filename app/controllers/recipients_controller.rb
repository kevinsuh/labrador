class RecipientsController < ApplicationController
  	
  # get all of current_user's recipients
  def get_current_recipients
    recipients = current_user.recipients
    respond_to do |format|
      format.json { render json: recipients }
    end
  end

  # create new recipient for current user
  def create_for_current
    puts "hello"
    puts params.inspect

    # 1) create new recipient
    recipient = current_user.recipients.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      relationship_id: params[:relationship][:id]
      )

    # 2) save recipient address
    address_params = params[:primary_address]
    address = recipient.addresses.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      street: address_params[:street],
      city: address_params[:city],
      state: address_params[:state],
      zipcode: address_params[:zipcode],
      country: address_params[:country]
    )

    if address.save
      # since recipient is created, you know this is first address
      address.set_primary
    end

    # 3) save recipient occasions
    occasions = params[:occasions]

    if occasions
      occasions.each do |occasion|
        recipient_occasion = occasion[:recipient_occasion]
        occasion_id        = recipient_occasion[:occasion_id]
        occasion_date      = recipient_occasion[:occasion_date]

        recipient.recipient_occasions.create(
          occasion_id: occasion_id,
          occasion_date: occasion_date
        )
      end
    end

    respond_to do |format|
      format.json { render json: recipient }
    end

  end

  # update recipient for current user
  def update_for_current
    puts params.inspect
  end

end
