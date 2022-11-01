/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import product.ProductDAO;
import product.ProductDTO;

/**
 *
 * @author Dang Minh Quan
 */
@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));
        String jspPage = request.getParameter("jspPage");
        System.out.println(jspPage);
        String txtSearchValue = request.getParameter("txtSearchValue");
        String indexString = request.getParameter("index");
        if (indexString == null) {
            indexString = "1";
        }
        int index = Integer.parseInt(indexString);
        ProductDAO dao = new ProductDAO();
        try {
            int maxPages = dao.getMaxPagesBy8();
        } catch (SQLException ex) {

        } catch (NamingException ex) {

        }
        
        HashMap<ProductDTO, Integer> productList = new HashMap<>();
        ProductDTO product = null;
        try {
            product = new ProductDAO().getProductById(id);
        } catch (SQLException ex) {
            Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(CartController.class.getName()).log(Level.SEVERE, null, ex);
        }
        HttpSession ss = request.getSession(true);
        if (ss.getAttribute("productList") == null) {
            ss.setAttribute("productList", productList);
            ss.setAttribute("NUMBER_CART", productList.keySet().size());
            System.out.println("Number: " + productList.keySet().size());
        }
        productList = (HashMap<ProductDTO, Integer>) ss.getAttribute("productList");
        if (productList.keySet().contains(product)) {
            int quantity = productList.get(product) + 1;
            productList.put(product, quantity);
        } else {
            productList.put(product, 1);
        }
        ss.setAttribute("productList", productList);
        ss.setAttribute("NUMBER_CART", productList.keySet().size());
        System.out.println("Number: " + productList.keySet().size());
        
        if(jspPage.equalsIgnoreCase("ProductDetail")){
            String url = "productDetail?productId=" + id;
            response.sendRedirect(url);
        }
        else if(!txtSearchValue.equals("")){
            String url = "searchProduct?index=" + indexString + "&txtSearchValue=" + txtSearchValue + "&jspname=" + jspPage;
            response.sendRedirect(url);
        }
//        else if(jspPage.equalsIgnoreCase("Home")){
//            response.sendRedirect("Home");
//        }
        else{
            String referer = request.getHeader("Referer");
            String test = referer.substring(referer.lastIndexOf("/"));
            System.out.println(test);
            if(test.equalsIgnoreCase("/login")){
                response.sendRedirect("Home");
            }
            else
                response.sendRedirect(referer);
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
//        List<ProductDTO> productList = (ArrayList<ProductDTO>)ss.getAttribute("productList");
//        request.setAttribute("productList", productList);
//        request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
