//画像をプレビューするための機能//

document.addEventListener('DOMContentLoaded', function(){
  //console.log("test") :（なぜここに挿入？）return nullのせいで動いてないのかそもそも読み込まれていないのか確認するためここに記述
  // 新規投稿・編集ページのフォームを取得
  const postForm = document.getElementById('new_post');
  // プレビューを表示するためのスペースを取得
  const previewList = document.getElementById('previews');
  
  // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
  if (!postForm) return null;

   // 投稿できる枚数の制限を定義 （フロントサイドでの制限）
   const imageLimits = 5;

  // プレビュー画像を生成・表示する関数
  const buildPreviewImage = (dataIndex, blob) =>{
  
    // 画像を表示するためのdiv要素を生成
    const previewWrapper = document.createElement('div'); //タグ<div></div>が生成
    previewWrapper.setAttribute('class', 'preview'); //previewという名前のclassを生成
    previewWrapper.setAttribute('data-index', dataIndex); //data-indexの中に変数dataIndexの値を格納 :何番目の画像を出すか指定する必要があるため
    
    // 表示する画像を生成
    const previewImage = document.createElement('img'); //タグ<img>を生成
    previewImage.setAttribute('class', 'preview-image'); //preview-imageという名前のclassを生成
    previewImage.setAttribute('src', blob); //imgタグができたので、src属性を必ずつける=変数blobの情報
  
    // 削除ボタンを生成
    const deleteButton = document.createElement("div");
    deleteButton.setAttribute("class", "image-delete-button");
    deleteButton.innerText = "削除";

    // 削除ボタンをクリックしたらプレビューとfile_fieldを削除させる
    deleteButton.addEventListener("click", () => deleteImage(dataIndex));

    // 生成したHTMLの要素をブラウザに表示させる
    previewWrapper.appendChild(previewImage); //<div></div>と<img> → <div><img></div>に変更(＝親：div 子：img)
    previewWrapper.appendChild(deleteButton); //生成した削除ボタンを変数previewWrapperの子要素として入れ込む
    previewList.appendChild(previewWrapper); //変数previewList：先にビューファイルに入れておいた id = previewsのタグ
  };

    // file_fieldを生成・表示する関数
    const buildNewFileField = () => {

      // 2枚目用のfile_field（「ファイルを選択」ボタン）を作成
      const newFileField = document.createElement('input'); //input属性を作る
      newFileField.setAttribute('type', 'file'); //type属性をfileで指定する
      newFileField.setAttribute('name', 'item_tag_form[images][]'); //name属性をitem[images][]で指定する
      
      // 最後のfile_fieldを取得
      const lastFileField = document.querySelector('input[type="file"][name="item_tag_form[images][]"]:last-child');
      // nextDataIndex = 最後のfile_fieldのdata-index + 1
      const nextDataIndex = Number(lastFileField.getAttribute('data-index')) +1; //最後の番号に１を足して、次の番号を作っている
      newFileField.setAttribute('data-index', nextDataIndex); //上の記述で出来た番号をdata-indexに格納して設置

      // 追加されたfile_fieldにchangeイベントをセット　:これをセットすると３枚目以降の「ファイルを選択」のボタンは複数表示されるようになる
      newFileField.addEventListener("change", changedFileField); //変数newFileFieldの値に変化が起きたら関数changedFileFieldを動かす

      // 生成したfile_fieldを表示
      const fileFieldsArea = document.querySelector('.click-upload'); //click-upload :「ファイルを選択」ボタン・「クリックして...」を全て含めた部分
      fileFieldsArea.appendChild(newFileField); //click-uploadクラスに子要素としてnewFileFieldを入れる
    };

      // 指定したdata-indexを持つプレビューとfile_fieldを削除する
      const deleteImage = (dataIndex) => {
        const deletePreviewImage = document.querySelector(`.preview[data-index="${dataIndex}"]`);
        deletePreviewImage.remove();
        const deleteFileField = document.querySelector(`input[type="file"][data-index="${dataIndex}"]`);
        deleteFileField.remove();
      
      // 画像の枚数が最大のときに削除ボタンを押した場合、file_fieldを1つ追加する
      const imageCount = document.querySelectorAll(".preview").length;
      if (imageCount == imageLimits - 1) buildNewFileField();
      
      };

    // input要素で値の変化が起きた際に呼び出される関数の中身
    const changedFileField = (e) => {

        // data-index（何番目を操作しているか）を取得
      const dataIndex = e.target.getAttribute('data-index');
      
      //一旦コメントアウト :入ったままだと1枚の画像ですら差し替え表示になる
      // 古いプレビューが存在する場合は削除 :記述しないと前の画像そのまま残ってどんどん増える
      // const alreadyPreview = document.querySelector('.preview'); //preview :プレビューとして表示されている画像についた親のclass名
      // if (alreadyPreview) {
      //   alreadyPreview.remove();
      // };
      // ↓L.74〜対象の画像のみ差し替えられるような記述に変更

      const file = e.target.files[0]; //イベントが発火した部分（ターゲット）のファイルの添字0番の情報を変数fileに格納
      
       // fileが空 = 何も選択しなかったのでプレビュー等を削除して終了する
        if (!file) {
          deleteImage(dataIndex);
          return null;
        };

      const blob = window.URL.createObjectURL(file); //変数blobに、変数fileに入った画像のURLを作って格納

       // data-indexを使用して、既にプレビューが表示されているかを確認する
      const alreadyPreview = document.querySelector(`.preview[data-index="${dataIndex}"]`);

      if (alreadyPreview) {
        // クリックしたfile_fieldのdata-indexと、同じ番号のプレビュー画像が既に表示されている場合は、画像の差し替えのみを行う
        const alreadyPreviewImage = alreadyPreview.querySelector("img");
        alreadyPreviewImage.setAttribute("src", blob);
        return null;
      };

      buildPreviewImage(dataIndex, blob);

      //buildNewFileField(); 投稿できる画像の制限をつけたため、コメントアウト
      //以下に変更
       // 画像の枚数制限に引っかからなければ、新しいfile_fieldを追加する
      const imageCount = document.querySelectorAll(".preview").length; //previewクラス :個々の画像を指している、previewsクラスだと画像の「かたまりで１つ」のカウントになるので不適
      if (imageCount < imageLimits) buildNewFileField();
    
  };

    // input要素を取得:「ファイルを選択」のボタンがあるところ
   const fileField = document.querySelector('input[type="file"][name="item_tag_form[images][]"]'); //[images][] :複数枚の画像が配列形式で渡されるのでこの記述
   //１枚だけ投稿の記述：const fileField = document.querySelector('input[type="file"][name="item[image]"]');

   // input要素で値の変化が起きた際に呼び出される関数
   fileField.addEventListener('change', changedFileField);
});


//【学習備忘録】以下、コード整理前（ここまで：２枚目以降の画像を選択できるところまで実装済み、２枚目の画像表示・変更・削除はできない）

// document.addEventListener('DOMContentLoaded', function(){
//   //console.log("test") :（なぜここに挿入？）return nullのせいで動いてないのかそもそも読み込まれていないのか確認するためここに記述
//   // 新規投稿・編集ページのフォームを取得
//   const postForm = document.getElementById('new_post');
//   // プレビューを表示するためのスペースを取得
//   const previewList = document.getElementById('previews');
  
//   // 新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。
//   if (!postForm) return null;


  //  // input要素を取得:「ファイルを選択」のボタンがあるところ
  //  const fileField = document.querySelector('input[type="file"][name="item[images][]"]'); //[images][] :複数枚の画像が配列形式で渡されるのでこの記述
  //  //１枚だけ投稿の記述：const fileField = document.querySelector('input[type="file"][name="item[image]"]');

  //  // input要素で値の変化が起きた際に呼び出される関数
  //  fileField.addEventListener('change', function(e){

    // // data-index（何番目を操作しているか）を取得
    // const dataIndex = e.target.getAttribute('data-index');

    //  // 古いプレビューが存在する場合は削除 :記述しないと前の画像そのまま残ってどんどん増える
    // const alreadyPreview = document.querySelector('.preview'); //preview :プレビューとして表示されている画像についた親のclass名
    // if (alreadyPreview) {
    //   alreadyPreview.remove();
    // };

    //  const file = e.target.files[0]; //イベントが発火した部分（ターゲット）のファイルの添字0番の情報を変数fileに格納
    
    //  const blob = window.URL.createObjectURL(file);
    
    //  // 画像を表示するためのdiv要素を生成
    // const previewWrapper = document.createElement('div'); //タグ<div></div>が生成
    // previewWrapper.setAttribute('class', 'preview'); //previewという名前のclassを生成
    // previewWrapper.setAttribute('data-index', dataIndex); //data-indexの中に変数dataIndexの値を格納 :何番目の画像を出すか指定する必要があるため
    
    // // 表示する画像を生成
    // const previewImage = document.createElement('img'); //タグ<img>を生成
    // previewImage.setAttribute('class', 'preview-image'); //preview-imageという名前のclassを生成
    // previewImage.setAttribute('src', blob); //imgタグができたので、src属性を必ずつける=変数blobの情報
  
    // // 生成したHTMLの要素をブラウザに表示させる
    // previewWrapper.appendChild(previewImage); //<div></div>と<img> → <div><img></div>に変更(＝親：div 子：img)
    // previewList.appendChild(previewWrapper); //変数previewList：先にビューファイルに入れておいた id = previewsのタグ
  
    // // 2枚目用のfile_field（「ファイルを選択」ボタン）を作成
    // const newFileField = document.createElement('input'); //input属性を作る
    // newFileField.setAttribute('type', 'file'); //type属性をfileで指定する
    // newFileField.setAttribute('name', 'item[images][]'); //name属性をitem[images][]で指定する

    // // 最後のfile_fieldを取得
    // const lastFileField = document.querySelector('input[type="file"][name="item[images][]"]:last-child');
    // // nextDataIndex = 最後のfile_fieldのdata-index + 1
    // const nextDataIndex = Number(lastFileField.getAttribute('data-index')) +1; //最後の番号に１を足して、次の番号を作っている
    // newFileField.setAttribute('data-index', nextDataIndex); //上の記述で出来た番号をdata-indexに格納して設置

    // // 生成したfile_fieldを表示
    // const fileFieldsArea = document.querySelector('.click-upload'); //click-upload :「ファイルを選択」ボタン・「クリックして...」を全て含めた部分
//     // fileFieldsArea.appendChild(newFileField); //click-uploadクラスに子要素としてnewFileFieldを入れる
//   });
// });