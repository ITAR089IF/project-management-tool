class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      respond_to :js
      ContactsMailer.contact_us_form(@contact).deliver_later
    else
      respond_to do |f|
        f.js { render :create_error }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end
end
