class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
  end

  def new
    @item = Item.new #【学習備忘録】newビューファイルで空箱要る為 
  end

  private

  def item_params
    params.require(:item).permit(:description, :image).merge(user_id: current_user.id)
  end

end
