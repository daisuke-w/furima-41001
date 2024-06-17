const pay = () => {
  // Payjp公開鍵取得
  const publicKey = gon.public_key;
  const pay_jp = Payjp(publicKey);
  // Payjpインスタンス作成
  const elements = pay_jp.elements();
  // 入力フォーム作成
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  // html要素と作成したフォームを置き換え
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  // フォーム処理
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    pay_jp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // クレジットカード情報削除
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
