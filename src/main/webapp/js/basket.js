function changeQty(delta) {
	const qty = document.querySelector("#qty");
	const max = parseInt(qty.max, 10) || 1;
	let value = (parseInt(qty.value, 10) || 1) + delta;
	if (value < 1) value = 1;
	if (value > max) value = max;
	qty.value = value;

	const price = parseInt(document.addForm.dataset.price, 10) || 0;
	document.querySelector("#totalPrice").textContent = (price * value).toLocaleString("ko-KR") + "원";
}

function addToCart(confirmMsg) {
	if (confirmMsg && !confirm(confirmMsg)) return;
	document.addForm.buy.value = "";
	document.addForm.submit();
}

function buyNow() {
	document.addForm.buy.value = "now";
	document.addForm.submit();
}
