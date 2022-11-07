/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import order.OrderDAO;
import user.UserDTO;

/**
 *
 * @author RiceShower
 */
@WebServlet(name = "SetOrderStatusController", urlPatterns = {"/SetOrderStatusController"})
public class SetOrderStatusController extends HttpServlet {

    private final String PENDING_ORDER_PAGE = "getPendingOrder";
    private final String ASSIGNED_ORDER_PAGE = "getAssignedOrder";

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
        //Get the sale email
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("CURRENT_USER");
        String saleEmail = user.getEmail();
        //get OrderId
        String id = request.getParameter("id");
        String currentPage = request.getParameter("currentPage");
        int orderId = Integer.parseInt(id.trim());
        String status = request.getParameter("status").toLowerCase();
        String url = PENDING_ORDER_PAGE;

        try {
            OrderDAO orderDao = new OrderDAO();
            boolean result = orderDao.setOrderStatus(saleEmail, orderId, status);
            if (result) {
                if (currentPage.equalsIgnoreCase("pending")) {
                    url = PENDING_ORDER_PAGE;
                }
                if (currentPage.equalsIgnoreCase("assigned")) {
                    url = ASSIGNED_ORDER_PAGE;
                }
                if (currentPage.equalsIgnoreCase("detail")) {
                    url = "getOrderDetail?"
                            + "orderId=" + id;
                }
            }
        } catch (SQLException ex) {
            log("SetOrderStatusCancelController_SQL: " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
