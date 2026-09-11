package mvc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.BoardDAO;
import mvc.model.BoardDTO;

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5; // 한 페이지에 보여 줄 게시글 수
	// 글 저장 실패 시 폼 위에 띄울 문구 (bs_board.subject 100바이트 / content 1000바이트)
	static final String SAVE_FAIL_MSG = "글을 저장하지 못했습니다. 제목은 한글 33자, 내용은 한글 333자 이내로 입력해 주세요.";

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		
		String RequestURI = request.getRequestURI();
		System.out.println("RequestURI: "+RequestURI);
		
		String contextPath = request.getContextPath();
		System.out.println("contextPath: "+contextPath);
		
		// getRequestURI()는 forward("./BoardListAction.do") 시 "/./BoardListAction.do"처럼
		// 정리되지 않은 경로가 들어와 비교가 실패하므로, 항상 "/xxx.do"로 정리되는 getServletPath()를 쓴다.
		String command = request.getServletPath();
		System.out.println("command: "+command);
		
		if(command.equals("/BoardListAction.do")) {
			//함수를 만들어서 호출하고
			requestBoardList(request);
			//어디 페이지로 이동하겠다.
			RequestDispatcher rd = request.getRequestDispatcher("./board/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardWriteForm.do")) {
			requestLoginName(request);
			RequestDispatcher rd = request.getRequestDispatcher("./board/WriteForm.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardWriteAction.do")) {
			if (requestBoardWrite(request)) {
				// forward 하면 주소창이 BoardWriteAction.do 로 남아 새로고침 시 글이 또 등록되므로
				// 목록 주소로 redirect 한다 (Post/Redirect/Get)
				response.sendRedirect(contextPath + "/BoardListAction.do?pageNum=1");
			} else {
				// 저장 실패 시 목록으로 보내면 글이 조용히 사라진 것처럼 보이므로
				// 입력한 제목/내용을 그대로 둔 채 작성 폼으로 되돌린다
				request.setAttribute("errorMsg", SAVE_FAIL_MSG);
				requestLoginName(request);
				RequestDispatcher rd = request.getRequestDispatcher("./board/WriteForm.jsp");
				rd.forward(request, response);
			}
		} else if (command.equals("/BoardViewAction.do")) {
			requestBoardView(request);
			if (request.getAttribute("board") == null) {
				// 삭제됐거나 없는 글 번호면 view.jsp 에서 NullPointerException(500)이 나므로 목록으로 보낸다
				response.sendRedirect(contextPath + "/BoardListAction.do?pageNum=" + request.getAttribute("pageNum"));
				return;
			}
			RequestDispatcher rd = request.getRequestDispatcher("./board/view.jsp");
			rd.forward(request, response);
		} else if (command.equals("/BoardUpdateAction.do")) {
			if (requestBoardUpdate(request)) {
				// 글 등록과 같은 이유로 상세 보기 주소로 redirect 한다 (새로고침 시 재전송 방지)
				response.sendRedirect(contextPath + "/BoardViewAction.do?num=" + request.getAttribute("num")
						+ "&pageNum=" + request.getAttribute("pageNum"));
			} else {
				// 등록 실패와 같은 이유로, 입력한 내용을 유지한 채 수정 폼으로 되돌린다
				request.setAttribute("errorMsg", SAVE_FAIL_MSG);
				RequestDispatcher rd = request.getRequestDispatcher("./board/editForm.jsp");
				rd.forward(request, response);
			}
		}
	}
	
	public void requestBoardList(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();

		int limit = LISTCOUNT; // 한 페이지에 보여 줄 게시글 수

		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		String items = request.getParameter("items");
		String text = request.getParameter("text");
		if (text == null || text.trim().isEmpty()) {
			items = null;
			text = null;
		} else {
			text = text.trim();
		}

		int total_record = dao.getListCount(items, text); 
//		int total_page = 1; 

		List<BoardDTO> boardlist = dao.getBoardList(pageNum, limit, items, text);

		request.setAttribute("boardlist", boardlist);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_record", total_record);
//		request.setAttribute("total_page", total_page);
		
		int total_page; //게시판 총 페이지수
		if(total_record % limit == 0) {
			total_page = total_record/limit;
		} else {
			total_page = total_record/limit;
			total_page += 1;
		}
		
		request.setAttribute("total_page", total_page);
		request.setAttribute("boardlist", boardlist);
	}
	
	public void requestLoginName(HttpServletRequest request) {
		String id = request.getParameter("id");
		BoardDAO dao  = BoardDAO.getInstance();
		String name = dao.getLoginNameById(id);
		request.setAttribute("name", name);
	}
	
	public boolean requestBoardWrite(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();
		
		BoardDTO board = new BoardDTO();
		board.setId(request.getParameter("id"));
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));
		
		board.setHit(0);
		board.setIp(request.getRemoteAddr());

		return dao.insertBoard(board);
	}

	public boolean requestBoardUpdate(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		BoardDTO board = new BoardDTO();
		board.setNum(num);
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));

		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);

		return dao.updateBoard(board);
	}
	
	public void requestBoardView(HttpServletRequest request) {
		BoardDAO dao = BoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		
		dao.updateHit(num);

		BoardDTO board = new BoardDTO();
		board = dao.getBoardByNum(num, pageNum);
		
		request.setAttribute("num", num);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("board", board);
	}
}
