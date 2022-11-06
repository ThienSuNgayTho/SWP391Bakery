/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import order.OrderDAO;
import order.OrderDTO;
import orderItem.OrderItemDTO;
import product.ProductDAO;
import product.ProductDTO;
import user.UserDTO;

/**
 *
 * @author Dang Minh Quan
 */
@WebServlet(name = "PurchaseController", urlPatterns = {"/PurchaseController"})
public class PurchaseController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PurchaseController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PurchaseController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession ss = request.getSession();
        HashMap<ProductDTO, Integer> productMap = (HashMap<ProductDTO, Integer>) ss.getAttribute("productList");
        List<OrderItemDTO> itemList = new ArrayList<>();
        int orderId = new OrderDAO().getLastOrderID();
        double total = 0;
        boolean isValid = true;
        HashMap<ProductDTO, Integer> validProduct = (HashMap<ProductDTO, Integer>) productMap.clone();
        for (ProductDTO item : productMap.keySet()) {
            if (new ProductDAO().getCurrentStock(item.getId()) - productMap.get(item) < 0) {
                validProduct.remove(item);
                isValid = false;
            } else {
                if(!item.getSaleStatus()){
                     itemList.add(new OrderItemDTO(0, item.getId(), productMap.get(item), item.getOriginalSalePrice()*productMap.get(item)));
                     total += item.getOriginalSalePrice()*productMap.get(item);
                }
                if(item.getSaleStatus()){
                     itemList.add(new OrderItemDTO(0, item.getId(), productMap.get(item), item.getSalePrice()*productMap.get(item)));
                     total += item.getSalePrice()*productMap.get(item);
                }
            }

        }
        total += Integer.parseInt(ss.getAttribute("shippingFee").toString());
//        If a item list is valid => Update database
        if (isValid) {
            // Pay by VnPay
            if (request.getParameter("paymentMethod") == null && request.getParameter("vnp_ResponseCode").equals("00")) {
                OrderDAO orderDao = new OrderDAO();
                Calendar c = Calendar.getInstance();
                Date createDate = new Date(c.getTimeInMillis());
                UserDTO currentUser = (UserDTO) ss.getAttribute("CURRENT_USER");
                System.out.println(total);
                orderDao.createOrder(new OrderDTO(0, currentUser.getEmail(), "submitted", null, createDate, total), itemList, ss.getAttribute("shippingAddress").toString(), Float.parseFloat(ss.getAttribute("shippingFee").toString()), true);
                ss.setAttribute("productList", null);
                ss.setAttribute("NUMBER_CART", null);
                ss.setAttribute("shippingFee", null);
                ss.setAttribute("shippingAddress", null);
                int id = orderDao.getLastUserOrderID(currentUser.getEmail());
                System.out.println(id);
                response.sendRedirect("Success.jsp?orderId=" + id);
            } else {
                if (request.getParameter("paymentMethod") == null && !request.getParameter("vnp_ResponseCode").equals("00")) {
                    response.sendRedirect("Fail.jsp");
                } else {
                    if (request.getParameter("paymentMethod").equals("VNPAY") && request.getParameter("paymentMethod") != null) {
                        int total1 = (int) total;
                        request.setAttribute("total", total1);
                        request.getRequestDispatcher("OrderInform.jsp").forward(request, response);
                    } else {
                        // Pay by cash
                        OrderDAO orderDao = new OrderDAO();
                        Calendar c = Calendar.getInstance();
                        Date createDate = new Date(c.getTimeInMillis());
                        UserDTO currentUser = (UserDTO) ss.getAttribute("CURRENT_USER");
                        System.out.println(total);
                        orderDao.createOrder(new OrderDTO(1, currentUser.getEmail(), "submitted", null, createDate, total), itemList, ss.getAttribute("shippingAddress").toString(), Float.parseFloat(ss.getAttribute("shippingFee").toString()), false);
                        ss.setAttribute("productList", null);
                        ss.setAttribute("NUMBER_CART", null);
                        ss.setAttribute("shippingFee", null);
                        ss.setAttribute("shippingAddress", null);
                        int id = orderDao.getLastUserOrderID(currentUser.getEmail());
                        System.out.println(id);
                        response.sendRedirect("Success.jsp?orderId=" + id);
                    }
                }
            }
        } else {
            request.setAttribute("isValid", false);
            ss.setAttribute("productList", validProduct);
            request.getRequestDispatcher("Cart.jsp").forward(request, response);
        }

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
//        HttpSession ss = request.getSession();
//        HashMap<ProductDTO,Integer> productMap = (HashMap<ProductDTO, Integer>)ss.getAttribute("productList");
//        List<OrderItemDTO> itemList = new ArrayList<>();
//        int orderId = new OrderDAO().getLastOrderID();
//        double total = 0;
//        for (ProductDTO item : productMap.keySet()) {
//            itemList.add(new OrderItemDTO(0, item.getId(), productMap.get(item), item.getSalePrice()*productMap.get(item)));
//            total += item.getSalePrice()*productMap.get(item);
//        }
//        OrderDAO orderDao = new OrderDAO();
//        Calendar c = Calendar.getInstance();
//        Date createDate = new Date(c.getTimeInMillis());
//        UserDTO currentUser = (UserDTO) ss.getAttribute("CURRENT_USER");
//        String address = request.getParameter("address");
//        orderDao.createOrder(new OrderDTO(0, "user@fpt.edu.vn", "pending", "sale@fpt.edu.vn", new Date(Calendar.getInstance().getTimeInMillis()),total), itemList, address, shipPrice);
//        ss.setAttribute("productList", null);
//        ss.setAttribute("NUMBER_CART", 0);
//        int id = orderDao.getLastUserOrderID(currentUser.getEmail());
//        String url = "getOrderDetail?orderId=" + id;
//        response.sendRedirect(url);
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
