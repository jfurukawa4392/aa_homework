
class ContactsController < ApplicationController

  def index
    # render json: Contact.all
    user = User.find(params[:user_id])
    contacts_shared = user.contacts_shared_with_this_user
    contacts = user.contacts

    render json: contacts_shared + contacts
  end

  def show
    contact = Contact.find(params[:id])

    render json: contact
  end

  def create
    contact = Contact.new(contact_params)

    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unproccessable_entity
      )
    end
  end

  def update
    contact = Contact.find(params[:id])

    if contact.update(contact_params)
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unproccessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])

    contact.destroy
    render json: contact
  end

  private
  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end
end
