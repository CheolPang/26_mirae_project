package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

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
				list.add(board);
			}
		} catch (Exception e) {
			System.out.println("getBoardList() 에러 : " + e);
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

		return x; // 선택된 총 게시글의 갯수를 리턴
	}

	// 게시판의 페이징과 검색기능+조건에 맞는 레코드 갯수를 얻어오는 함수
	public ArrayList<BoardDTO> getBoardList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 조건에 맞는 전체 글 수. 나중에 페이징을 구현할 때 이 값으로 마지막 페이지를 계산한다.
		int total_record = getListCount(items, text);

		String column = validColumn(items);
		boolean search = (column != null && hasKeyword(text));
		
		int start = (page - 1) * limit;
		//=>예)페이징 넘버가 1일 떄 start는 0,5,10...
		//페이징 넘버가 2일 떄 index는 5,10,15...
		
		int index = start  + 1;
		//=>예)페이징 넘버가 1일 떄 start는 1,6,11... (인덱스는 1로 시작함)
		//페이징 넘버가 2일 떄 index는 6,11,16... (인덱스는 6으로 시작함)
		
		
		
		String sql;
		if (search) {
			sql = "select * from bs_board where " + column + " like ? order by num desc";
		} else {
			sql = "select * from bs_board order by num desc";
		}
		System.out.println("getBoardList() sql: " + sql + " / text: " + text + " / total_record: " + total_record);

		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

			if (search) {
				pstmt.setString(1, "%" + text.trim() + "%");
			}

			rs = pstmt.executeQuery();

			while (rs.absolute(index)) {
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
				list.add(board);
				
				//페이징 로직 추가
				if(index < (start + limit) && index <= total_record) index++;
				else break;
			}

		} catch (Exception e) {
			System.out.println("getBoardList() 에러 : " + e);
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
		return list; // 저장한 게시글의 목록을 리턴
	}
	
	public String getLoginNameById(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String name = null;
		String sql = "select * from bs_member where id=?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("name");
			}
			
		} catch (Exception e) {
			System.out.println("getLoginById() 에러 : " + e);
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
		return name;
	}
	
	public void insertBoard(BoardDTO board) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBConnection.getConnection();
			String sql = "insert into bs_board values (bs_num.nextval, ?,?,?,?,?,?,sysdate,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getName());
			pstmt.setString(3, board.getSubject());
			pstmt.setString(4, board.getContent());
			pstmt.setInt(5, board.getHit());
			pstmt.setString(6, board.getIp());

			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("insertBoard() 에러 : " + e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public BoardDTO getBoardByNum(int num, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO board = null;
		
		//updateHit(num);
		String sql = "select * from bs_board where num=?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setUpdate_day(rs.getString("update_day"));
			}
			
		} catch (Exception e) {
			System.out.println("getBoardByNum() 에러 : " + e);
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
		return board;
	}
	
	public void updateBoard(BoardDTO board) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			String sql = "update bs_board set subject=?, content=?, update_day=sysdate where num=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("updateBoard() 에러 : " + e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void deleteBoard(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DBConnection.getConnection();
			String sql = "delete from bs_board where num=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteBoard() 에러 : " + e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void updateHit(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();
			String sql = "update bs_board set hit = hit+1 where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateHit() 에러 : " + e);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
}



