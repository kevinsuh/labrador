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
      suite: address_params[:suite],
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

    # 1) find recipient
    recipient = Recipient.find(params[:id])

    # 2) update first name, last name, relationship to you
    recipient.update_columns(
      first_name: params[:first_name],
      last_name: params[:last_name],
      relationship_id: params[:relationship][:id]
    )

    # 3) save recipient address if exists
    if params[:primary_address]
      address_params = params[:primary_address]

      # update vs create
      if id = address_params[:id]
        address = Address.find(address_params[:id])
        address.update_columns(
          first_name: address_params[:first_name],
          last_name: address_params[:last_name],
          street: address_params[:street],
          suite: address_params[:suite],
          city: address_params[:city],
          state: address_params[:state],
          zipcode: address_params[:zipcode],
          country: address_params[:country]
        )
      else
        address = recipient.addresses.new(
          first_name: address_params[:first_name],
          last_name: address_params[:last_name],
          street: address_params[:street],
          suite: address_params[:suite],
          city: address_params[:city],
          state: address_params[:state],
          zipcode: address_params[:zipcode],
          country: address_params[:country]
        )
        if address.save
          # since recipient is created, you know this is first address
          address.set_primary
        end
      end
    end

    # 4) save recipient occasions
    occasions = params[:occasions]
    if occasions
      occasions.each do |occasion|
        recipient_occasion = occasion[:recipient_occasion]
        occasion_id        = recipient_occasion[:occasion_id]
        occasion_date      = recipient_occasion[:occasion_date]

        # update existing vs create new
        if id = recipient_occasion[:id]
          update_recipient_occasion = RecipientOccasion.find(id)
          update_recipient_occasion.update_columns(
            occasion_id: occasion_id,
            occasion_date: occasion_date
          )
        else
          recipient.recipient_occasions.create(
            occasion_id: occasion_id,
            occasion_date: occasion_date
          )
        end

      end
    end

    respond_to do |format|
      format.json { render json: recipient }
    end
  end

end
