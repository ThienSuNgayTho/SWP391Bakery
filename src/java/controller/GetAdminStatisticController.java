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
import java.time.LocalDate;
import java.util.Collections;
import java.util.LinkedHashMap;
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
@WebServlet(name = "GetAdminStatisticController", urlPatterns = {"/GetAdminStatisticController"})
public class GetAdminStatisticController extends HttpServlet {
    private final String ADMIN_HOME_PAGE = "HomeAdmin.jsp";
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
        String url = ADMIN_HOME_PAGE;

        try {
            System.out.println("Admin Servlet: " + request.getServletPath());
            //Get current date and the date 7 days ago
            long millis = System.currentTimeMillis();
            java.sql.Date date2 = new java.sql.Date(millis);
            String DateString = String.valueOf(date2);
            LocalDate dateLocal1 = LocalDate.parse(DateString);
            LocalDate dateLocal2 = dateLocal1.minusDays(7);
            java.sql.Date date1 = java.sql.Date.valueOf(dateLocal2);

            //Get stat for User in the past 7 days
            UserDAO dao = new UserDAO();
            int activeAccount = dao.getActiveAccount();
            request.setAttribute("ACTIVE_ACCOUNT", activeAccount);
            
            int deactivatedAccount = dao.getDeactivatedAccount();
            request.setAttribute("DEACTIVATED_ACCOUNT", deactivatedAccount);
            
            int newUser = dao.totalOfNewUserInOneWeek(date1, date2);
            request.setAttribute("NEW_USER", newUser);

            LinkedHashMap<Date, Integer> detailTraffic = new LinkedHashMap<Date, Integer>();
            for (int i = 6; i >=0 ; i--) {
                //Get time
                long milli = System.currentTimeMillis();
                java.sql.Date date2nd = new java.sql.Date(milli);
                String DateString2 = String.valueOf(date2nd);
                LocalDate dateLocal1st = LocalDate.parse(DateString2);
                LocalDate dateLocal2nd = dateLocal1st.minusDays(i);
                java.sql.Date date = java.sql.Date.valueOf(dateLocal2nd);
                //Get New User for the day
                int newUser1Day = dao.getNewUserForOneDay(date);
                //Add the info to the hash map
                detailTraffic.put(date, newUser1Day);
            }
            request.setAttribute("DETAIL_TRAFFIC", detailTraffic);
            LinkedHashMap maxMap = detailTraffic;
            request.setAttribute("MAX_TRAFFIC", Collections.max(maxMap.values()));

        } 
        catch (SQLException ex) {
            log("GetAdminStatisticController_SQL: " + ex.getMessage());
        }
        catch(NamingException ex){
            log("GetAdminStatisticController_Naming: " + ex.getMessage());
        }
        finally {
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
