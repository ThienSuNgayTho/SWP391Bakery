/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import category.CategoryDAO;
import category.CategoryDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import product.ProductDAO;
import product.ProductDTO;
import user.UserDAO;
import user.UserDTO;

/**
 *
 * @author User
 */
@WebServlet(name = "ManageUserController", urlPatterns = {"/ManageUserController"})
public class ManageUserController extends HttpServlet {
    private final String USER_MANAGE_PAGE = "manageAccount.jsp";
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
//        //get the fucking user right now
//            UserDAO dao = new UserDAO();
//
//            //return object
//            List<UserDTO> listU;
//            //filter key words inputed by user
//            try {
////                String KeyWord = request.getParameter("filter");
////                KeyWord = KeyWord.trim();
//;
////                if (KeyWord.equals("")) {
//                    listU = dao.getAllUser();
////                } else {
////                    String[] keys = KeyWord.split(" ");
////                    listU = dao.getUsersWithFilter(keys);
////                }
//                //seperate key words by "[empty space]"
//                request.setAttribute("listU", listU);
////                session.setAttribute("user", u);
//
//                request.getRequestDispatcher("manageAccount.jsp").forward(request, response);
//
//            } catch (Exception E) {
//                //should an exception is caught, return every users from the database
//                listU = dao.getAllUser();
//                request.setAttribute("listU", listU);
//                request.getRequestDispatcher("manageAccount.jsp").forward(request, response);
//            }

                String url = USER_MANAGE_PAGE;
        
        try {
            
            UserDAO dao = new UserDAO();
            String indexString = request.getParameter("index");
            if (indexString == null) {
                indexString = "1";
            }
            int index = Integer.parseInt(indexString);
            int maxPages = dao.getMaxPagesBy10();

            List<UserDTO> userList = dao.getAllUser(index);
            request.setAttribute("ACCOUNT_LIST", userList);
            request.setAttribute("maxPages", maxPages);
            request.setAttribute("index", index);
            
        } catch (SQLException ex) {
            log("ManageUserController _ SQL " + ex.getCause());
        } catch (NamingException ex) {
            log("ManageUserController _ Naming " + ex.getCause());
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
