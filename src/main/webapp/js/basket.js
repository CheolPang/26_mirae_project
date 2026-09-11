// 상품 상세(product.jsp)의 구매 영역

// 수량 +/- (delta 0 은 직접 입력한 값을 범위 안으로 맞출 때)
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

// confirmMsg: 담기 전 확인창에 띄울 문구 (다국어 처리를 위해 호출하는 JSP에서 넘겨준다).
function addToCart(confirmMsg) {
	if (confirmMsg && !confirm(confirmMsg)) return;
	document.addForm.buy.value = "";
	document.addForm.submit();
}

// 장바구니에 담고 바로 장바구니 화면으로 이동
function buyNow() {
	document.addForm.buy.value = "now";
	document.addForm.submit();
}
