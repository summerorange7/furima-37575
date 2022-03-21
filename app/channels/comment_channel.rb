class CommentChannel < ApplicationCable::Channel
  def subscribed
    #コメント商品の詳細ページに対してのみ表示できるよう変更
    @item = Item.find(params[:item_id]) # 追記
    stream_for @item # 追記
    # stream_from "comment_channel":このままだとコメントした商品でない商品情報にコメントが出てしまう
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
