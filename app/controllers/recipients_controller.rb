class RecipientsController < ApplicationController
  	
  # get all of current_user's recipients
  def get_current_recipients
    recipients = current_user.recipients.live # only get the live recipients!
    respond_to do |format|
      format.json { render json: recipients }
    end
  end

  # create new recipient for current user
  def create_for_current

    # 1) create new recipient
    first_name = params[:first_name]
    last_name = params[:last_name]
    recipient = current_user.recipients.create(
      first_name: first_name,
      last_name: last_name
      )

    # 2) save recipient addresses
    addresses = params[:addresses]
    if addresses
      primary_set = false
      addresses.each do |address|
        address = recipient.addresses.new(
          first_name: first_name,
          last_name: last_name,
          street: address[:street],
          city: address[:city],
          suite: address[:suite],
          state: address[:state],
          zipcode: address[:zipcode],
          )
        if address.save
          unless primary_set
            address.set_primary
            primary_set = true
          end
        end
      end
    end
    

    # 3) save recipient occasions
    occasions = params[:occasions]

    if occasions
      occasions.each do |occasion|

        occasion_id = occasion[:recipient_occasion][:occasion_id]
        day         = occasion[:recipient_occasion][:day]
        month       = occasion[:recipient_occasion][:month]
        notes       = occasion[:recipient_occasion][:notes]
        recipient.recipient_occasions.create(
          occasion_id: occasion_id,
          day: day,
          month: month,
          notes: notes
        )
      end
    end

    respond_to do |format|
      format.json { render json: recipient }
    end

  end

  def upload_recipient_picture
    
    update_recipient_id = params[:update_recipient_id]
    if update_recipient_id && Integer(update_recipient_id) > 0
      recipient = Recipient.find(update_recipient_id)
      recipient.profile_pictures.delete_all
      recipient.profile_pictures.create(picture: params[:file])
    end

    respond_to do |format|
      format.json { render json: recipient }
    end
  end

  # update recipient for current user
  def update_for_current

    # 1) find recipient
    recipient = Recipient.find(params[:id])

    # 2) update first / last name
    first_name = params[:first_name]
    last_name = params[:last_name]
    recipient.update_columns(
      first_name: params[:first_name],
      last_name: params[:last_name]
    )

    puts params.inspect

    # 3) update recipient addresses
    addresses = params[:addresses]
    if addresses

      # delete all addresses then insert
      recipient.addresses.delete_all

      primary_set = false
      addresses.each do |address|
        address = recipient.addresses.new(
          first_name: first_name,
          last_name: last_name,
          street: address[:street],
          city: address[:city],
          suite: address[:suite],
          state: address[:state],
          zipcode: address[:zipcode],
          )
        if address.save
          unless primary_set
            address.set_primary
            primary_set = true
          end
        end
      end
    end

    # 4) save recipient occasions
    # our update will be to delete all occasions then create new ones
    occasions = params[:occasions]

    if occasions

      recipient.occasions.delete_all
      occasions.each do |occasion|

        occasion_id = occasion[:recipient_occasion][:occasion_id]
        day         = occasion[:recipient_occasion][:day]
        month       = occasion[:recipient_occasion][:month]
        notes       = occasion[:recipient_occasion][:notes]

        recipient.recipient_occasions.create(
          occasion_id: occasion_id,
          day: day,
          month: month,
          notes: notes
        )
      end
    end

    respond_to do |format|
      format.json { render json: recipient }
    end
  end

  def delete_for_current
    recipient = Recipient.find(params[:id])
    recipient.deleted!
    respond_to do |format|
      format.json { render json: recipient }
    end
  end

  # delete recipients that based on array of recipient_ids
  def delete_selected_recipients
    recipient_ids = params[:recipient_ids]
    recipients = Recipient.where("id IN (:recipient_ids)", recipient_ids: recipient_ids)
    recipients.each do |recipient|
      recipient.deleted!
    end
    respond_to do |format|
      format.json { render json: recipients }
    end
  end

  # get recipients from array of recipient IDS
  # ONLY if the recipients belong to current_user!
  def get_recipients

    recipient_ids = params[:recipient_ids]

    recipients = current_user.recipients.where("recipients.id IN (:recipient_ids)", recipient_ids: recipient_ids)
    respond_to do |format|
      format.json { render json: recipients }
    end

  end

end
