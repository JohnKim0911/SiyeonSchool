package com.kh.home.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.home.model.service.HomeService;
import com.kh.home.model.vo.Curriculum;

/**
 * Servlet implementation class HomeController
 */
@WebServlet("/home")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Curriculum> list = new HomeService().selectCurriculum();

		int completedCount = new HomeService().getCompletedCount();
		int totalCount = new HomeService().getTotalCount();
		int progressValue = (int)((completedCount / (double)totalCount) * 100);
		
		request.getSession().setAttribute("currentPage", "home");
		request.setAttribute("list", list);
		request.setAttribute("progressValue", progressValue);
		request.getRequestDispatcher("views/home/home.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
