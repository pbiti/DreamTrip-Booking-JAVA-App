package net.javaguides.todoapp.utils;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DbConnect {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup("jdbc/upload_files");
            conn = (Connection) ds.getConnection();
        } catch (NamingException ex) {
        } catch (SQLException ex) {
        }
        return conn;
    }
}