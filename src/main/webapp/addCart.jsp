<%@page import="java.util.ArrayList"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("products.jsp");
		return;
	}

	// 상품 정보를 DB(bs_product)에서 조회한다.
	// 장바구니에는 조회 결과로 만든 새 객체를 담는다.
	Product goods = ProductDAO.getInstance().getProductById(id);
	if(goods == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
		return;
	}

	// 상세 페이지에서 고른 수량 (없거나 잘못된 값이면 1개)
	int qty = 1;
	try {
		qty = Integer.parseInt(request.getParameter("qty"));
	} catch (NumberFormatException e) {
		qty = 1;
	}
	if (qty < 1) qty = 1;

	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
	if(list == null) {
		list = new ArrayList<Product>();
		session.setAttribute("cartlist", list);
	}

	// 이미 담긴 상품이면 수량만 늘린다.
	int cnt = 0;
	for (int i=0; i<list.size(); i++){
		Product goodsQnt = list.get(i);
		if(goodsQnt.getProductId().equals(id)) {
			cnt++;
			goodsQnt.setQuantity(goodsQnt.getQuantity() + qty);
			break;
		}
	}

	if(cnt == 0){
		goods.setQuantity(qty);
		list.add(goods);
	}

	// 바로구매는 장바구니로, 장바구니 담기는 상세 페이지로 돌아가 안내 문구를 띄운다
	if ("now".equals(request.getParameter("buy"))) {
		response.sendRedirect("cart.jsp");
	} else {
		response.sendRedirect("product.jsp?id=" + id + "&added=1");
	}
%>
