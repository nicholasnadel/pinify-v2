class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  
  def upvote
    @pin.upvote_by current_user
    redirect_back(fallback_location: root_path)
  end


  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build
    if @pin.save
      redirect_to @pin, notice: "Successfully saved!"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Updated!"
    else 
      render 'edit'
    end
  end

  def destroy
      if @pin.destroy
        redirect_to root_path
      else
      end  
  end






  private

  def pin_params
    params.require(:pin).permit(:title, :description, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

  def require_permission
  if current_user != Pin.find(params[:id]).user
    redirect_to root_path
    #Or do something else here
  end
end


end
