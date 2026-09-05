function checkAddProduct(){
	/*
	[1] 상품 아이디: 첫글자를 P로 시작하고 숫자를 조합해서 5-6자리 입력
	[2] 상품명 : 최소 2자에서 최대 50자까지 입력
	[3] 상품 가격 : 숫자만 입력
	[4] 재고 수 : 숫자만 입력, 음수입력 금지
	*/
	

	
	const name = document.querySelector("#productName");
	const unitPrice = document.querySelector("#unitPrice");
	const unitsInStock = document.querySelector("#unitsInStock");
	const img = document.querySelector("#img");
	const productId = document.querySelector("#productId");
	
	function check(regExp, e, msg) {
		if(regExp.test(e.value)){
			return true;
		} else {
			alert(msg);
			e.focus();
			e.select();
			return false;
		}
	}
	
	if (!check(/^P[0-9]{4,5}$/, productId, "[상품 아이디]\n첫 글자를 P로 시작하고 숫자를 조합해서 5-6자리 입력 가능합니다.")) {
		productId.focus();
		productId.select();
		return false;
	}
	
	if(name.value.length < 2 || name.value.length > 50) {
		alert("[상품명]\n최소 2자에서 최대 50자까지만 입력 가능합니다.");
		name.focus();
		name.select();
		return false;
	}
	if(unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
		alert("[상품 가격]\n숫자만 입력 가능합니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	if(unitPrice.value <= 0) {
		alert("[상품 가격]\n0이나 음수를 입력할 수 없습니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	} else if (/\./.test(unitPrice.value)) {
		alert("[상품 가격]\n소수점은 입력할 수 없습니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	if(unitsInStock.value.length == 0 || isNaN(unitsInStock.value)) {
		alert("[재고 수]\n숫자만 입력 가능합니다.");
		unitsInStock.focus();
		unitsInStock.select();
		return false;
	}
	if(unitsInStock.value < 0) {
		alert("[재고 수]\n음수를 입력할 수 없습니다.");
		unitsInStock.focus();
		unitsInStock.select();
		return false;
	}
	if(!(img.value)) {
		alert("[이미지]\n제품의 이미지를 첨부해 주세요.");
		return false;
	}
	document.newProduct.submit();
}

function checkEditProduct(){
	/*
	[1] 상품 아이디: 첫글자를 P로 시작하고 숫자를 조합해서 5-6자리 입력
	[2] 상품명 : 최소 2자에서 최대 50자까지 입력
	[3] 상품 가격 : 숫자만 입력
	[4] 재고 수 : 숫자만 입력, 음수입력 금지
	*/
	

	
	const name = document.querySelector("#productName");
	const unitPrice = document.querySelector("#unitPrice");
	const unitsInStock = document.querySelector("#unitsInStock");
//	const img = document.querySelector("#img");
	const productId = document.querySelector("#productId");
	
	function check(regExp, e, msg) {
		if(regExp.test(e.value)){
			return true;
		} else {
			alert(msg);
			e.focus();
			e.select();
			return false;
		}
	}
	
	if (!check(/^P[0-9]{4,5}$/, productId, "[상품 아이디]\n첫 글자를 P로 시작하고 숫자를 조합해서 5-6자리 입력 가능합니다.")) {
		productId.focus();
		productId.select();
		return false;
	}
	
	if(name.value.length < 2 || name.value.length > 50) {
		alert("[상품명]\n최소 2자에서 최대 50자까지만 입력 가능합니다.");
		name.focus();
		name.select();
		return false;
	}
	if(unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
		alert("[상품 가격]\n숫자만 입력 가능합니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	if(unitPrice.value <= 0) {
		alert("[상품 가격]\n0이나 음수를 입력할 수 없습니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	} else if (/\./.test(unitPrice.value)) {
		alert("[상품 가격]\n소수점은 입력할 수 없습니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	if(unitsInStock.value.length == 0 || isNaN(unitsInStock.value)) {
		alert("[재고 수]\n숫자만 입력 가능합니다.");
		unitsInStock.focus();
		unitsInStock.select();
		return false;
	}
	if(unitsInStock.value < 0) {
		alert("[재고 수]\n음수를 입력할 수 없습니다.");
		unitsInStock.focus();
		unitsInStock.select();
		return false;
	}
//	if(!(img.value)) {
//		alert("[이미지]\n제품의 이미지를 첨부해 주세요.");
//		return false;
//	}
	document.updateProduct.submit();
}