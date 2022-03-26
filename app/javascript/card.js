const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // 環境変数を読み込む
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => { // イベント発火
    e.preventDefault();
    // カード情報の取得先
    const formResult = document.getElementById("charge-form");
    //charge-form :カード登録の入力フォーム（form_with内に記述した）に付与されているid名 
    const formData = new FormData(formResult);

        const card = { // カードオブジェクトを生成
          number: formData.get("number"),              // カード番号
          cvc: formData.get("cvc"),                    // カード裏面の3桁の数字
          exp_month: formData.get("exp_month"),        // 有効期限の月
          exp_year: `20${formData.get("exp_year")}`,   // 有効期限の年
        };
          Payjp.createToken(card, (status, response) => {
            if (status === 200) {
              const token = response.id;
              const renderDom = document.getElementById("charge-form");   //idを元に要素を取得
              const tokenObj = `<input value=${token} name='card_token' type="hidden">`;   //paramsの中にトークンを含める
              renderDom.insertAdjacentHTML("beforeend", tokenObj);  //フォームの一番最後に要素を追加
          }   
          document.getElementById("number").removeAttribute("name");
          document.getElementById("cvc").removeAttribute("name");
          document.getElementById("exp_month").removeAttribute("name");
          document.getElementById("exp_year").removeAttribute("name");
           //number~exp_yearの４つの情報をname属性を指定して消去
           //→入力されたカード情報の各値をparamsに含まれないようにする

           document.getElementById("charge-form").submit();
           //PAY.JPから送られたトークンをコントローラーに送信
      });
    });
  };

window.addEventListener("load", pay);
// 最後に、これまで記述した関数は全て「定数pay」に代入
// したがって、こちらが起動するようにする