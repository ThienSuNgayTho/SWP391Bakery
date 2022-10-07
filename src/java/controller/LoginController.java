/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserDAO;
import user.UserDTO;

/**
 *
 * @author RiceShower
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private final String HOME_PAGE = "HomeController";
    private final String HOME_PAGE_MARKETING = "GetMarketingStatisticController";
    private final String HOME_PAGE_SALE = "GetSaleStatisticController";
    private final String HOME_PAGE_ADMIN = "GetAdminStatisticController";
    private final String LOGIN_PAGE = "Login.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String email = request.getParameter("txtEmail");
        String password = request.getParameter("txtPassword");
        String url = LOGIN_PAGE; //the default page is Login.jsp for Login function
        //if failed then user will come back here

        try {
            //login through UserDAO
            UserDAO dao = new UserDAO();
            UserDTO result = dao.checkLogin(email, password);

            //check the result of the login and proccess acorddingly
            if (result != null) {
                //create cookie for the current user
                Cookie cookie = new Cookie(email, password);
                cookie.setMaxAge(60);
                response.addCookie(cookie);

                if (result != null) {
                    //create seesion to save information of the current user
                    HttpSession session = request.getSession();
                    session.setAttribute("CURRENT_USER", result);
                    //if the user is customer redirect to homepage
                    if (result.getRole().getRoleId() == 3) {
                        url = HOME_PAGE;
                    }
                    //if the user is admin redirect to admin homepage
                    if (result.getRole().getRoleId() == 0) {
                        url = HOME_PAGE_ADMIN;
                    }
                    //if the user is sale redirect to sale homepage
                    if (result.getRole().getRoleId() == 2) {
                        url = HOME_PAGE_SALE;
                    }
                    //if the user is marketing redirect to marketing homepage
                    if (result.getRole().getRoleId() == 1) {
                        url = HOME_PAGE_MARKETING;
                    }
                } else {
                    String errorMessage = "Wrong Email or Password!";
                    request.setAttribute("LOGIN_ERROR_MESSAGE", errorMessage);
                    request.setAttribute("EMAIL", email);
                    request.setAttribute("PASSWORD", password);
                }
            } else {
                String errorMessage = "Wrong Email or Password!";
                request.setAttribute("LOGIN_ERROR_MESSAGE", errorMessage);
                request.setAttribute("EMAIL", email);
                request.setAttribute("PASSWORD", password);
            }
        } catch (NamingException ex) {
            log("LoginServlet_Naming: " + ex.getMessage());
        } catch (SQLException ex) {
            log("LoginServlet_SQL: " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
