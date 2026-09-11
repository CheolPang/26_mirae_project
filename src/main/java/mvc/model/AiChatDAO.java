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
