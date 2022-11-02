/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.UserDTO;
import category.CategoryDAO;
import category.CategoryDTO;

/**
 *
 * @author User
 */
@WebServlet(name = "CategoryManagingController", urlPatterns = {"/CategoryManagingController"})
public class CategoryManagingController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        //get the fucking user right now
//        HttpSession session = request.getSession();
//        UserDTO u = (UserDTO) session.getAttribute("CURRENT_USER");
//        if (u == null) {
//            request.getRequestDispatcher("home").forward(request, response);
//        }
//        //check if the user is the marketer
//        if (u.getRole().getRoleId() != 3) {
//            request.getRequestDispatcher("home.jsp").forward(request, response);
//        } else {
            CategoryDAO dao = new CategoryDAO();

            //return object
            List<CategoryDTO> listC;

            //filter key words inputed by user
            try {
                dao.getAllCategory();
                listC = dao.getCategoryList();
                request.setAttribute("listC", listC);
//                session.setAttribute("user", u);

                request.getRequestDispatcher("manageCategory.jsp").forward(request, response);

            } catch (Exception E) {
                //should an exception is caught, return the user back to home screen
                request.getRequestDispatcher("Home.jsp").forward(request, response);
            }

//        }
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
