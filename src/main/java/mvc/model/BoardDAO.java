package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class BoardDAO {
	private static BoardDAO instance;

	private BoardDAO() {

	}

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	// 검색 대상 컬럼명은 SQL에 직접 붙여야 하므로(? 바인딩 불가)
	// 허용된 컬럼인지 반드시 확인한다. 허용되지 않으면 null(=검색 안 함)로 처리한다.
	private String validColumn(String items) {
		if ("subject".equals(items) || "content".equals(items) || "name".equals(items)) {
			return items;
		}
		return null;
	}

	// 검색어가 비어 있으면 검색하지 않는 것으로 본다.
	private boolean hasKeyword(String text) {
		return text != null && !text.trim().isEmpty();
	}

	// 보드 테이블의 레코드 목록 가져오는 함수
	public ArrayList<BoardDTO> getBoardList(int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from bs_board ORDER BY num DESC";

		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(makeBoardDTO(rs));
			}
		} catch (Exception e) {
			System.out.println("getBoardList() 에러 : " + e);
		} finally {
			close(rs, pstmt, conn);
		}
		return list;
	}

	// 조건에 맞는 레코드 갯수를 얻어오는 함수
	public int getListCount(String items, String text) { // items: 컬럼명, text: 검색 키워드 문자열
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0; // 선택된 총 게시글의 갯수

		String column = validColumn(items);
		boolean search = (column != null && hasKeyword(text));

		String sql;
		if (search) {
			// 검색어는 ?로 바인딩하여 SQL 인젝션을 막는다.
			sql = "select count(*) from bs_board where " + column + " like ?";
		} else {
			sql = "select count(*) from bs_board";
		}

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			if (search) {
				pstmt.setString(1, "%" + text.trim() + "%");
			}
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getListCount() 에러 : " + e);
		} finally {
			close(rs, pstmt, conn);
		}

		return x; // 선택된 총 게시글의 갯수를 리턴
	}

	// 게시판의 페이징과 검색기능+조건에 맞는 레코드 갯수를 얻어오는 함수
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String column = validColumn(items);
		boolean search = (column != null && hasKeyword(text));

		// 페이징은 아직 구현하지 않는다. page/limit 값은 받아만 두고 전체 목록을 반환한다.
		String sql;
		if (search) {
			sql = "select * from bs_board where " + column + " like ? order by num desc";
		} else {
			sql = "select * from bs_board order by num desc";
		}
		System.out.println("getBoardList() sql: " + sql + " / text: " + text);

		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);

			if (search) {
				pstmt.setString(1, "%" + text.trim() + "%");
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(makeBoardDTO(rs));
			}

		} catch (Exception e) {
			System.out.println("getBoardList() 에러 : " + e);
		} finally {
			close(rs, pstmt, conn);
		}
		return list; // 저장한 게시글의 목록을 리턴
	}

	// ResultSet 한 행을 BoardDTO로 옮겨 담는다.
	private BoardDTO makeBoardDTO(ResultSet rs) throws Exception {
		BoardDTO board = new BoardDTO();
		board.setNum(rs.getInt("num"));
		board.setId(rs.getString("id"));
		board.setName(rs.getString("name"));
		board.setSubject(rs.getString("subject"));
		board.setContent(rs.getString("content"));
		board.setHit(rs.getInt("hit"));
		board.setIp(rs.getString("ip"));
		board.setRegist_day(rs.getString("regist_day"));
		board.setUpdate_day(rs.getString("update_day"));
		return board;
	}

	private void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
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
}
