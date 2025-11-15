/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReaderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Reader;
import model.ReaderCard;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ReaderServlet", urlPatterns = {"/ReaderServlet"})
public class ReaderServlet extends HttpServlet {
    
    private ReaderDAO readerDAO;

    public void init() {
        readerDAO = new ReaderDAO();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReaderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReaderServlet at " + request.getContextPath() + "</h1>");
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

        String readerCodeRaw = request.getParameter("readerCode");
        if (readerCodeRaw == null || readerCodeRaw.trim().isEmpty()) {
            request.setAttribute("error", "Please enter a reader ID before searching.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("view/libraryStaff/SearchReader.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(readerCodeRaw);
            ArrayList<Reader> searchResult = readerDAO.searchReader(id);

            request.setAttribute("result", searchResult);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Reader ID must be a valid number.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("view/libraryStaff/SearchReader.jsp");
        dispatcher.forward(request, response);
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate dob = LocalDate.parse(dateOfBirthStr, formatter);
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        
        Reader reader = new Reader();
        reader.setUsername(username);
        reader.setPassword(password);
        reader.setFullName(fullName);
        reader.setDateOfBirth(dob);
        reader.setAddress(address);
        reader.setPhoneNumber(phoneNumber);
        
        ReaderCard readerCard = new ReaderCard();

        boolean result = readerDAO.addReader(reader, readerCard);
        
        if (result) {
            request.setAttribute("message", "Reader added successfully!");
        } else {
            request.setAttribute("message", "Fail to register. Please try again.");
        }
        
        request.getRequestDispatcher("view/reader/RegisterCard.jsp").forward(request, response);
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
