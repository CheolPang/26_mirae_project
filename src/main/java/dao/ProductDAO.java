package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Product;
import mvc.database.DBConnection;

public class ProductDAO {
	private static ProductDAO instance = new ProductDAO();

	private ProductDAO() {

	}

	public static ProductDAO getInstance() {
		return instance;
	}

	// 전체 상품 목록 (상품 코드 순)
	public ArrayList<Product> getAllProducts() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<Product> list = new ArrayList<Product>();
		String sql = "select * from bs_product order by p_id";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(toProduct(rs));
			}
		} catch (Exception e) {
			System.out.println("getAllProducts() 에러 : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 최근 등록 상품 N개 (상품 코드 역순 - 등록일 컬럼이 없어 p_id를 기준으로 삼는다)
	public ArrayList<Product> getRecentProducts(int limit) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		ArrayList<Product> list = new ArrayList<Product>();
		String sql = "select * from (select * from bs_product order by p_id desc) where rownum <= ?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, limit);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(toProduct(rs));
			}
		} catch (Exception e) {
			System.out.println("getRecentProducts() 에러 : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	// 상품 코드로 한 개 조회. 없으면 null
	public Product getProductById(String productId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		Product product = null;
		String sql = "select * from bs_product where p_id=?";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				product = toProduct(rs);
			}
		} catch (Exception e) {
			System.out.println("getProductById() 에러 : " + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return product;
	}

	private Product toProduct(ResultSet rs) throws SQLException {
		Product product = new Product();
		product.setProductId(rs.getString("p_id"));
		product.setPname(rs.getString("p_name"));
		product.setUnitPrice(rs.getInt("p_unitPrice"));
		product.setDescription(rs.getString("p_description"));
		product.setCategory(rs.getString("p_category"));
		product.setManufacturer(rs.getString("p_manufacturer"));
		product.setUnitsInStock(rs.getLong("p_unitsInStock"));
		product.setCondition(rs.getString("p_condition"));
		product.setFilename(rs.getString("p_fileName"));
		return product;
	}
}
