class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @item = Item.find(params[:item_id]) #コメント対象の商品の番号を探す
    if @comment.save
      CommentChannel.broadcast_to @item, { comment: @comment, user: @comment.user } #追加
      # ActionCable.server.broadcast "comment_channel", {comment: @comment, user: @comment.user}
      # さらに変更:
      # 上記のままだとコメント対象の商品の情報を経由できない(@item の記述なし)
      # redirect_to item_path(params[:item_id]):チャネル設定したので上記に変更
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
