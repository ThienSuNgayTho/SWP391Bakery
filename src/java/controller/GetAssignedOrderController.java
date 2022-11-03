/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import order.OrderDAO;
import order.OrderSaleDTO;
import user.UserDTO;

/**
 *
 * @author RiceShower
 */
@WebServlet(name = "GetAssignedOrderController", urlPatterns = {"/GetAssignedOrderController"})
public class GetAssignedOrderController extends HttpServlet {

    private final String ASSIGNED_ORDER_PAGE = "AssignedOrder.jsp";
    private final String DELIVER_ORDER_PAGE = "DeliverOrder.jsp";

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
        String currentPage = request.getParameter("currentPage");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("CURRENT_USER");
        String saleEmail = user.getEmail();
        String url = ASSIGNED_ORDER_PAGE;

        try {
            //get the order that has yet been approved / still pending
            OrderDAO orderDao = new OrderDAO();
            orderDao.getAssignedOrder(saleEmail);
            orderDao.getDeliverOrder(saleEmail);

            /*Get all the approved orders*/
            List<OrderSaleDTO> resultApprovedOrder = orderDao.getAssignedOrderList();
            request.setAttribute("APPROVED_ORDER", resultApprovedOrder);

            /*Get all the order currently delivering*/
            List<OrderSaleDTO> resultDeliverOrder = orderDao.getDeliverOrderList();
            request.setAttribute("DELIVER_ORDER", resultDeliverOrder);
            if (currentPage.trim().equalsIgnoreCase("assigned")) {
                url = ASSIGNED_ORDER_PAGE;
            } else if (currentPage.trim().equalsIgnoreCase("deliver")) {
                url = DELIVER_ORDER_PAGE;
            }
        } catch (SQLException ex) {
            log("GetAssignedOrderController_SQL: " + ex.getMessage());
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
