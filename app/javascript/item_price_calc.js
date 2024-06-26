function priceCalc() {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (itemPrice) {
    itemPrice.addEventListener("input", () => {
      const inputValue = itemPrice.value;
      const tax = 0.1;
      const fee = Math.floor(inputValue * tax);
  
      addTaxPrice.innerText = fee;
      profit.innerText = Math.floor(inputValue - fee);
    });
  };
};

window.addEventListener('turbo:load', priceCalc);
window.addEventListener("turbo:render", priceCalc);
