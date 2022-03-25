document.addEventListener("DOMContentLoaded", () => {
  const tagNameInput = document.querySelector("#item_tag_form_tag_name"); //タグの入力フォームのidを取得
      if (tagNameInput){
        const inputElement = document.getElementById("item_tag_form_tag_name");
      inputElement.addEventListener("input", () => {
        const keyword = document.getElementById("item_tag_form_tag_name").value;
        const XHR = new XMLHttpRequest(); //XMLHttpRequest(); :任意のHTTPリクエストを送信できる
        XHR.open("GET", `/items/search/?keyword=${keyword}`, true); //searchアクションへリクエストを送る
          //リクエストを定義するために、openメソッドを使用
          //第一引数にHTTPメソッド、第二引数にURL、第三引数には非同期通信であることを示すためにtrueを指定
        XHR.responseType = "json";
        XHR.send();
        XHR.onload = () => {
            const searchResult = document.getElementById("search-result");
            searchResult.innerHTML = ""; //直前に表示されたままのタグを消すため :インクリ...をしたときに同じ文字列がひたすら出続ける現象を解決
            if (XHR.response) { //条件分岐 :レスポンスにデータが存在する場合のみ、タグを表示できるようにしている
            const tagName = XHR.response.keyword;
            tagName.forEach((tag) => {
              const childElement = document.createElement("div");
              childElement.setAttribute("class", "child");
              childElement.setAttribute("id", tag.id);
              childElement.innerHTML = tag.tag_name;
              searchResult.appendChild(childElement);
              const clickElement = document.getElementById(tag.id);
              clickElement.addEventListener("click", () => {
                document.getElementById("item_tag_form_tag_name").value = clickElement.textContent;
                clickElement.remove();
              });
            });
          };
        };
      });
    };
  });

  //参考:レスポンスにデータが存在するときだけタグを表示する機能の実装前
  //  *省略*
  //   XHR.onload = () => {
//     const tagName = XHR.response.keyword;
//     const searchResult = document.getElementById("search-result");
//     searchResult.innerHTML = ""; //直前に表示されたままのタグを消すため :インクリ...をしたときに同じ文字列がひたすら出続ける現象を解決
//     tagName.forEach((tag) => {
//       const childElement = document.createElement("div");
//       childElement.setAttribute("class", "child");
//       childElement.setAttribute("id", tag.id);
//       childElement.innerHTML = tag.tag_name;
//       searchResult.appendChild(childElement);
//       const clickElement = document.getElementById(tag.id);
//       clickElement.addEventListener("click", () => {
//         document.getElementById("item_tag_form_tag_name").value = clickElement.textContent;
//         clickElement.remove();
//       });
//     });
// };
// *以下省略*