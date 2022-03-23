import consumer from "./consumer"

if(location.pathname.match(/\/items\/\d/)){

  //対象の商品のみにコメントを表示できるよう変更
  consumer.subscriptions.create({
    channel: "CommentChannel",
    item_id: location.pathname.match(/\d+/)[0]
  }, {
  //変更前: consumer.subscriptions.create("CommentChannel", {
  
  connected() {
    // Called when the subscription is ready for use on the server
    },

  disconnected() {
    // Called when the subscription has been terminated by the server
    },

  received(data) {
      const html = `
        <div class="comment">
          <p class="user-info">${data.user.nickname}： </p>
          <p>${data.comment.comment}</p>
        </div>`
      const comments = document.getElementById("comments")
      comments.insertAdjacentHTML('beforeend', html)
      const commentForm = document.getElementById("comment-form")
      //comment_comment:不適 textereaしか指定できないタグ
      //reset関数 ：動作の対象 = フォーム全体（formタグに直に書かれているid要素を指定）
      // →コメントする枠だけでなく、「コメントする」ボタンや注意書きの部分もかぶるが問題なし
      commentForm.reset();
    }
  })
}
