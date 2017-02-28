class ContactsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :completed]
  before_action :check_if_admin, only: [:index, :completed]
   before_action :set_contact, only: [:completed]

  def index
    @contacts = Contact.pending
    render layout: 'admin'
  end

  def new
    @contact = Contact.new(language: I18n.locale)
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to root_path, notice: I18n.t('contact.sent') }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def completed
    @contact.update_attribute(:done, true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :object, :question, :done, :language)

    end
end
