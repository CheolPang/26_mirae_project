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

	Product goods = ProductDAO.getInstance().getProductById(id);
	if(goods == null) {
		response.sendRedirect("exceptionNoProductId.jsp");
		return;
	}

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

	if ("now".equals(request.getParameter("buy"))) {
		response.sendRedirect("cart.jsp");
	} else {
		response.sendRedirect("product.jsp?id=" + id + "&added=1");
	}
%>
