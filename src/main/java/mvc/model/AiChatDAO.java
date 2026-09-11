package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import dto.Product;
import mvc.database.DBConnection;

/**
 * AI 상품 추천 채팅 기능에 필요한 조회를 담당하는 DAO.
 * bs_purchase_history(구매 이력) + bs_product(상품 카탈로그)를 읽어서
 * AiChatController가 Ollama에 보낼 프롬프트를 구성할 수 있게 해준다.
 *
 * bs_purchase_history 테이블/스키마와 thanksCustomer.jsp는 Phase 1 산출물이며
 * 이 작업(Phase 2)에서는 건드리지 않는다. 여기서는 SELECT만 한다.
 */
public class AiChatDAO {
	private static AiChatDAO instance;

	private AiChatDAO() {
	}

	public static AiChatDAO getInstance() {
		if (instance == null) {
			instance = new AiChatDAO();
		}
		return instance;
	}

	/** 회원이 실제로 구매한 상품(카테고리/제조사 포함) 목록. 최근 구매순. */
	public List<Product> getPurchasedProducts(String id) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select p.p_id, p.p_name, p.p_unitPrice, p.p_category, p.p_manufacturer, h.quantity "
				+ "from bs_purchase_history h join bs_product p on h.p_id = p.p_id "
				+ "where h.id = ? order by h.purchase_day desc";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Product p = new Product();
				p.setProductId(rs.getString("p_id"));
				p.setPname(rs.getString("p_name"));
				p.setUnitPrice(rs.getInt("p_unitPrice"));
				p.setCategory(rs.getString("p_category"));
				p.setManufacturer(rs.getString("p_manufacturer"));
				p.setQuantity(rs.getInt("quantity"));
				list.add(p);
			}
		} catch (Exception e) {
			System.out.println("AiChatDAO.getPurchasedProducts() 에러 : " + e);
		} finally {
			closeQuietly(rs, pstmt, conn);
		}
		return list;
	}

	/** 카탈로그 전체 상품. 매장 규모가 작아서 전부 가져와 Ollama 프롬프트에 포함시킨다. */
	public List<Product> getAllProducts() {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select p_id, p_name, p_unitPrice, p_category, p_manufacturer, p_unitsInStock "
				+ "from bs_product order by p_id";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Product p = new Product();
				p.setProductId(rs.getString("p_id"));
				p.setPname(rs.getString("p_name"));
				p.setUnitPrice(rs.getInt("p_unitPrice"));
				p.setCategory(rs.getString("p_category"));
				p.setManufacturer(rs.getString("p_manufacturer"));
				p.setUnitsInStock(rs.getLong("p_unitsInStock"));
				list.add(p);
			}
		} catch (Exception e) {
			System.out.println("AiChatDAO.getAllProducts() 에러 : " + e);
		} finally {
			closeQuietly(rs, pstmt, conn);
		}
		return list;
	}

	/**
	 * 카탈로그 상품을, 구매 이력과 같은 카테고리/제조사를 가진 상품이 앞에 오도록 정렬한다.
	 * (요구사항: "구매 이력 기반 우선순위 + 전체 카탈로그"를 함께 준다 — 지나치게 좁히지 않는다)
	 */
	public List<Product> buildCandidateList(List<Product> allProducts, List<Product> purchased) {
		final Set<String> categories = new LinkedHashSet<String>();
		final Set<String> manufacturers = new LinkedHashSet<String>();
		for (Product p : purchased) {
			if (p.getCategory() != null) categories.add(p.getCategory());
			if (p.getManufacturer() != null) manufacturers.add(p.getManufacturer());
		}

		List<Product> priority = new ArrayList<Product>();
		List<Product> rest = new ArrayList<Product>();
		for (Product p : allProducts) {
			boolean matches = (p.getCategory() != null && categories.contains(p.getCategory()))
					|| (p.getManufacturer() != null && manufacturers.contains(p.getManufacturer()));
			if (matches) {
				priority.add(p);
			} else {
				rest.add(p);
			}
		}
		priority.addAll(rest);
		return priority;
	}

	private void closeQuietly(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
