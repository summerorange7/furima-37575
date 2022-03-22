//画像をプレビューするための機能//


document.addEventListener('DOMContentLoaded', function(){
  //console.log("test") :（なぜここに挿入？）return nullのせいで動いてないのかそもそも読み込まれていないのか確認するためここに記述
  // 新規投稿・編集ページのフォームを取得
  const postForm = document.getElementById('new_post');
  // プレビューを表示するためのスペースを取得
  const previewList = document.getElementById('previews');
  
  // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!postForm) return null;


   // input要素を取得:「ファイルを選択」のボタンがあるところ
   const fileField = document.querySelector('input[type="file"][name="item[image]"]');
   
   // input要素で値の変化が起きた際に呼び出される関数
   fileField.addEventListener('change', function(e){

     // 古いプレビューが存在する場合は削除 :記述しないと前の画像そのまま残ってどんどん増える
    const alreadyPreview = document.querySelector('.preview'); //preview :プレビューとして表示されている画像についた親のclass名
    if (alreadyPreview) {
      alreadyPreview.remove();
    };

     const file = e.target.files[0]; //イベントが発火した部分（ターゲット）のファイルの添字0番の情報を変数fileに格納
    
     const blob = window.URL.createObjectURL(file);
    
     // 画像を表示するためのdiv要素を生成 : タグ<div></div>が生成
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview'); //previewという名前のclassを生成
    
    // 表示する画像を生成
    const previewImage = document.createElement('img'); //タグ<img>を生成
    previewImage.setAttribute('class', 'preview-image'); //preview-imageという名前のclassを生成
    previewImage.setAttribute('src', blob); //imgタグができたので、src属性を必ずつける=変数blobの情報
  
    // 生成したHTMLの要素をブラウザに表示させる
    previewWrapper.appendChild(previewImage); //<div></div>と<img> → <div><img></div>に変更(＝親：div 子：img)
    previewList.appendChild(previewWrapper); //変数previewList：先にビューファイルに入れておいた id = previewsのタグ
  });
});