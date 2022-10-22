/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import user.UserDAO;

/**
 *
 * @author dell
 */
@WebServlet(name = "SignUpController", urlPatterns = {"/SignUpController"})
public class SignUpController extends HttpServlet {

    private final String ERROR_PAGE = "Registration.jsp";
    private final String SUCCESS_PAGE = "Login.jsp";

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

        String url = ERROR_PAGE;

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");

        boolean statusBoolean = true;

        try {

            UserDAO dao = new UserDAO();
            Date creationDate = dao.getCurrentDate();
            boolean result = dao.addNewAccount(email, password, address, fullName, phoneNumber, gender, creationDate, statusBoolean, 3);

            if (result) {
                System.out.println("True");
                String successMessage = "Register Successfully!";
                request.setAttribute("REGIS_SUCCESS_MESSAGE", successMessage);
                url = SUCCESS_PAGE;
            } else {
                System.out.println("False");
//                String errorMessage = "This Email is already Registered!";
//                request.setAttribute("REGIS_ERROR_MESSAGE", errorMessage);
//                request.setAttribute("EMAIL", email);
//                request.setAttribute("PASSWORD", password);
//                request.setAttribute("FULLNAME", fullName);
//                request.setAttribute("PHONENUMBER", phoneNumber);
//                request.setAttribute("ADDRESS", address);
            }

        } catch (SQLException ex) {
            log("SignUpController _ SQL: " + ex.getCause());
            String errorMessage = "This Email is already Registered!";
            request.setAttribute("REGIS_ERROR_MESSAGE", errorMessage);
            request.setAttribute("EMAIL", email);
            request.setAttribute("PASSWORD", password);
            request.setAttribute("FULLNAME", fullName);
            request.setAttribute("PHONENUMBER", phoneNumber);
            request.setAttribute("ADDRESS", address);
        } catch (NamingException ex) {
            log("SignUpController _ Naming: " + ex.getCause());
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
